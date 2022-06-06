-- author: Steffen Mülling
-- last update: 2006-09-05
--
-- generates a clock signal every count periods
-- reduced_clk is '1' only during one period

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity clk_div is
	generic(
		count : integer
	);
	port(
		clk : in std_logic;
		reset : in std_logic;
		reduced_clk : out std_logic
	);
end clk_div;

architecture Behavioral of clk_div is

begin

	process (clk, reset)
		variable i : integer := 0;
	begin
		if reset = '1' then
			i := 0;
			reduced_clk <= '0';
		elsif clk = '1' and clk'event then
			if i = count then
				i := 0;
				reduced_clk <= '1';
			else
				i := i + 1;
				reduced_clk <= '0';
			end if;
		end if;
	end process;
			
end Behavioral;
