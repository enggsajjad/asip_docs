--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/25 13:50:57 
--
-- Module	 : Data Memory Interface Unit
-- Author	 : M. Itoh (c) 2000.
--                 Modified by J.Sato (c) 2001
--                 Modified by Y.Kobayashi (c) 2004
--                 Modified by K.Ueda (c) 2005
-- Version	 : 1.0

-- Functionality : synthesis level
--  port
--    addr_out         : address from cpu
--    data_in          : data input to cpu
--    aderr_in         : address error signal to cpu
--    addr2mem         : address to memory
--    data2cpu         : data from memory
--    aderr2cpu        : address error signal from memory

library ieee;
use ieee.std_logic_1164.all;

entity fhm_mifu_w32_00 is
    port (
      addr_out   : in  std_logic_vector(31 downto 0);
      data_in    : out std_logic_vector(31 downto 0);
      aderr_in   : out std_logic;
      addr2mem   : out std_logic_vector(31 downto 0);
      data2cpu   : in  std_logic_vector(31 downto 0);
      aderr2cpu  : in  std_logic
    );
end fhm_mifu_w32_00;

architecture synthesis of fhm_mifu_w32_00 is

begin
  addr2mem   <= addr_out;
  data_in    <= data2cpu;
  aderr_in   <= aderr2cpu;
end synthesis;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
