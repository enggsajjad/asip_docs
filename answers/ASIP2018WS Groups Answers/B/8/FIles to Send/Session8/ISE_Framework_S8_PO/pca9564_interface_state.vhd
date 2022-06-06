-------------------------------------------------------------------------------
-- Title      : Interface to the PCA9564
-- Project    : Project with individual source files
-------------------------------------------------------------------------------
-- File       : pca9564_interface_state.vhd
-- Author     : Christian Kraemer  <kraemer@i80pc22.irf.uni-karlsruhe.de>
-- Company    : 
-- Last update: 2006/09/01
-- Platform   : 
-------------------------------------------------------------------------------
-- This is a multi-line project description
-- that can be used as a project dependent part of the file header.
-------------------------------------------------------------------------------
-- Description: contains the state-machine to interface to the PCA9564 and all
-- devices connected to the I2C bus
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2006/03/16  0.01     kraemer Created
-- 2006/03/23  0.10     kraemer first test worked (initialization complete)
-- 2006/03/31  0.20     kraemer initialization and test cycle function
-- 2006/03/31  0.25     kraemer begin of master_transmitter mode implementation
-- 2006/04/11  0.30     kraemer master_transmitter works, master_receiver
--                              implemented (untested)
-- 2006/05/12  0.50     kraemer master_transmitter and master_receiver
--                              thoroughly tested, lots of bugs fixed
-- 2006/05/30  0.90     kraemer design has been tested for hours, seems to be bug-free
--                              waitcycles fixed for 20MHz, testbench signals removed

-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

ENTITY pca9564_interface IS

  PORT (
    -- connections to the other entities of the IP core
    -- connction to the data_in FIFO
    fifo_data_in : IN  std_logic_vector (7 DOWNTO 0);  -- 8 bits input
    fifo_rd_ack  : IN  std_logic;       -- read was successful
    fifo_rd_en   : OUT std_logic;       -- read strobe on FIFO
    fifo_empty   : IN  std_logic;       -- the data_in FIFO is empty

    -- connection to the data_out FIFO
    fifo_data_out : OUT std_logic_vector (7 DOWNTO 0);  -- 8 bits output
    fifo_wr_ack   : IN  std_logic;      -- write was successful
    fifo_wr_en    : OUT std_logic;      -- write strobe on FIFO
    fifo_full     : IN  std_logic;      -- the data_out FIFO is full

    clock          : IN    std_logic;   -- clock signal
    reset          : IN    std_logic;   -- reset the I2C bus interface
    device_address : IN    std_logic_vector (6 DOWNTO 0);  -- address of the device to
                                        -- be accessed on the bus
    rw             : IN    std_logic;   -- select if data should be written to
                                        -- / read from the device selected with
                                        -- device_address; rw = '0' = write
    data_valid     : IN    std_logic;   -- chip enable signal, indicates that
                                        -- rw = '0': data in fifo is present,
                                        --           device_address is valid
                                        -- rw = '1': device_address is valid
    bytes_to_read  : IN    std_logic_vector (7 DOWNTO 0);
    done           : INOUT std_logic;   -- signals that requested transfer is complete

    -- connections to the PCA9564, to be mapped to FPGA IO pins
    pca9564_data    : INOUT std_logic_vector (7 DOWNTO 0);  -- 8 bits to / from PCA9564
    pca9564_wr      : OUT   std_logic;  -- write strobe
    pca9564_rd      : OUT   std_logic;  -- read strobe
    pca9564_ce      : OUT   std_logic;  -- chip enable
    pca9564_address : OUT   std_logic_vector (1 DOWNTO 0);  -- select PCA9564
                                        -- register, format is A1A0
    pca9564_int     : IN    std_logic;  -- interrupt line from PCA9564
    pca9564_reset   : OUT   std_logic;  -- reset PCA9564

    -- connections to debug leds, to be mapped to FPGA IO pins
    debug_led_extern : OUT std_logic_vector (31 DOWNTO 0);  -- external debug LED connection
    debug_led_intern : OUT std_logic_vector (7 DOWNTO 0)  -- internal debug LED connection
    );

