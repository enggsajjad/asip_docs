--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:05 
--
-- Module	 : Data Memory Interface Unit
-- Author	 : M. Itoh (c) 2000.
--                 Modified by J.Sato (c) 2001
--                 Modified by Y.Kobayashi (c) 2004
--                 Modified by K.Ueda (c) 2005
-- Version	 : 1.0

-- Functionality : behavior level
--  port
--    req_out          : memory access request from cpu
--    ack_in           : memory access ack to cpu
--    cancel_out       : cancel signal from cpu
--    req2mem          : memory access request to memory
--    ack2cpu          : memory access ack from memory
--    cancel2mem       : cancel signal to memory
--    addr_out         : address from cpu
--    data_in          : data input to cpu
--    aderr_in         : address error signal to cpu
--    addr2mem         : address to memory
--    data2cpu         : data from memory
--    aderr2cpu        : address error signal from memory
--    rw_out           : read/write mode from cpu
--                       0 => read
--                       1 => write
--    data_out         : data output from cpu
--    rw2mem           : read/write mode to memory
--    data2mem         : data to memory
--    mode_out         : access mode from cpu
--                       11 => 32 bits access
--                       10 => 24 bits access
--                       01 => 16 bits access
--                       00 => 8 bits access
--    ext_out          : extention mode from cpu
--                       0 => zero extention
--                       1 => sign extention
--    mode2mem         : access mode to memory
--    ext2mem          : extention mode to memory

library ieee;
use ieee.std_logic_1164.all;

entity fhm_mifu_w32_01 is
    port (
      req_out    : in  std_logic;
      ack_in     : out std_logic;
      cancel_out : in  std_logic;
      req2mem    : out std_logic;
      ack2cpu    : in  std_logic;
      cancel2mem : out std_logic;
      rw_out     : in  std_logic;
      data_out   : in  std_logic_vector(31 downto 0);
      rw2mem     : out std_logic;
      data2mem   : out std_logic_vector(31 downto 0);
      mode_out   : in  std_logic_vector(1 downto 0);
      ext_out    : in  std_logic;
      mode2mem   : out std_logic_vector(1 downto 0);
      ext2mem    : out std_logic;
      addr_out   : in  std_logic_vector(31 downto 0);
      data_in    : out std_logic_vector(31 downto 0);
      aderr_in   : out std_logic;
      addr2mem   : out std_logic_vector(31 downto 0);
      data2cpu   : in  std_logic_vector(31 downto 0);
      aderr2cpu  : in  std_logic
    );
end fhm_mifu_w32_01;

architecture behavior of fhm_mifu_w32_01 is

begin
  process (
req_out, cancel_out, ack2cpu, rw_out, data_out, mode_out, ext_out,
  	addr_out, data2cpu, aderr2cpu) begin -- process
    req2mem    <= req_out;
    ack_in     <= ack2cpu;
    cancel2mem <= cancel_out;
    addr2mem   <= addr_out;
    data_in    <= data2cpu;
    aderr_in   <= aderr2cpu;
    rw2mem     <= rw_out;
    data2mem   <= data_out;
    mode2mem   <= mode_out;
    ext2mem    <= ext_out;
  end process;
  
end behavior;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
