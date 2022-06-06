--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:13 
--
-- Module     : 1-bit input wire
-- Feature    : 
-- References : refer to wire.fhm by Y.Kobayashi (c)2003.
-- Author     : Designed by K.Ueda (c)2004.
-- Version    : 1.0 :
-- Functionality :
--  port
--   int_port : internal port
--   ext_port : external port
-- Comment :

library IEEE;
use IEEE.std_logic_1164.all;

entity fhm_wire_in_w1 is
  port (
    int_port : out std_logic;
    ext_port : in  std_logic);
end fhm_wire_in_w1;

architecture synthesis of fhm_wire_in_w1 is
begin
  int_port <= ext_port;
end synthesis;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