END pca9564_interface;

ARCHITECTURE pca9564_interface_arch OF pca9564_interface IS
  -- some constant definitions for easier reference
  -- the 5 register names of the PCA9564, TO name changed to TOR
  CONSTANT CTO : std_logic_vector (1 DOWNTO 0) := "00";
  CONSTANT STA : std_logic_vector (1 DOWNTO 0) := "00";
  CONSTANT DAT : std_logic_vector (1 DOWNTO 0) := "01";
  CONSTANT ADR : std_logic_vector (1 DOWNTO 0) := "10";
  CONSTANT CON : std_logic_vector (1 DOWNTO 0) := "11";

  -- set speed of I2C bus, this is used to overwrite the lower 3 bits
  -- of every data value to be written in the CON register  
  CONSTANT SPD : std_logic_vector (2 DOWNTO 0) := "100";

  SIGNAL debug_led_extern_state : std_logic_vector (31 DOWNTO 0) := X"00000000";
                                        -- state of the external debug leds
  SIGNAL debug_led_intern_state : std_logic_vector (7 DOWNTO 0)  := X"00";
                                        -- state of the internal debug leds

  SIGNAL pca9564_interrupt : std_logic := '1';

  -- the states for the state machine
  TYPE machine IS ( init0, init1, init2, init3, init4, init5, init6, init7, init8,
                    idle0, idle1,
                    waitcycles,
                    read0, read1, read2,
                    write0, write1, write2, write3,
                    readfifo0, readfifo1, readfifo2,
                    writefifo0, writefifo1, writefifo2,
                    mt0, mt1, mt2, mt3, mt4, mt5, mt6, mt7, mt8, mt9, mt10, mt11,
                    mr0, mr1, mr2, mr3, mr4, mr5, mr6, mr7, mr8, mr9, mr10, mr11, mr12, mr13, mr14, mr15, mr16,
                    panic, fail, handler);

BEGIN  -- pca9564_interface_arch

  -- purpose: latches the pca9564_int signal
  -- type : combinational
  -- inputs : pca9564_int
  -- outputs: pca9564_interrupt
  PROCESS (clock)
  BEGIN  -- PROCESS
    IF clock'EVENT AND clock = '1' THEN
      IF pca9564_int = '0' THEN
        pca9564_interrupt <= '0';
      ELSIF pca9564_int = '1' THEN
        pca9564_interrupt <= '1';
      END IF;
    END IF;
  END PROCESS;

  -- purpose: contains the state machine to interface with the PCA9564
  -- type : combinational
  -- inputs :
  -- outputs:
  interfaceToPCA9564         : PROCESS (clock, reset)
    VARIABLE dataval         : std_logic_vector (7 DOWNTO 0) := X"00";  -- data variable
    VARIABLE address         : std_logic_vector (1 DOWNTO 0) := "00";  -- register address to write to / read from

    VARIABLE state       : machine := init0;
    VARIABLE returnstate : machine := init0;
    VARIABLE temp        : machine := init0;

    VARIABLE bytecounter    : integer := 0;  -- amount of bytes to be read
    VARIABLE cycles_to_wait : integer := 0;  -- amount of waitcycles

-- VARIABLE testval : integer := 1;     -- generate some test_data for testcycle

    -- in case of error count how often rechecked for possible error recovery
    VARIABLE errorcount_mt11 : integer := 0;
    VARIABLE errorcount_mr2  : integer := 0;
    VARIABLE errorcount_mr5  : integer := 0;
    VARIABLE errorcount_mr13 : integer := 0;

  BEGIN  -- PROCESS interfaceToPCA9564
    IF reset = '1' THEN
      state       := init0;
      returnstate := init0;
      temp        := init0;

      pca9564_ce    <= '0';
      pca9564_reset <= '1';
      pca9564_wr    <= '1';
      pca9564_rd    <= '1';

      pca9564_address <= (OTHERS => 'Z');
      pca9564_data    <= (OTHERS => 'Z');

      fifo_wr_en <= '0';
      fifo_rd_en <= '0';

      done <= '0';

      debug_led_extern_state <= X"FFFFFFFF";
      debug_led_intern_state <= X"99";

    ELSIF clock'EVENT AND clock = '1' THEN
      CASE state IS

