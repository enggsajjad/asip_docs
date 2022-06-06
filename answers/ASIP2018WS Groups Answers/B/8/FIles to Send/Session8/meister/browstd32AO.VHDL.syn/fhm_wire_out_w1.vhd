--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/23 17:11:44 
--
-- Module     : 1-bit output wire
-- Feature    : 
-- References : refer to wire.fhm by Y.Kobayashi (c)2003.
-- Author     : Designed by K.Ueda (c)2004.
-- Version    : 1.0 :
-- Functionality :
--  port
--   int_port    : internal port
--   ext_port    : external port
--   wmode       : write mode
--              '1' : write data of int_port
--              '0' : write default data ('0')
-- Comment :

library IEEE;
use IEEE.std_logic_1164.all;

entity fhm_wire_out_w1 is
  port (
    int_port    : in  std_logic;
    ext_port    : out std_logic;
    wmode       : in  std_logic);
end fhm_wire_out_w1;

architecture synthesis of fhm_wire_out_w1 is
begin
  ext_port <= int_port when (wmode = '1') else
              '0';
end synthesis;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
