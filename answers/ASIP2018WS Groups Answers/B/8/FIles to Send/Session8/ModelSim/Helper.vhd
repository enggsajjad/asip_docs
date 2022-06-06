----------------------------------------------------------------------------------
-- Company: ITEC-Henkel (CES), University of Karlsruhe
-- Engineer: Lars Bauer
-- 
-- Create Date:    06/25/2008
-- Design Name:    Helper
-- Target Devices: xc2v3000
-- Tool versions:  ISE 8.1
-- Description:    Some helping functions
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

package Helper is
  function hstr(slv  : std_logic_vector) return string;
  function int2char(int : integer) return character;
end Helper;


package body Helper is
-- converts a std_logic_vector into a hex string.
function hstr(slv  : std_logic_vector) return string is
  variable hexlen  : integer;
  variable longslv : std_logic_vector(67 downto 0) := (others => '0');
  variable hex     : string(1 to 16);
  variable fourbit : std_logic_vector(3 downto 0);

begin
  hexlen                            := (slv'left+1)/4;
  if (slv'left+1) mod 4 /= 0 then
    hexlen                          := hexlen + 1;
  end if;
  longslv(slv'left downto 0)        := slv;
  for i in (hexlen -1) downto 0 loop
    fourbit                         := longslv(((i*4)+3) downto (i*4));
    case fourbit is
      when "0000" => hex(hexlen -I) := '0';
      when "0001" => hex(hexlen -I) := '1';
      when "0010" => hex(hexlen -I) := '2';
      when "0011" => hex(hexlen -I) := '3';
      when "0100" => hex(hexlen -I) := '4';
      when "0101" => hex(hexlen -I) := '5';
      when "0110" => hex(hexlen -I) := '6';
      when "0111" => hex(hexlen -I) := '7';
      when "1000" => hex(hexlen -I) := '8';
      when "1001" => hex(hexlen -I) := '9';
      when "1010" => hex(hexlen -I) := 'A';
      when "1011" => hex(hexlen -I) := 'B';
      when "1100" => hex(hexlen -I) := 'C';
      when "1101" => hex(hexlen -I) := 'D';
      when "1110" => hex(hexlen -I) := 'E';
      when "1111" => hex(hexlen -I) := 'F';
      when "ZZZZ" => hex(hexlen -I) := 'z';
      when "UUUU" => hex(hexlen -I) := 'u';
      when "XXXX" => hex(hexlen -I) := 'x';
      when others => hex(hexlen -I) := '?';
    end case;
  end loop;
  return hex(1 to hexlen);
end hstr;

function int2char(int : integer) return character is
  variable c          : character;
begin
  case int is
    when 32 => c := ' ';
    when 33 => c := '!';
    when 34 => c := '"';
    when 35 => c := '#';
    when 36 => c := '$';
    when 37 => c := '%';
    when 38 => c := '&';
    when 39 => c := ' ';                -- should have been a single quotation mark:  '
    when 40 => c := '(';
    when 41 => c := ')';
    when 42  => c := '*';
    when 43  => c := '+';
    when 44  => c := ',';
    when 45  => c := '-';
    when 46  => c := '.';
    when 47  => c := '/';
    when 48  => c := '0';
    when 49  => c := '1';
    when 50  => c := '2';
    when 51  => c := '3';
    when 52  => c := '4';
    when 53  => c := '5';
    when 54  => c := '6';
    when 55  => c := '7';
    when 56  => c := '8';
    when 57  => c := '9';
    when 58  => c := ':';
    when 59  => c := ';';
    when 60  => c := '<';
    when 61  => c := '=';
    when 62  => c := '>';
    when 63  => c := '?';
    when 64  => c := '@';
    when 65  => c := 'A';
    when 66  => c := 'B';
    when 67  => c := 'C';
    when 68  => c := 'D';
    when 69  => c := 'E';
    when 70  => c := 'F';
    when 71  => c := 'G';
    when 72  => c := 'H';
    when 73  => c := 'I';
    when 74  => c := 'J';
    when 75  => c := 'K';
    when 76  => c := 'L';
    when 77  => c := 'M';
    when 78  => c := 'N';
    when 79  => c := 'O';
    when 80  => c := 'P';
    when 81  => c := 'Q';
    when 82  => c := 'R';
    when 83  => c := 'S';
    when 84  => c := 'T';
    when 85  => c := 'U';
    when 86  => c := 'V';
    when 87  => c := 'W';
    when 88  => c := 'X';
    when 89  => c := 'Y';
    when 90  => c := 'Z';
    when 91  => c := '[';
    when 92  => c := '\';
    when 93  => c := ']';
    when 94  => c := '^';
    when 95  => c := '_';
    when 96  => c := '`';
    when 97  => c := 'a';
    when 98  => c := 'b';
    when 99  => c := 'c';
    when 100 => c := 'd';
    when 101 => c := 'e';
    when 102 => c := 'f';
    when 103 => c := 'g';
    when 104 => c := 'h';
    when 105 => c := 'i';
    when 106 => c := 'j';
    when 107 => c := 'k';
    when 108 => c := 'l';
    when 109 => c := 'm';
    when 110 => c := 'n';
    when 111 => c := 'o';
    when 112 => c := 'p';
    when 113 => c := 'q';
    when 114 => c := 'r';
    when 115 => c := 's';
    when 116 => c := 't';
    when 117 => c := 'u';
    when 118 => c := 'v';
    when 119 => c := 'w';
    when 120 => c := 'x';
    when 121 => c := 'y';
    when 122 => c := 'z';
    when 123 => c := '{';
    when 124 => c := '|';
    when 125 => c := '}';
    when 126 => c := '~';
    when others => c := '?';
  end case;
  return c;
end int2char;


end Helper;