-- initialize the state machine and the PCA9564
        WHEN init0 =>
          debug_led_intern_state <= X"00";
          debug_led_extern_state <= X"00000000";

          pca9564_ce    <= '0';
          pca9564_reset <= '0';
          pca9564_wr    <= '1';
          pca9564_rd    <= '1';

          pca9564_address <= (OTHERS => 'Z');
          pca9564_data    <= (OTHERS => 'Z');

          fifo_wr_en <= '0';
          fifo_rd_en <= '0';

          done <= '0';

          -- WAIT FOR 250 ns
          cycles_to_wait := 10;

          -- set return variable
          returnstate := init1;
          -- set state for next turn
          state       := waitcycles;

        WHEN init1 =>
          debug_led_intern_state <= X"01";
          pca9564_reset          <= '1';
          -- timeout register TOR is 0xFF by default
          -- address register ADR is 0x00 by default

          -- set clock frequency
          dataval := X"44";
          address := CON;

          -- set return variable
          returnstate := init2;
          -- set state for next turn
          state       := write0;

        WHEN init2 =>
          debug_led_intern_state <= X"02";
          -- set address of pca9564
          dataval := X"26";
          address := ADR;

          -- set return variable
          returnstate := init3;
          -- set state for next turn
          state       := write0;

        WHEN init3 =>
          debug_led_intern_state <= X"03";
          -- WAIT FOR 500 us
          cycles_to_wait := 11000;

          -- set return variable
          returnstate := init4;
          -- set state for next turn
          state       := waitcycles;

        WHEN init4 =>
          debug_led_intern_state <= X"04";
          -- read back register contents for debug purpose
          address := STA;

          -- set return variable
          returnstate := init5;
          -- set state for next turn
          state       := read0;

        WHEN init5 =>
          debug_led_intern_state <= X"05";
          address := DAT;

          -- set return variable
          returnstate := init6;
          -- set state for next turn
          state       := read0;

        WHEN init6 =>
          debug_led_intern_state <= X"06";
          address := ADR;

          -- set return variable
          returnstate := init7;
          -- set state for next turn
          state       := read0;

        WHEN init7 =>
          debug_led_intern_state <= X"07";
          address := CON;

          -- set return variable
          returnstate := init8;
          -- set state for next turn
          state       := read0;

        WHEN init8 =>
          debug_led_intern_state <= X"08";
          -- set slave receiver mode !?!
          address := CON;
          dataval := X"C4";

          -- set return variable
          returnstate := idle0;

          -- set state for next turn
          state := write0;

