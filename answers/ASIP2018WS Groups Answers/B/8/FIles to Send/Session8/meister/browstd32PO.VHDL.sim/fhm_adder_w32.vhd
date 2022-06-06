--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:05 
--
-- Module     : 32-bit unsigned adder
-- References :
-- Author     : Designed by T.Morifuji (c)1996.
-- Version    : 1.0

-- Functionality : behavior level
--  port
--   a, b   : add datas
--   cin    : carry in
--   result : result of a + b + c
--   cout   : '1' when result > 2^32-1

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity fhm_adder_w32 is
  port (a, b   : in std_logic_vector(31 downto 0);
        cin    : in std_logic;
        result : out std_logic_vector(31 downto 0);
        cout   : out std_logic);
end fhm_adder_w32;

architecture behavior of fhm_adder_w32 is

begin  -- behavior

  addition: process (a, b, cin)
    variable int_a, int_b : std_logic_vector(32 downto 0);
    variable int_result   : std_logic_vector(32 downto 0);
  begin
    int_a      := '0' & a;
    int_b      := '0' & b;

    int_result := int_a + int_b + cin;

    result     <= int_result(31 downto 0);
    cout       <= int_result(32);

  end process addition;

end behavior;


-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
