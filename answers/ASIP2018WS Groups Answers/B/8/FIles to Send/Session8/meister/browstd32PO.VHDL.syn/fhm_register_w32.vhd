--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:12 
--

-- Module     : 32-bit Positive Edge Trigger Register
-- Feature    : positive edge trigger
-- References : Started from scratch
-- Author     : Designed by T.Morifuji (c)1997.

-- Version    : 1.0  :

-- Functionality :
--  port
--   clock       : clock port
--   async_reset : asynchronous reset port
--   reset       : synchronous reset port
--   enb         : write enable control
--   data_in     : input data
--   data_out    : output data

-- Comment :

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity fhm_register_w32 is
  port (clock       : in std_logic;
        async_reset : in std_logic;
        reset       : in std_logic;
        enb         : in std_logic;
        data_in     : in std_logic_vector(31 downto 0);
        data_out    : out std_logic_vector(31 downto 0) );
end fhm_register_w32;

architecture logic of fhm_register_w32 is
begin

  process (clock, async_reset)
  begin
    if (async_reset = '1') then
      data_out <= "00000000000000000000000000000000";
    elsif (clock'event and clock = '1') then
      if (reset = '1') then
        data_out <= (others => '0');
      elsif (enb = '1') then
        data_out <= data_in;
      end if;
    end if;
  end process;

end logic;


-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