-- main idle state
        WHEN idle0 =>
          debug_led_intern_state <= X"80";
          IF data_valid = '1' AND done = '0' THEN
            IF rw = '0' THEN
              state       := mt0;
            ELSE
              bytecounter := conv_integer(bytes_to_read);
              state       := mr0;
            END IF;
          ELSIF data_valid = '0' AND done = '1' THEN
            done                 <= '0';
          ELSE
            NULL;
          END IF;

        WHEN idle1 =>
          done <= '1';
          state := idle0;

        WHEN mt0 =>
          debug_led_intern_state <= X"C0";
          -- generate START command on I2C bus
          address := CON;
          dataval := X"E4";

          -- set return variable
          returnstate := mt1;
          -- set state for next turn
          state       := write0;

        WHEN mt1 =>
          debug_led_intern_state <= X"C1";
          -- wait on pca9564_interrupt = '0'
          IF pca9564_interrupt = '0' THEN
            -- read STA register
            address := STA;

            -- set return variable
            returnstate := mt2;
            -- set state for next turn
            state       := read0;
          ELSE
            state       := mt1;
          END IF;

        WHEN mt2 =>
          debug_led_intern_state <= X"C2";
          IF dataval /= X"08" THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate          := state;
            -- set state for next turn                
            state                := handler;
          ELSE
            -- write slave address to DAT register
            address              := DAT;
            dataval (7 DOWNTO 1) := device_address;
            dataval (0)          := '0';

            -- set return variable
            returnstate := mt3;
            -- set state for next turn
            state       := write0;
          END IF;

        WHEN mt3 =>
          debug_led_intern_state <= X"C3";
          -- write to CON register to send address on bus, issue write command
          address := CON;
          dataval := X"C4";

          -- set return variable
          returnstate := mt4;
          -- set state for next turn
          state       := write0;

        WHEN mt4 =>
          debug_led_intern_state <= X"C4";
          -- wait on pca9564_interrupt = '0'
          IF pca9564_interrupt = '0' THEN
            -- read STA register
            address := STA;

            -- set return variable
            returnstate := mt5;
            -- set state for next turn
            state       := read0;
          ELSE
            state       := mt4;
          END IF;

        WHEN mt5 =>
          debug_led_intern_state <= X"C5";
          IF dataval /= X"18" THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate := state;
            -- set state for next turn                
            state       := handler;
          ELSE
            -- request data from the data_in FIFO
            -- set return variable
            returnstate := mt6;
            -- set state for next turn                
            state       := readfifo0;
          END IF;

        WHEN mt6 =>
          debug_led_intern_state <= X"C6";
          -- write data to be sent into DAT register
          address := DAT;
          dataval := fifo_data_in;

          -- set return variable
          returnstate := mt7;
          -- set state for next turn
          state       := write0;

        WHEN mt7 =>
          debug_led_intern_state <= X"C7";
          -- write CON register to send data on bus
          address := CON;
          dataval := X"C4";

          -- set return variable
          returnstate := mt8;
          -- set state for next turn
          state       := write0;

        WHEN mt8 =>
          debug_led_intern_state <= X"C8";
          -- wait on pca9564_interrupt = '0'
          IF pca9564_interrupt = '0' THEN
            -- read STA register
            address := STA;

            -- set return variable
            returnstate := mt9;
            -- set state for next turn
            state       := read0;
          ELSE
            state       := mt8;
          END IF;

        WHEN mt9 =>
          debug_led_intern_state <= X"C9";
          IF dataval /= X"28" THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate := state;
            -- set state for next turn                
            state       := handler;
          ELSE
            IF fifo_empty /= '1' THEN
              -- we have more packets to send
              -- set dataval so the IF in state mt5 succeeds
              dataval   := X"18";
              -- set state for next turn
              state     := mt5;
            ELSE
              -- generate STOP command on I2C bus
              address   := CON;
              dataval   := X"D0";

              -- set return variable
              returnstate := mt10;
              -- set state for next turn
              state       := write0;
            END IF;
          END IF;

        WHEN mt10 =>
          debug_led_intern_state <= X"CA";

          -- read CON register
          address := CON;

          -- set return variable
          returnstate := mt11;
          -- set state for next turn
          state       := read0;

        WHEN mt11 =>
          debug_led_intern_state <= X"CB";
          IF dataval (4) /= '0' THEN
            -- we have an error here, go to the fault handler
            -- set return variable

            returnstate     := state;
            -- set state for next turn                
            state           := handler;
          ELSE
            errorcount_mt11 := 0;
            --wait 4,7 usec before next transfer on bus
            cycles_to_wait  := 100;

            returnstate := idle1;
            -- set state for next turn
            state       := waitcycles;
          END IF;

