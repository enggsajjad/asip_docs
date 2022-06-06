-------------------------------------------------------------------------------
-- Title      : interface_asipmeister_i2c
-- Project    : 
-------------------------------------------------------------------------------
-- File       : interface_asipmeister_i2c.vhd
-- Author     :   <kraemer@I80PC03>
-- Company    : 
-- Last update: 2006/07/03
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: interface between the ASIPMeister CPU and the I2C interface core.
-- Receives strings containing data, device address etc. and demultiplexes them
-- on the according I2C interface in-/outputs
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2006/05/31  0.1      kraemer Created
-- 2006/06/20  0.2      kraemer first test with modelsim succeeded
-- 2006/06/20  0.3      kraemer read back option from I2C integrated, enhanced
--                              to cope with slow speed devices (less than one
--                              byte per clock tick written in FIFO); test with
--                              modelsim successful
-------------------------------------------------------------------------------


-------------------------------------------------------------------------------
-- Description of the used protocol
--
-- Write on I2C:
-- +                                    ---------------------------------------+
-- | string | 7bit address | string data |
-- | length | + '0' = write | sent via I2C |
-- +                                    ---------------------------------------+
--
-- Read from I2C:
-- +                                    ---------------------------------------+
-- | 0x00 | 7bit address | amount of bytes |
-- | (*) | + '1' = read | to be read |
-- +                                    ---------------------------------------+
--
-- (*) obviously the field describing the string length is oblivious in read
-- mode
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY interface_asipmeister_i2c IS

  PORT (
    clock : IN std_logic;
    reset : IN std_logic;

    -- connections to the ASIPMeister CPU
    asip_data_in  : IN  std_logic_vector (7 DOWNTO 0);
    asip_data_out : OUT std_logic_vector (7 DOWNTO 0);

    asip_rd_en    : IN  std_logic;
    asip_wr_en    : IN  std_logic;
    asip_empty    : OUT std_logic;
    asip_full     : OUT std_logic;
    asip_wr_ack   : OUT std_logic;
    asip_rd_valid : OUT std_logic;

    -- connections to the I2C interface core
    i2c_bus_data_in   : IN    std_logic_vector (7 DOWNTO 0);
    i2c_bus_data_out  : OUT   std_logic_vector (7 DOWNTO 0);
    i2c_address       : OUT   std_logic_vector (6 DOWNTO 0);
    i2c_rw            : INOUT std_logic;
    i2c_bytes_to_read : OUT   std_logic_vector (7 DOWNTO 0);

    i2c_rd_en    : OUT std_logic;
    i2c_wr_en    : OUT std_logic;
    i2c_empty    : IN  std_logic;
    i2c_full     : IN  std_logic;
    i2c_wr_ack   : IN  std_logic;
    i2c_rd_valid : IN  std_logic;

    i2c_data_valid : OUT std_logic;
    i2c_done       : IN  std_logic;

    i2c_request     : OUT std_logic;
    i2c_acknowledge : IN  std_logic;

    -- debug output
    interface_state : OUT std_logic_vector (3 DOWNTO 0);
    interface_fifo_data  : OUT std_logic_vector (7 DOWNTO 0);
    interface_fifo_rd_en : OUT std_logic;
    interface_fifo_valid : OUT std_logic
    );
END interface_asipmeister_i2c;

ARCHITECTURE interface_asipmeister_i2c_arch OF interface_asipmeister_i2c IS

  TYPE machine_state IS (idle, rd_bytes, rd_addr_rw, rd_bytes_to_read, write_data, req_i2c, wait_i2c, read_data);

  SIGNAL fifo_empty_i    : std_logic;
  SIGNAL fifo_rd_en_i    : std_logic;
  SIGNAL fifo_data_out_i : std_logic_vector(7 DOWNTO 0);
  SIGNAL fifo_valid_i    : std_logic;

-- SIGNAL fifo_full_i : std_logic;
-- SIGNAL fifo_wr_en_i : std_logic;
-- SIGNAL fifo_data_in_i : std_logic_vector(7 DOWNTO 0);
-- SIGNAL fifo_wr_ack_i : std_logic;

  COMPONENT fifo_generator_v2_1
    PORT (
      din    : IN  std_logic_vector(7 DOWNTO 0);
      rd_clk : IN  std_logic;
      rd_en  : IN  std_logic;
      rst    : IN  std_logic;
      wr_clk : IN  std_logic;
      wr_en  : IN  std_logic;
      dout   : OUT std_logic_vector(7 DOWNTO 0);
      empty  : OUT std_logic;
      full   : OUT std_logic;
      valid  : OUT std_logic;
      wr_ack : OUT std_logic);
  END COMPONENT;

