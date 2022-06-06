--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:05 
--
-- Module     : Shifter
-- Feature    : Shift Right or Left, Arithmetic or Logic
-- References : Started from scratch.
-- Author     : Designed by T.Morifuji (c)1996.

-- Version    : 1.1  : Modified by K.Ueda 2001/12/12
--                     Add rotate function
--            : 1.2  : Modified by Y.Yamane 2001/12/26
--            : 1.3  : Modified by Y.Yamane 2001/01/15

-- Comment :
--  mode
--   00  : shift left  logic
--   01  : shift left  arithmetic
--   10  : shift right logic
--   11  : shift right arithmetic

--  ctrl : shift amount


library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_arith.all;
  use IEEE.std_logic_unsigned.all;

entity fhm_shifter_w32 is
  port (data_in   : in  std_logic_vector(31 downto 0);
        mode      : in  std_logic_vector(1 downto 0);
        ctrl      : in  std_logic_vector(4 downto 0);
        data_out  : out std_logic_vector(31 downto 0));
end fhm_shifter_w32;

architecture behavior of fhm_shifter_w32 is

begin

  process(data_in, mode, ctrl)

    variable tmp : std_logic_vector(31 downto 0);
    variable amount : integer range 0 to 31;

  begin

    amount := conv_integer(unsigned(ctrl));

    case mode is
      when "00" =>  -- SLL
        tmp(31 downto amount) :=
          data_in(31-amount downto 0);
        tmp(amount-1 downto 0) := (others => '0'); 
      when "01" =>  -- SLA
        tmp(31) := data_in(31);
        tmp(30 downto amount) :=
          data_in(30-amount downto 0);
        tmp(amount-1 downto 0) := (others => '0'); 
      when "10" =>  -- SRL
        tmp(31 downto 32-amount) := (others => '0');
        tmp(31-amount downto 0) :=
          data_in(32-1 downto amount);
      when "11" =>  -- SRA
        tmp(31) := data_in(31);
        tmp(30 downto 31-amount) :=
          (others => data_in(31));
        tmp(31-amount downto 0) :=
          data_in(32-1 downto amount);
      when others =>
        tmp := (others => 'X');
    end case;

    data_out <= tmp;

  end process;
end behavior;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