-- master receiver mode
        WHEN mr0 =>
          debug_led_intern_state <= X"60";
          -- generate START command on I2C bus
          address := CON;
          dataval := X"E4";

          -- set return variable
          returnstate := mr1;
          -- set state for next turn
          state       := write0;

        WHEN mr1 =>
          debug_led_intern_state <= X"61";
          -- wait on pca9564_interrupt = '0'
          IF pca9564_interrupt = '0' THEN
            -- read STA register
            address := STA;

            -- set return variable
            returnstate := mr2;
            -- set state for next turn
            state       := read0;
          ELSE
            state       := mr1;
          END IF;

        WHEN mr2 =>
          debug_led_intern_state <= X"62";
          IF dataval /= X"08" AND dataval /= X"10" THEN
            -- we have an error here, go to the fault handler
            -- set return variable 
            returnstate          := state;
            -- set state for next turn                
            state                := handler;
          ELSE
            errorcount_mr2       := 0;
            -- write slave address to DAT register
            address              := DAT;
            dataval (7 DOWNTO 1) := device_address;
            dataval (0)          := '1';

            -- set return variable
            returnstate := mr3;
            -- set state for next turn
            state       := write0;
          END IF;

        WHEN mr3 =>
          debug_led_intern_state <= X"63";
          -- write to CON register to send address on bus, issue read command
          address := CON;
          dataval := X"C4";

          -- set return variable
          returnstate := mr4;
          -- set state for next turn
          state       := write0;

        WHEN mr4 =>
          debug_led_intern_state <= X"64";
          -- wait on pca9564_interrupt = '0'
          IF pca9564_interrupt = '0' THEN
            -- read STA register
            address := STA;

            -- set return variable
            returnstate := mr5;
            -- set state for next turn
            state       := read0;
          ELSE
            state       := mr4;
          END IF;

        WHEN mr5 =>
          debug_led_intern_state <= X"65";
          IF dataval /= X"40" THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate    := state;
            -- set state for next turn                
            state          := handler;
          ELSE
            errorcount_mr5 := 0;
            -- request data from the PCA9564, allow slave data transfer
            address        := CON;
            IF bytecounter > 1 THEN
              dataval      := X"C4";
            ELSE
              dataval      := X"44";
            END IF;

            -- set return variable
            returnstate := mr6;
            -- set state for next turn                
            state       := write0;
          END IF;

        WHEN mr6 =>
          debug_led_intern_state <= X"66";
          -- wait on pca9564_interrupt = '0'
          IF pca9564_interrupt = '0' THEN
            -- read STA register
            address := STA;

            -- set return variable
            IF bytecounter > 1 THEN
              returnstate := mr7;
            ELSE
              -- we jump the loop here and go to mr9
              returnstate := mr9;
            END IF;
            -- set state for next turn
            state         := read0;
          ELSE
            state         := mr6;
          END IF;

        WHEN mr7 =>
          debug_led_intern_state <= X"67";
          IF dataval /= X"50" THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate := state;
            -- set state for next turn                
            state       := handler;
          ELSE
            -- read data from DAT register
            address     := DAT;

            -- set return variable
            returnstate := mr8;
            -- set state for next turn
            state       := read0;
          END IF;

        WHEN mr8 =>
          debug_led_intern_state <= X"68";
          fifo_data_out          <= dataval;
          bytecounter := bytecounter - 1;
          -- set dataval so the IF in mr5 succeeds
          dataval     := X"40";

          -- set return variable
          returnstate := mr5;
          -- set state for next turn
          state       := writefifo0;

        WHEN mr9 =>
          debug_led_intern_state <= X"69";
          IF dataval /= X"58" THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate := state;
            -- set state for next turn                
            state       := handler;
          ELSE
            -- read data from DAT register
            address     := DAT;

            -- set return variable
            returnstate := mr10;
            -- set state for next turn
            state       := read0;
          END IF;

        WHEN mr10 =>
          debug_led_intern_state <= X"6A";
          fifo_data_out          <= dataval;

          -- set return variable
          returnstate := mr11;
          -- set state for next turn
          state       := writefifo0;

        WHEN mr11 =>
          debug_led_intern_state <= X"6B";
          -- write to CON register, generate STOP command
          address := CON;
          dataval := X"D4";

          -- set return variable
          returnstate := mr12;
          -- set state for next turn
          state       := write0;

        WHEN mr12 =>
          debug_led_intern_state <= X"6C";
          -- read CON register
          address := CON;

          -- set return variable
          returnstate := mr13;
          -- set state for next turn
          state       := read0;

        WHEN mr13 =>
          debug_led_intern_state <= X"6D";

          IF dataval (4) /= '0' THEN
            -- we have an error here, go to the fault handler
            -- set return variable
            returnstate     := state;
            -- set state for next turn                
            state           := handler;
          ELSE
            errorcount_mr13 := 0;
            --wait 4.7 usec before next transfer on bus
            cycles_to_wait  := 100;

            -- set return variable
            returnstate := idle1;
            -- set state for next turn
            state       := waitcycles;
          END IF;

