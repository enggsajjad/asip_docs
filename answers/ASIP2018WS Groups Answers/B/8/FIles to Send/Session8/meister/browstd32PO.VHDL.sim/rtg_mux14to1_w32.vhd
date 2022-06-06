----------------------------------------------------------------------
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:26:49 
----------------------------------------------------------------------

-----------------------------------------------------------
-- Entity Name: rtg_mux14to1_w32
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity rtg_mux14to1_w32 is
  port (
    SEL : in std_logic_vector(3 downto 0);
    DIN0 : in std_logic_vector(31 downto 0);
    DIN1 : in std_logic_vector(31 downto 0);
    DIN2 : in std_logic_vector(31 downto 0);
    DIN3 : in std_logic_vector(31 downto 0);
    DIN4 : in std_logic_vector(31 downto 0);
    DIN5 : in std_logic_vector(31 downto 0);
    DIN6 : in std_logic_vector(31 downto 0);
    DIN7 : in std_logic_vector(31 downto 0);
    DIN8 : in std_logic_vector(31 downto 0);
    DIN9 : in std_logic_vector(31 downto 0);
    DIN10 : in std_logic_vector(31 downto 0);
    DIN11 : in std_logic_vector(31 downto 0);
    DIN12 : in std_logic_vector(31 downto 0);
    DIN13 : in std_logic_vector(31 downto 0);
    DOUT : out std_logic_vector(31 downto 0)
  );
end entity rtg_mux14to1_w32;

architecture RTL of rtg_mux14to1_w32 is


begin
  DOUT <= 
	DIN0 when SEL = "0000" else 
	DIN1 when SEL = "0001" else 
	DIN2 when SEL = "0010" else 
	DIN3 when SEL = "0011" else 
	DIN4 when SEL = "0100" else 
	DIN5 when SEL = "0101" else 
	DIN6 when SEL = "0110" else 
	DIN7 when SEL = "0111" else 
	DIN8 when SEL = "1000" else 
	DIN9 when SEL = "1001" else 
	DIN10 when SEL = "1010" else 
	DIN11 when SEL = "1011" else 
	DIN12 when SEL = "1100" else 
	DIN13 when SEL = "1101" else 
	"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
end RTL;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
