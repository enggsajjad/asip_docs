----------------------------------------------------------------------
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/23 17:11:30 
----------------------------------------------------------------------

-----------------------------------------------------------
-- Entity Name: rtg_register_w1
-----------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity rtg_register_w1 is
  port (
    CLK : in std_logic;
    RST : in std_logic;
    ENB : in std_logic;
    DIN : in std_logic;
    DOUT : out std_logic
  );
end entity rtg_register_w1;

architecture RTL of rtg_register_w1 is


begin
  process (RST, CLK)
  begin
    if RST = '1' then
      DOUT <= '0';
    elsif CLK'event and CLK = '1' then
      if ENB = '1' then
        DOUT <= DIN;
      end if;
    end if;
  end process;
end RTL;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