-- the helper functions
-- waiting in cycles_to_wait denoted amount of cycles
        WHEN waitcycles =>
          debug_led_intern_state <= X"40";

          IF cycles_to_wait > 1 THEN
            cycles_to_wait := cycles_to_wait - 1;
          ELSE
            cycles_to_wait := 0;
            state          := returnstate;
          END IF;

-- writing to the PCA9564
        WHEN write0 =>
          debug_led_intern_state <= X"20";
          -- save old values of return states
          temp := returnstate;

          -- check if we write to the CON register
          IF address = CON THEN
            dataval (2 DOWNTO 0) := SPD;
          END IF;

          pca9564_data    <= dataval;
          pca9564_address <= address;

          -- allow some setup time for address and dataval, thus we
          -- continue in the next state (next clock cycle)
          state := write1;

        WHEN write1 =>
          debug_led_intern_state <= X"21";
          -- change return values, so we go to write2 after waiting is done
          returnstate := write2;

          pca9564_wr <= '0';
          -- hold WR for at least 7 ns
          cycles_to_wait := 1;

          state := waitcycles;

        WHEN write2 =>
          debug_led_intern_state <= X"22";
          pca9564_wr             <= '1';

          -- output some debug information
          CASE address IS
            WHEN STA    =>
              debug_led_extern_state (31 DOWNTO 24) <= dataval;
            WHEN DAT    =>
              debug_led_extern_state (23 DOWNTO 16) <= dataval;
            WHEN ADR    =>
              debug_led_extern_state (15 DOWNTO 8)  <= dataval;
            WHEN CON    =>
              debug_led_extern_state (7 DOWNTO 0)   <= dataval;
            WHEN OTHERS => NULL;
          END CASE;

          state := write3;

        WHEN write3                         =>
          debug_led_intern_state <= X"23";
          -- remove data from the bus
          pca9564_data           <= (OTHERS => 'Z');
          -- remove address from the bus
          pca9564_address        <= (OTHERS => 'Z');

          IF address = CON AND pca9564_interrupt = '0' THEN
            -- wait until pca9564_int is high
            state := write3;
          ELSE
            -- we return to the state following the one calling write
            state := temp;
          END IF;

-- reading from any register of the PCA9564
        WHEN read0 =>
          debug_led_intern_state <= X"10";
          -- save old values of return states
          temp := returnstate;

          pca9564_address <= address;

          -- allow some setup time for address, thus we continue in the
          -- next state (next clock cycle)
          state := read1;

        WHEN read1 =>
          debug_led_intern_state <= X"11";
          -- change return values, so we go to read2 after waiting is done
          returnstate := read2;

          pca9564_rd <= '0';
          -- hold RD for at least 17 ns
          cycles_to_wait := 1;

          state := waitcycles;

        WHEN read2 =>
          debug_led_intern_state <= X"12";
          -- we return to the state following the one calling read after
          -- waiting is done
          returnstate := temp;

          dataval := pca9564_data;
          pca9564_rd <= '1';

          -- remove address from the bus
          pca9564_address <= (OTHERS => 'Z');

          -- output some debug information
          CASE address IS
            WHEN STA    =>
              debug_led_extern_state (31 DOWNTO 24) <= dataval;
            WHEN DAT    =>
              debug_led_extern_state (23 DOWNTO 16) <= dataval;
            WHEN ADR    =>
              debug_led_extern_state (15 DOWNTO 8)  <= dataval;
            WHEN CON    =>
              debug_led_extern_state (7 DOWNTO 0)   <= dataval;
            WHEN OTHERS => NULL;
          END CASE;

          -- allow the data bus some time to get floating again: min 17 ns
          cycles_to_wait := 1;

          state := waitcycles;

