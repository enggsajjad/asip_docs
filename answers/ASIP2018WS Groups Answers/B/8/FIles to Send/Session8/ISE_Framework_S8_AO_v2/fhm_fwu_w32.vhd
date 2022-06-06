--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/02/04 13:20:43 
--
-- Module    : 32-bit data 5-bit address forwarding unit
-- Reference : Start from scratch
-- Author    : Designed by M.Itoh (c) 2000
--             Modified by K.Ueda (c) 2005
-- Version   : 1.1:

-- Functionality : synthesis
-- port
--  data0     : input data from storage unit
--  data1     : forwarding data from stage 1
--  data2     : forwarding data from stage 2
--  num0      :  address of data to be read
--  num1      : address of forwarding data from stage 1
--  num2      : address of forwarding data from stage 2
--  fw1       : valid flag from stage 1
--  fw2       : valid flag from stage 2
--  data_out  : output data

library IEEE;
use IEEE.std_logic_1164.all;

entity fhm_fwu_w32 is

  port (
    data0    : in  std_logic_vector(31 downto 0);
    data1    : in  std_logic_vector(31 downto 0);
    data2    : in  std_logic_vector(31 downto 0);
    num0     : in  std_logic_vector(4 downto 0);
    num1     : in  std_logic_vector(4 downto 0);
    num2     : in  std_logic_vector(4 downto 0);
    fw1      : in  std_logic;
    fw2      : in  std_logic;
    data_out : out std_logic_vector(31 downto 0));

end fhm_fwu_w32;

architecture synthesis of fhm_fwu_w32 is
  
begin  -- synthesis

  data_out <=
              data1 when (fw1 = '1') and (num0 = num1) else
              data2 when (fw2 = '1') and (num0 = num2) else
              data0;

end synthesis;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
