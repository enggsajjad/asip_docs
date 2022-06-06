--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/23 17:11:44 
--
-- Module     : N-bit Adder with operator

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity fhm_alu_w32_add is
  port (a, b   : in  std_logic_vector(31 downto 0);
        cin    : in  std_logic;
        result : out std_logic_vector(31 downto 0);
        cout   : out std_logic);
end fhm_alu_w32_add;

architecture synthesis of fhm_alu_w32_add is
begin

  process (a, b, cin)
    variable int_a, int_b : std_logic_vector(32 downto 0);
    variable int_result   : std_logic_vector(32 downto 0);
  begin
    int_a      := '0' & a;
    int_b      := '0' & b;

    int_result := int_a + int_b + cin;

    result     <= int_result(31 downto 0);
    cout       <= int_result(32);

  end process;

end synthesis;

--%
--
--  	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-- Module     : Arithmetic Logic Unit
-- Feature    : 
-- References : 
-- Author     : Designed by T.Morifuji (c)1997,1998.

-- Version : 1.1  : all test is ok.
-- Version : 1.2  : modified by Y.Yamane 2001/12/26

-- Comment : function table is followings.
--  +-----------+-------------+-------------+---------+
--  |   mode    |   cin = 0   |   cin = 1   |  flag   |
--  +-----------+-------------+-------------+---------+
--  | 4 3 2 1 0 |   result    |   result    | c z s v |
--  +-----------+-------------+-------------+---------+
--  | 0 0 0 0 0 | a           | a + 1       | * * * 0 | unsigned (c)
--  | 0 0 0 0 1 | a + b       | a + b + 1   | * * * 0 | unsigned (c)
--  | 0 0 0 1 0 | a - b - 1   | a - b       | * * * 0 | unsigned (c)
--  | 0 0 0 1 1 | a - 1       | a           | * * * 0 | unsigned (c)
--  | 0 0 1 0 0 | a           | a +] 1      | * * * 0 | unsigned clip
--  | 0 0 1 0 1 | a +] b      | a +] b +] 1 | * * * 0 | unsigned clip
--  | 0 0 1 1 0 | a -] b -] 1 | a -] b      | * * * 0 | unsigned clip
--  | 0 0 1 1 1 | a -] 1      | a           | * * * 0 | unsigned clip
--  | 0 1 0 0 0 | a           | a + 1       | * * * * | signed (v)
--  | 0 1 0 0 1 | a + b       | a + b + 1   | * * * * | signed (v)
--  | 0 1 0 1 0 | a - b - 1   | a - b       | * * * * | signed (v)
--  | 0 1 0 1 1 | a - 1       | a           | * * * * | signed (v)
--  | 0 1 1 0 0 | a           | a +] 1      | * * * * | signed clip
--  | 0 1 1 0 1 | a +] b      | a +] b +] 1 | * * * * | signed clip
--  | 0 1 1 1 0 | a -] b -] 1 | a -] b      | * * * * | signed clip
--  | 0 1 1 1 1 | a -] 1      | a           | * * * * | signed clip
--  | 1 0 0 0 0 |           a or b          | 0 * * 0 |
--  | 1 0 0 0 1 |          a xor b          | 0 * * 0 |
--  | 1 0 0 1 0 |          a and b          | 0 * * 0 |
--  | 1 0 0 1 1 |           not a           | 0 * * 0 |
--  | 1 0 1 0 0 |             | max(a, b)   | * * * 0 | unsigned
--  | 1 0 1 0 1 |             | min(a, b)   | * * * 0 | unsigned
--  | 1 0 1 1 0 |             | max(a, b)   | * * * * | signed
--  | 1 0 1 1 1 |             | min(a, b)   | * * * * | signed
--  | 1 1 0 0 0 |          a nor b          | 0 * * 0 |
--  | 1 1 0 0 1 |         a nxor b          | 0 * * 0 |
--  | 1 1 0 1 0 |         a nand b          | 0 * * 0 |
--  | 1 1 0 1 1 |             |             | 0 * * 0 |
--  | 1 1 1 0 0 |             |             | 0 * * * |
--  | 1 1 1 0 1 |             |             | 0 * * * |
--  | 1 1 1 1 0 |             |             | 0 * * * |
--  | 1 1 1 1 1 |             |             | 0 * * * |
--  +-----------+-------------+-------------+---------+
-- C is '1' when (carry-occurred or not-bollowed) and unsigned-mode
--  	else
--      '0';
-- V is '1' when overflowed and signed-mode else
--      '0';
-- S is equal to MSB of result;
-- Z is '1' when result = 0 else
--      '0';

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;
  use IEEE.std_logic_arith.all;

entity fhm_alu_w32 is
  port (a, b 	: in std_logic_vector(31 downto 0);
        cin     : in std_logic;
        mode 	: in std_logic_vector(4 downto 0);
        result 	: out std_logic_vector(31 downto 0);
        flag 	: out std_logic_vector(3 downto 0) );
end fhm_alu_w32;