-- reading from the data_in FIFO
        WHEN readfifo0 =>
          debug_led_intern_state <= X"E0";
          -- save old values of return states
          temp := returnstate;

          IF fifo_empty = '1' THEN
            state := panic;
          ELSE
            fifo_rd_en <= '1';

            -- change return values, so we go to readfifo1 after waiting is done
            state := readfifo1;
          END IF;

        WHEN readfifo1 =>
          debug_led_intern_state <= X"E1";
          fifo_rd_en             <= '0';

          cycles_to_wait := 2;
          returnstate    := readfifo2;

          state := waitcycles;

        WHEN readfifo2 =>
          debug_led_intern_state <= X"E2";

          IF fifo_rd_ack = '1' THEN
            -- we return to the state following the one calling readfifo
            state := temp;
          ELSIF fifo_rd_ack = '0' THEN
            state := fail;
          ELSE
            state := panic;
          END IF;

-- writing to the data_out FIFO
        WHEN writefifo0 =>
          debug_led_intern_state <= X"E2";
          -- save old values of return states
          temp := returnstate;

          IF fifo_full = '1' THEN
            state := panic;
          ELSE
            -- change return values, so we go to writefifo1 after waiting is done
            state := writefifo1;
            fifo_wr_en <= '1';
          END IF;

        WHEN writefifo1 =>
          debug_led_intern_state <= X"E3";
          fifo_wr_en             <= '0';

          cycles_to_wait := 2;
          returnstate    := writefifo2;

          state := waitcycles;

        WHEN writefifo2 =>
          debug_led_intern_state <= X"E4";

          IF fifo_wr_ack = '1' THEN
            -- we return to the state following the one calling writefifo
            state := temp;
          ELSIF fifo_wr_ack = '0' THEN
            state := fail;
          ELSE
            state := panic;
          END IF;

-- the fault modes
        WHEN panic =>
          debug_led_intern_state <= X"FF";

-- signal fail with blinking of internal leds
        WHEN fail =>
          debug_led_intern_state <= X"F1";

-- error handler
        WHEN handler =>
          debug_led_intern_state <= X"F0";

          CASE returnstate IS
            WHEN mt11 =>
              IF errorcount_mt11 < 1000 THEN
                errorcount_mt11 := errorcount_mt11 + 1;
                state           := mt10;
              END IF;

            WHEN mr2 =>
              IF errorcount_mr2 < 3 THEN
                errorcount_mr2 := errorcount_mr2 + 1;
                state          := mr1;
              END IF;

            WHEN mr5 =>
              IF errorcount_mr5 < 5 THEN
                errorcount_mr5 := errorcount_mr5 + 1;
                state          := mr0;
              END IF;

            WHEN mr13 =>
              IF errorcount_mr13 < 1000 THEN
                errorcount_mr13 := errorcount_mr13 + 1;
                state           := mr12;
              END IF;

            WHEN OTHERS => NULL;
          END CASE;

        WHEN OTHERS =>
          state := panic;
      END CASE;

    END IF;
  END PROCESS interfaceToPCA9564;

  -- purpose: update the debug LEDs
  -- type   : combinational
  -- inputs : debug_led_extern_state, debug_led_intern_state
  -- outputs: debug_led_extern, debug_led_intern
  setLED : PROCESS (debug_led_extern_state, debug_led_intern_state)
  BEGIN  -- PROCESS setLED
    debug_led_extern <= debug_led_extern_state;
    debug_led_intern <= debug_led_intern_state;
  END PROCESS setLED;

END pca9564_interface_arch;
