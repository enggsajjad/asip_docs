----------------------------------------------------------------------
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/25 13:50:58 
----------------------------------------------------------------------

-----------------------------------------------------------
-- Entity Name: rtg_mux2to1_w5
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity rtg_mux2to1_w5 is
  port (
    SEL : in std_logic;
    DIN0 : in std_logic_vector(4 downto 0);
    DIN1 : in std_logic_vector(4 downto 0);
    DOUT : out std_logic_vector(4 downto 0)
  );
end entity rtg_mux2to1_w5;

architecture RTL of rtg_mux2to1_w5 is


begin
  DOUT <= 
	DIN0 when SEL = '0' else 
	DIN1 when SEL = '1' else 
	"XXXXX";
end RTL;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
