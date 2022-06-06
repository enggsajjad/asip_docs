-------------------------------------------------------------------------------
-- Title      : i2c arbiter
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_arbiter.vhd
-- Author     :   <kraemer@I80PC03>
-- Company    : 
-- Last update: 2006/05/29
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: arbiter for the i2c interface - purpose: multiple designs can 
-- use the i2c bus at the same time
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2006/05/11  0.01     kraemer Created
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

USE IEEE.std_logic_unsigned.ALL;

ENTITY i2c_arbiter IS

  GENERIC (
    devcount : positive := 2);          -- number of connected devices

  PORT (
    -- mutiple inputs
    -- data input / output and address input, rw-selector
    mport_data_in       : IN  std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
    mport_data_out      : OUT std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
    mport_address       : IN  std_logic_vector ((7 * devcount) - 1 DOWNTO 0);
    mport_rw            : IN  std_logic_vector (devcount - 1 DOWNTO 0);  -- rw = '0' = write
    mport_bytes_to_read : IN  std_logic_vector ((8 * devcount) - 1 DOWNTO 0);

    -- read and write enable signals, fifo ack and valid signal, empty and full
    -- signals
    mport_rd_en    : OUT std_logic_vector (devcount - 1 DOWNTO 0);
    mport_wr_en    : OUT std_logic_vector (devcount - 1 DOWNTO 0);
    mport_wr_ack   : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    mport_rd_valid : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    mport_empty    : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    mport_full     : IN  std_logic_vector (devcount - 1 DOWNTO 0);

    -- reset signal, data valid
    mport_reset      : IN std_logic_vector (devcount - 1 DOWNTO 0);
    mport_data_valid : IN std_logic_vector (devcount - 1 DOWNTO 0);

    -- status information of the ip-core
    mport_done : OUT std_logic_vector (devcount - 1 DOWNTO 0);  -- active low

    -- handshake signals / check which connected device requests access on bus
    request     : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    acknowledge : OUT std_logic_vector (devcount - 1 DOWNTO 0);

    -- internal clock signal of the i2c IP core
    clock_arbiter : IN std_logic;

    -- one output
    -- data input / output and address input, rw-selector
    sport_data_in       : IN  std_logic_vector (7 DOWNTO 0);
    sport_data_out      : OUT std_logic_vector (7 DOWNTO 0);
    sport_address       : OUT std_logic_vector (6 DOWNTO 0);
    sport_rw            : OUT std_logic;  -- rw = '0' = write
    sport_bytes_to_read : OUT std_logic_vector (7 DOWNTO 0);

    -- read and write enable signals, fifo ack and valid signal, empty and full
    -- signals
    sport_rd_en    : IN  std_logic;
    sport_wr_en    : IN  std_logic;
    sport_wr_ack   : OUT std_logic;
    sport_rd_valid : OUT std_logic;
    sport_empty    : OUT std_logic;
    sport_full     : OUT std_logic;

    -- reset signal, data valid
    sport_reset      : OUT std_logic;
    sport_data_valid : OUT std_logic;

    -- status information of the ip-core
    sport_done : IN std_logic           -- active low
    );

END i2c_arbiter;

ARCHITECTURE i2c_arbiter_arch OF i2c_arbiter IS