BEGIN  -- interface_asipmeister_i2c_arch

  input_fifo : fifo_generator_v2_1
    PORT MAP (
      din    => asip_data_in,           -- external
      rd_clk => clock,                  -- external
      rd_en  => fifo_rd_en_i,
      rst    => reset,                  -- external
      wr_clk => clock,                  -- external
      wr_en  => asip_wr_en,             -- external
      dout   => fifo_data_out_i,
      empty  => fifo_empty_i,
      full   => asip_full,              -- external
      valid  => fifo_valid_i,
      wr_ack => asip_wr_ack);           -- external

-- output_fifo : fifo_generator_v2_1
-- PORT MAP (
-- din => fifo_data_in_i,
-- rd_clk => clock,                     -- external
--       rd_en  => asip_rd_en,          -- external
--       rst    => reset,               -- external
--       wr_clk => clock,               -- external
--       wr_en  => fifo_wr_en_i,
--       dout   => asip_data_out,       -- external
--       empty  => asip_empty,          -- external
--       full   => fifo_full_i,
--       valid  => asip_rd_valid,       -- external
--       wr_ack => fifo_wr_ack_i);

  PROCESS (clock, reset)
    VARIABLE state         : machine_state := idle;
    VARIABLE bytes_to_read : integer       := 0;

  BEGIN  -- PROCESS
    IF reset = '1' THEN                     -- asynchronous reset (active low)
      i2c_address           <= "0000000";
      i2c_bus_data_out      <= X"00";
      i2c_rw                <= '0';
      i2c_bytes_to_read     <= X"00";
      i2c_wr_en             <= '0';
      i2c_data_valid        <= '0';
      i2c_request           <= '0';
      interface_state       <= X"0";
      state := idle;
    ELSIF clock'EVENT AND clock = '1' THEN  -- rising clock edge
      CASE state IS
        WHEN idle =>
          interface_state   <= X"1";
          -- do some cleanup
          i2c_address       <= "0000000";
          i2c_bus_data_out  <= X"00";
          i2c_rw            <= '0';
          i2c_bytes_to_read <= X"00";
          i2c_wr_en         <= '0';
          i2c_data_valid    <= '0';
          i2c_request       <= '0';

          -- wait for data to be sent
          IF fifo_empty_i = '0' THEN
            state := rd_bytes;
          END IF;

        WHEN rd_bytes =>
          interface_state <= X"2";

          IF fifo_rd_en_i = '1' THEN
            fifo_rd_en_i     <= '0';
          ELSE
            IF fifo_valid_i = '0' THEN
              -- no valid data at fifo_data_out - so we start another read
              IF fifo_empty_i = '0' THEN
                fifo_rd_en_i <= '1';
              END IF;

            ELSIF fifo_valid_i = '1' THEN
              -- read amount of bytes to read from fifo
              bytes_to_read := conv_integer(fifo_data_out_i);
              state         := rd_addr_rw;
            END IF;
          END IF;

        WHEN rd_addr_rw =>
          interface_state <= X"3";

          IF fifo_rd_en_i = '1' THEN
            fifo_rd_en_i     <= '0';
          ELSE
            IF fifo_valid_i = '0' THEN
              -- no valid data at fifo_data_out - so we start another read
              IF fifo_empty_i = '0' THEN
                fifo_rd_en_i <= '1';
              END IF;

            ELSIF fifo_valid_i = '1' THEN
              -- read address and rw bit
              i2c_address <= fifo_data_out_i (7 DOWNTO 1);
              i2c_rw      <= fifo_data_out_i (0);

              -- check if read or write operation is requested
              IF fifo_data_out_i (0) = '1' THEN
                state := rd_bytes_to_read;
              ELSIF fifo_data_out_i (0) = '0' THEN
                state := write_data;
              END IF;
            END IF;
          END IF;

        WHEN rd_bytes_to_read =>
          interface_state <= X"4";

          IF fifo_rd_en_i = '1' THEN
            fifo_rd_en_i     <= '0';
          ELSE
            IF fifo_valid_i = '0' THEN
              -- no valid data at fifo_data_out - so we start another read
              IF fifo_empty_i = '0' THEN
                fifo_rd_en_i <= '1';
              END IF;

            ELSIF fifo_valid_i = '1' THEN
              i2c_bytes_to_read <= fifo_data_out_i;
              i2c_data_valid    <= '1';

              state := req_i2c;

            END IF;
          END IF;

        WHEN write_data =>
          interface_state <= X"5";

          IF fifo_rd_en_i = '1' THEN
            fifo_rd_en_i <= '0';
          ELSE
            IF bytes_to_read > 0 THEN

              IF fifo_valid_i = '0' THEN
                i2c_wr_en      <= '0';
                -- no valid data at fifo_data_out - so we start another read
                IF fifo_empty_i = '0' THEN
                  fifo_rd_en_i <= '1';
                END IF;

              ELSIF fifo_valid_i = '1' THEN
                -- we have valid data at fifo_data_out - write it to I2C IP Core
                i2c_wr_en        <= '1';
                -- presumably the data needs to be latched - but let's give it a try
                i2c_bus_data_out <= fifo_data_out_i;

                bytes_to_read := bytes_to_read - 1;

              END IF;

            ELSIF bytes_to_read = 0 THEN
              i2c_wr_en <= '0';
              i2c_data_valid <= '1';
              state := req_i2c;
            END IF;

          END IF;


