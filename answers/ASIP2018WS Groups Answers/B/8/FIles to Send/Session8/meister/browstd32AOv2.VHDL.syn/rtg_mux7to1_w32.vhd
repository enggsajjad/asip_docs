----------------------------------------------------------------------
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/02/04 13:20:44 
----------------------------------------------------------------------

-----------------------------------------------------------
-- Entity Name: rtg_mux7to1_w32
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity rtg_mux7to1_w32 is
  port (
    SEL : in std_logic_vector(2 downto 0);
    DIN0 : in std_logic_vector(31 downto 0);
    DIN1 : in std_logic_vector(31 downto 0);
    DIN2 : in std_logic_vector(31 downto 0);
    DIN3 : in std_logic_vector(31 downto 0);
    DIN4 : in std_logic_vector(31 downto 0);
    DIN5 : in std_logic_vector(31 downto 0);
    DIN6 : in std_logic_vector(31 downto 0);
    DOUT : out std_logic_vector(31 downto 0)
  );
end entity rtg_mux7to1_w32;

architecture RTL of rtg_mux7to1_w32 is


begin
  DOUT <= 
	DIN0 when SEL = "000" else 
	DIN1 when SEL = "001" else 
	DIN2 when SEL = "010" else 
	DIN3 when SEL = "011" else 
	DIN4 when SEL = "100" else 
	DIN5 when SEL = "101" else 
	DIN6 when SEL = "110" else 
	"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
end RTL;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------