BEGIN  -- i2c_arbiter_arch

  -- purpose: select the input signal and divert it to the output (the fifos and the PCA9564 interface
  -- type   : combinational
  -- inputs : clock_arbiter
  -- outputs: everything with a sport_ name and acknowledge
  select_input            : PROCESS (clock_arbiter)
    VARIABLE sel_input    : integer := 0;  -- select a input
    VARIABLE range_low_8  : integer := 0;
    VARIABLE range_high_8 : integer := 0;
    VARIABLE range_low_7  : integer := 0;
    VARIABLE range_high_7 : integer := 0;

    VARIABLE waitcount : std_logic := '1';

  BEGIN  -- PROCESS select_input
    IF clock_arbiter'EVENT AND clock_arbiter = '1' THEN
      IF mport_reset (sel_input) = '1' THEN
        -- hand reset signal through, reset acknowledge
        sport_reset             <= '1';
        acknowledge (sel_input) <= '0';

        -- pass signals through, so the connected device sees the signals in reset
        -- case
        sport_address           <= "0000000";
        sport_rw                <= '0';
        sport_bytes_to_read     <= X"00";
        mport_rd_en (sel_input) <= '0';
        mport_wr_en (sel_input) <= '0';
        sport_rd_valid          <= mport_rd_valid (sel_input);
        sport_wr_ack            <= mport_wr_ack (sel_input);
        sport_empty             <= mport_empty (sel_input);
        sport_full              <= mport_full (sel_input);
        sport_data_valid        <= mport_data_valid (sel_input);
        mport_done (sel_input)  <= sport_done;

        IF waitcount = '1' THEN
          waitcount := '0';
        ELSE
          waitcount := '1';

          sel_input   := sel_input + 1;
          IF sel_input >= devcount THEN
            sel_input := 0;
          END IF;
        END IF;
      ELSE
        sport_reset <= '0';

        IF request (sel_input) = '1' THEN
          acknowledge (sel_input) <= '1';

          -- compute range of used bits - do it this complicated, else ISE will
          -- fail to synthesize correctly
          range_high_8 := sel_input + 1;
          range_high_8 := range_high_8 * 8;
          range_high_8 := range_high_8 - 1;
          range_low_8  := range_high_8 - 7;

          range_high_7 := sel_input + 1;
          range_high_7 := range_high_7 * 7;
          range_high_7 := range_high_7 - 1;
          range_low_7  := range_high_7 - 6;

          sport_data_out                                   <= mport_data_in (range_high_8 DOWNTO range_low_8);
          mport_data_out (range_high_8 DOWNTO range_low_8) <= sport_data_in;
          sport_address                                    <= mport_address (range_high_7 DOWNTO range_low_7);
          sport_rw                                         <= mport_rw (sel_input);
          sport_bytes_to_read                              <= mport_bytes_to_read (range_high_8 DOWNTO range_low_8);

          mport_rd_en (sel_input) <= sport_rd_en;
          mport_wr_en (sel_input) <= sport_wr_en;
          sport_rd_valid          <= mport_rd_valid (sel_input);
          sport_wr_ack            <= mport_wr_ack (sel_input);
          sport_empty             <= mport_empty (sel_input);
          sport_full              <= mport_full (sel_input);

          sport_reset      <= mport_reset (sel_input);
          sport_data_valid <= mport_data_valid (sel_input);

          mport_done (sel_input) <= sport_done;

          -- hope this does not lead to timing errors
          -- check on the finishing handshake after completed transfer
--           IF mport_data_valid (sel_input) = '0' AND sport_done = '1' THEN
--             acknowledge (sel_input) <= '0';

--             sel_input   := sel_input + 1;
--             IF sel_input >= devcount THEN
--               sel_input := 0;
--             END IF;

--           END IF;
        ELSE
          acknowledge (sel_input) <= '0';

          sport_address       <= "0000000";
          sport_rw            <= '0';
          sport_bytes_to_read <= X"00";

          mport_rd_en (sel_input) <= '0';
          mport_wr_en (sel_input) <= '0';
          sport_rd_valid          <= mport_rd_valid (sel_input);
          sport_wr_ack            <= mport_wr_ack (sel_input);
          sport_empty             <= mport_empty (sel_input);
          sport_full              <= mport_full (sel_input);

          sport_reset      <= '0';
          sport_data_valid <= '0';

          mport_done (sel_input) <= '0';

          -- check for one device request every clock tick. We do not check all
          -- devices in one clock tick, because then the connected devices would
          -- not be equal. A check on all devices with a simple loop would mean
          -- daisy-chaining.
          sel_input   := sel_input + 1;
          IF sel_input = devcount THEN
            sel_input := 0;
          END IF;

        END IF;
      END IF;
    END if;
    END PROCESS select_input;

    END i2c_arbiter_arch;
