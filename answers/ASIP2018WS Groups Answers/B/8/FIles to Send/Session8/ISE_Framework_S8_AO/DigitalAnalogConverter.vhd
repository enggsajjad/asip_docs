----------------------------------------------------------------------------------
-- Company: Chair for Embedded Systems (CES) - University of Karlsruhe
-- Engineer: Lars Bauer
-- 
-- Create Date:    22:30:45 06/17/2006 
-- Design Name: 
-- Module Name:    AudioOut - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: ISE 8.1
-- Description: Reads digital samples in a specific frequency from an external
--              FIFO, creates a PWM signal out of it and writes it to the analog output.
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity DigitalAnalogConverter is
  generic (
    SAMPLE_BIT_WIDTH             :     integer;
    KSAMPLES_PER_SECOND          :     integer;
    FIFO_READ_CLOCK_SPEED_IN_KHZ :     integer
    );
  port (
    reset                        : in  std_logic;
    clkPwmGeneration             : in  std_logic;
    clkFifoRead                  : in  std_logic;
    fifoDataOut                  : in  std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
    fifoReadEnable               : out std_logic;
    fifoEmpty                    : in  std_logic;
    analogOut                    : out std_logic
    );
end DigitalAnalogConverter;


architecture Behavioral of DigitalAnalogConverter is

  constant FIFO_READ_DELAY : integer := (FIFO_READ_CLOCK_SPEED_IN_KHZ/KSAMPLES_PER_SECOND)-2;
                                        -- the -2 is for the 2 additional states in the readFIFO process
  signal   digitalData     : std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);


begin

  assert FIFO_READ_DELAY > 0 report "INVALID VALUES for FIFO_READ_CLOCK_SPEED_IN_KHZ and KSAMPLES_PER_SECOND !" severity failure;

  readFIFO           : process(reset, clkFifoRead, fifoDataOut, fifoEmpty)
    type stateType is (readFromFifo1, readFromFifo2, pause);
    variable state   : stateType;
    variable counter : integer;
  begin
    if rising_edge(clkFifoRead) then
      if reset = '1' then
        state   := readFromFifo1;
        counter := 0;
      else
        case state is

          when readFromFifo1 =>
            if fifoEmpty = '0' then
              fifoReadEnable <= '1';
              state := readFromFifo2;
            end if;

          when readFromFifo2 =>
            fifoReadEnable <= '0';
            digitalData    <= fifoDataOut;
            counter := 0;
            state   := pause;

          when pause =>
            counter := counter+1;
            if counter = FIFO_READ_DELAY then
              state := readFromFifo1;
            end if;

          when others =>

        end case;
      end if;
    end if;
  end process;  -- readFIFO


  createPWM                     : process(reset, clkPwmGeneration, digitalData)
    variable counter            : std_logic_vector(7 downto 0);
    -- a backup of the current digitalData to avoid glitches
    -- in the output when the digital data changes
    variable currentDigitalData : std_logic_vector(7 downto 0);
  begin
    if rising_edge(clkPwmGeneration) then
      if reset = '1' then
        analogOut   <= '0';
        counter              := (others => '0');
      else
        counter              := counter+1;
        if counter = conv_std_logic_vector('0', 8) then
          currentDigitalData := digitalData(15 downto 8);
          analogOut <= '0';
        elsif counter = currentDigitalData then
          analogOut <= '1';
        end if;
      end if;
    end if;
  end process;


end Behavioral;

