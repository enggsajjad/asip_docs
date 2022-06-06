--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:05 
--
-- Module	: 32-bit program counter unit
--                4 increment step
-- Refereces	:
-- Author	: Designed by M. Itoh (c)1998
-- Version	: 1.0 :

-- Functionality : behavior level
-- port
--  clock       : clock 
--  async_reset : asynchronous reset ('1' active)
--  load        : '1' then set counter value
--  reset       : synchronous reset ('1' active)
--  hold        : '1' then hold counter value
--  data_in     : data to register
--  data_out    : registered data

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_signed.all;

entity fhm_pcu_w32 is
  port (
    clock       : in  std_logic;
    async_reset : in  std_logic;
    load        : in  std_logic;
    reset       : in  std_logic;
    hold        : in  std_logic;
    data_in     : in  std_logic_vector(31 downto 0);
    data_out    : out std_logic_vector(31 downto 0));
end fhm_pcu_w32;

architecture behavior of fhm_pcu_w32 is
begin
  
  process(async_reset, clock)
    variable count : std_logic_vector(31 downto 0);
  begin
    if(async_reset = '1') then
      count := "00000000000000000000000000000000";
    elsif(clock'event and clock='1') then
      if (reset = '1') then
        count := (others => '0');
      elsif (load = '1') then
        count := data_in;
      elsif (hold = '0') then 
        count := count + 4;
      end if;
    end if;
    data_out <= count;
  end process;
end behavior;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