architecture synthesis of fhm_alu_w32 is

  component fhm_alu_w32_add
    port (a, b 	 : in std_logic_vector(31 downto 0);
          cin    : in std_logic;
          result : out std_logic_vector(31 downto 0);
          cout 	 : out std_logic);
  end component;

  signal ain, bin             : std_logic_vector(31 downto 0);
  signal sum                  : std_logic_vector(31 downto 0);
  signal unsigned_max         : std_logic_vector(31 downto 0);
  signal unsigned_min         : std_logic_vector(31 downto 0);
  signal signed_max           : std_logic_vector(31 downto 0);
  signal signed_min           : std_logic_vector(31 downto 0);
  signal clipped_signed_sum   : std_logic_vector(31 downto 0);
  signal clipped_unsigned_sum : std_logic_vector(31 downto 0);
  signal clipped_sum          : std_logic_vector(31 downto 0);
  signal tmp_cout             : std_logic;
  signal tmp_out              : std_logic_vector(31 downto 0);
  signal pre_result           : std_logic_vector(31 downto 0);
  signal V, C                 : std_logic;
  signal pre_pre_v            : std_logic;
  signal pre_v                : std_logic;
  signal unsigned_clipped     : std_logic;
  signal S, Z                 : std_logic;

  signal signed_max_value : std_logic_vector(31 downto 0);
  signal signed_min_value : std_logic_vector(31 downto 0);

begin

  --  input value of adder
  ain <= a;
  bin <= "00000000000000000000000000000000" when mode(1 downto 0) = "00"
                    and mode(4) = '0'          else -- a
         b     when mode(1 downto 0) = "01"
                    and mode(4) = '0'          else -- a + b
         not b when mode(1 downto 0) = "10"
                    or mode(4) = '1'           else -- a - b
  "11111111111111111111111111111111" when mode(1 downto 0) = "11"
                    and mode(4) = '0'          else -- a - 1
         "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  unsigned_clipped <= tmp_cout xor mode(1);

  clipped_unsigned_sum <= sum when unsigned_clipped = '0' else
  "11111111111111111111111111111111" when mode(1) = '0' else -- (+)
  "00000000000000000000000000000000"; -- (-)

  signed_max_value(31) <= '0';
  signed_max_value(30 downto 0) <= conv_std_logic_vector(-1, 31);
  signed_min_value(31) <= '1';
  signed_min_value(30 downto 0) <= conv_std_logic_vector(0, 31);

  clipped_signed_sum <= sum when pre_pre_v = '0' else
                        signed_max_value  -- (+)
                           when sum(31) = '1' else
                        signed_min_value; -- (-)

  clipped_sum <= sum when mode(2) = '0' else
                 clipped_unsigned_sum when mode(3) = '0' else
                 clipped_signed_sum;

  unsigned_max <= a when tmp_cout = '1' else
                  b;

  unsigned_min <= a when tmp_cout = '0' else
                  b;

  signed_max <= a when (a(31) = '0' and b(31) = '1') else
                b when (a(31) = '1' and b(31) = '0') else
                a when (tmp_cout = '1') else
                b;

  signed_min <= b when (a(31) = '0' and b(31) = '1') else
                a when (a(31) = '1' and b(31) = '0') else
                b when (tmp_cout = '1') else
                a;

  -- output
  tmp_out <= sum         when mode(2) = '0' else -- no clip
             clipped_sum when mode(2) = '1' else
             "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  S <= pre_result(31);

  C <= tmp_cout         when mode(4 downto 2) /= "100"
                         and mode(4 downto 2) /= "110" else
       '0';

  Z <= '1' when pre_result = conv_std_logic_vector(0, 32) else
       '0';

  pre_pre_v <= '1' when ((ain(31)='0' and bin(31) = '0'
                          and sum(31) = '1' )
                      or (ain(31)='1' and bin(31) = '1'
                                       and sum(31) = '0' )) else
               '0';

  pre_v <= '1' when mode(2) = '0' and pre_pre_v = '1' else
           '0';

  V <= pre_v     when mode(4 downto 2) = "010" else
       pre_pre_v when mode(4 downto 2) = "011"
               or mode(4 downto 1) = "1011" else
       '0';

  flag <= C & Z & S & V;

  pre_result <= tmp_out      when mode(4) = '0' else
               a or b        when mode(3 downto 0) = "0000" else
               a xor b       when mode(3 downto 0) = "0001" else
               a and b       when mode(3 downto 0) = "0010" else
               not a         when mode(3 downto 0) = "0011" else
               unsigned_max  when mode(3 downto 0) = "0100" else
               unsigned_min  when mode(3 downto 0) = "0101" else
               signed_max    when mode(3 downto 0) = "0110" else
               signed_min    when mode(3 downto 0) = "0111" else
               not (a or b)  when mode(3 downto 0) = "1000" else
               not (a xor b) when mode(3 downto 0) = "1001" else
               not (a and b) when mode(3 downto 0) = "1010" else
               "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

  result <= pre_result;

  -- port mapping add
  a0 : fhm_alu_w32_add
    port map (ain, bin, cin,
              sum, tmp_cout);

end synthesis;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------