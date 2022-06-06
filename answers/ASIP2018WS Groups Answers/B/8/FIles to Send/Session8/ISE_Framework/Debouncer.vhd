library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;


entity Debouncer is
  generic (
    bitwidth      :     integer := 32;
    maxCount      :     integer := 100000000
    );
  port (
    clk           : in  std_logic;
    reset         : in  std_logic;
    dataSource    : in  std_logic_vector(bitwidth-1 downto 0);
    dataDebounced : out std_logic_vector(bitwidth-1 downto 0)
    );
end Debouncer;

architecture Behavioral of Debouncer is

begin

  process (reset, clk, dataSource)
    variable counter        : integer;
    variable lastDataSource : std_logic_vector (bitwidth-1 downto 0);
  begin
    if reset = '1' then
      dataDebounced   <= (others => '0');
      counter          := 0;
      lastDataSource   := dataSource;
    elsif clk = '1' and clk'event then
      if (dataSource /= lastDataSource) then
        counter        := 0;
        lastDataSource := dataSource;
      elsif (counter = maxCount) then
        dataDebounced <= lastDataSource;
        counter        := 0;
      end if;
      counter          := counter + 1;
    end if;
  end process;

end Behavioral;
