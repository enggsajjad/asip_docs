library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

package AudioOut_types is
  constant SAMPLE_BIT_WIDTH : positive := 16;
  type AudioDataArray is array(natural range<>) of std_logic_vector(SAMPLE_BIT_WIDTH-1 downto 0);
end package;