-- IF fifo_rd_en_i = '1' THEN
-- fifo_rd_en_i <= '0';
-- END IF;

-- IF bytes_to_read > 1 THEN

-- IF fifo_empty_i = '0' THEN
-- fifo_rd_en_i <= '1';
-- ELSIF fifo_empty_i = '1' THEN
-- fifo_rd_en_i <= '0';
-- END IF;

-- IF fifo_valid_i = '1' THEN
-- i2c_wr_en <= '1';
--  -- presumably the data needs to be latched - but let's give it a try
--               i2c_bus_data_out <= fifo_data_out_i;

-- bytes_to_read := bytes_to_read - 1;

-- ELSIF fifo_valid_i = '0' THEN
-- i2c_wr_en <= '0';
-- END IF;

-- ELSIF bytes_to_read = 1 THEN
-- IF fifo_empty_i = '0' THEN
-- fifo_rd_en_i <= '1';
-- ELSIF fifo_empty_i = '1' THEN
-- fifo_rd_en_i <= '0';
-- END IF;

-- IF fifo_valid_i = '1' THEN
-- fifo_rd_en_i <= '0';
-- i2c_wr_en <= '1';
--  -- presumably the data needs to be latched - but let's give it a try
--               i2c_bus_data_out <= fifo_data_out_i;

-- bytes_to_read := bytes_to_read - 1;

-- ELSIF fifo_valid_i = '0' THEN
-- i2c_wr_en <= '0';
-- END IF;

-- ELSIF bytes_to_read = 0 THEN
--  -- we do a second pass in this state to set fifo-signals and such
--             -- with the necessary one cycle offset
--             i2c_wr_en      <= '0';
--             i2c_data_valid <= '1';
--             state := req_i2c;

-- END IF;

        WHEN req_i2c =>
          interface_state <= X"6";
          -- request access to I2C bus
          i2c_request     <= '1';
          IF i2c_acknowledge = '1' THEN
            state := wait_i2c;
          END IF;

        WHEN wait_i2c =>
          interface_state  <= X"7";
          IF i2c_done = '1' THEN
            i2c_data_valid <= '0';
            i2c_request    <= '0';

            -- check if there is yet data to be transferred from the I2C core to the
            -- ASIPMeister CPU
            IF i2c_rw = '1' THEN
              state := read_data;
            ELSIF i2c_rw = '0' THEN
              state := idle;
            END IF;
          END IF;

        WHEN read_data =>
          interface_state <= X"8";
          -- wait until the output fifo of the I2C core is empty
          IF i2c_empty = '1' THEN
            state := idle;
          END IF;

        WHEN OTHERS => NULL;
      END CASE;
    END IF;
  END PROCESS;

  -- line through the I2C output fifo signals
  asip_data_out <= i2c_bus_data_in;
  asip_empty    <= i2c_empty;
  asip_rd_valid <= i2c_rd_valid;
  i2c_rd_en     <= asip_rd_en;

  --output debug signals
  interface_fifo_data  <= fifo_data_out_i;
  interface_fifo_rd_en <= fifo_rd_en_i;
  interface_fifo_valid <= fifo_valid_i;

END interface_asipmeister_i2c_arch;
