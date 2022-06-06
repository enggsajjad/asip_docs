-------------------------------------------------------------------------------
-- AudioOut_TopLevel.vhd
-------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use AudioOut_types.all;                 -- contains constant SAMPLE_BIT_WIDTH
use work.AudioOut_types.all; 

entity AudioOut_TopLevel is
  generic (
    KSAMPLES_PER_SECOND          :    integer;
    FIFO_READ_CLOCK_SPEED_IN_KHZ :    integer;
    NUMBER_OF_PORTS              :    integer
    );
  port (
    reset                        : in std_logic;
    clkPwmGeneration             : in std_logic;
    clkFifoRead                  : in std_logic;
    clkFifoWrite                 : in std_logic;

    AudioData     : in  AudioDataArray(NUMBER_OF_PORTS-1 downto 0);
    req           : in  std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    ack           : out std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
    analogOut     : out std_logic;
    fifoDataCount : out std_logic_vector(7 downto 0);
    selector      : in  std_logic_vector(NUMBER_OF_PORTS-1 downto 0)  -- this size is too big: could have been log(NUMBER_OF_PORTS), but ...
    );
end AudioOut_TopLevel;

architecture STRUCTURE of AudioOut_TopLevel is

  component DigitalAnalogConverter
    generic (
      SAMPLE_BIT_WIDTH             :     integer;
      KSAMPLES_PER_SECOND          :     integer;
      FIFO_READ_CLOCK_SPEED_IN_KHZ :     integer
      );
    port (reset                    : in  std_logic;
          clkPwmGeneration         : in  std_logic;
          clkFifoRead              : in  std_logic;
          fifoDataOut              : in  std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
          fifoReadEnable           : out std_logic;
          fifoEmpty                : in  std_logic;
          analogOut                : out std_logic
          );
  end component;

  component audio_out_fifo
    port (
      din           : in  std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
      rd_clk        : in  std_logic;
      rd_en         : in  std_logic;
      rst           : in  std_logic;
      wr_clk        : in  std_logic;
      wr_en         : in  std_logic;
      dout          : out std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
      empty         : out std_logic;
      full          : out std_logic;
      wr_data_count : out std_logic_vector(7 downto 0));
  end component;


  signal fifoDataOut     : std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
  signal fifoDataIn      : std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
  signal fifoReadEnable  : std_logic;
  signal fifoWriteEnable : std_logic;
  signal fifoEmpty       : std_logic;
  signal fifoFull        : std_logic;
  signal selectedAck     : std_logic;

begin

  DigitalAnalogConverter_Instance : DigitalAnalogConverter
    generic map (
      SAMPLE_BIT_WIDTH             => SAMPLE_BIT_WIDTH,
      KSAMPLES_PER_SECOND          => KSAMPLES_PER_SECOND,
      FIFO_READ_CLOCK_SPEED_IN_KHZ => FIFO_READ_CLOCK_SPEED_IN_KHZ
      )

    port map (
      reset            => reset,
      clkPwmGeneration => clkPwmGeneration,
      clkFifoRead      => clkFifoRead,
      fifoDataOut      => fifoDataOut,
      fifoReadEnable   => fifoReadEnable,
      fifoEmpty        => fifoEmpty,
      analogOut        => analogOut
      );

  AudioOutFIFO_Instance : audio_out_fifo
    port map (
      din           => fifoDataIn,
      rd_clk        => clkFifoRead,
      rd_en         => fifoReadEnable,
      rst           => reset,
      wr_clk        => clkFifoWrite,
      wr_en         => fifoWriteEnable,
      dout          => fifoDataOut,
      empty         => fifoEmpty,
      full          => fifoFull,
      wr_data_count => fifoDataCount);



  dummyAck : for i in NUMBER_OF_PORTS-1 downto 0 generate
    ack(i) <= selectedAck when selector = conv_std_logic_vector(i, NUMBER_OF_PORTS) else req(i);
  end generate dummyAck;



  connectToFifo                : process(reset, clkFifoWrite)
    variable req_sampled       : std_logic;
    variable sentAck           : std_logic;
    variable AudioData_sampled : std_logic_vector(15 downto 0);
    variable selector_sampled  : std_logic_vector(NUMBER_OF_PORTS-1 downto 0);
  begin
    if rising_edge(clkFifoWrite) then
      if reset = '1' then
        req_sampled       := '0';
        AudioData_sampled := (others => '0');
        selector_sampled  := (others => '0');
        sentAck           := '0';
        fifoWriteEnable   <= '0';
        selectedAck       <= '0';
      else
        if sentAck = '1' then
          fifoWriteEnable <= '0';
          selectedAck     <= '0';
          sentAck         := '0';
        end if;

        if selector < NUMBER_OF_PORTS and req(conv_integer(selector)) = '1' then
          req_sampled       := '1';
          selector_sampled  := selector;
          AudioData_sampled := AudioData(conv_integer(selector_sampled));
        end if;

        if req_sampled = '1' then
          if fifoFull = '0' then
            fifoWriteEnable <= '1';
            fifoDataIn      <= AudioData_sampled;
            req_sampled := '0';
            sentAck     := '1';
            selectedAck     <= '1';
          end if;
        end if;

      end if;
    end if;
  end process;

end STRUCTURE;

