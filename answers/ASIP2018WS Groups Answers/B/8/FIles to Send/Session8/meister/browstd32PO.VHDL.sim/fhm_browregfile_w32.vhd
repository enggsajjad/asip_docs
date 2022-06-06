--
-- Copyright (C) 2011 ASIP Solutions, Inc. All rights reserved. 
-- Generated by ASIP Meister 2.3 on 2019/01/30 15:36:05 
--
-- Module     : 5-bit positive edge trigger register
-- References :
-- Author     : Designed by Hirofumi IWATO (c) 2008.
-- Version    : 1.0  :

-- Functionality : synthesis level
--  port
--   clock       : clock
--   async_reset : asynchronous reset
--   reset       : synchronous reset
--   enb         : '1' then register data
--   data_in     : data to register
--   data_out    : registered data

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity flag_reg5 is
  port (clock       : in  std_logic;
        async_reset : in  std_logic;
        reset       : in  std_logic;
        enb         : in  std_logic;
        data_in     : in  std_logic_vector(4 downto 0);
        data_out    : out std_logic_vector(4 downto 0) );
end flag_reg5;

architecture synthesis of flag_reg5 is
begin

  process (clock, async_reset)
  begin
    if (async_reset = '1') then
      data_out <= "00000";
    elsif (clock'event and clock = '1') then
      if (reset = '1') then
        data_out <= (others => '0');
      elsif (enb = '1') then
        data_out <= data_in;
      end if;
    end if;
  end process;

end synthesis;

--%%'

-- Module     : 27-bit positive edge trigger register
-- References :
-- Author     : Designed by Hirofumi IWATO (c) 2008.
-- Version    : 1.0  :

-- Functionality : synthesis level
--  port
--   clock       : clock
--   async_reset : asynchronous reset
--   reset       : synchronous reset
--   enb         : '1' then register data
--   data_in     : data to register
--   data_out    : registered data

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity status_reg27 is
  port (clock       : in  std_logic;
        async_reset : in  std_logic;
        reset       : in  std_logic;
        enb         : in  std_logic;
        data_in     : in  std_logic_vector(26 downto 0);
        data_out    : out std_logic_vector(26 downto 0) );
end status_reg27;

architecture synthesis of status_reg27 is
begin

  process (clock, async_reset)
  begin
    if (async_reset = '1') then
      data_out <= "000000000000000000000000000";
    elsif (clock'event and clock = '1') then
      if (reset = '1') then
        data_out <= (others => '0');
      elsif (enb = '1') then
        data_out <= data_in;
      end if;
    end if;
  end process;

end synthesis;

--%%'

-- Module     : 32-bit positive edge trigger register
-- References :
-- Author     : Designed by Hirofumi IWATO (c) 2008.
-- Version    : 1.0  :

-- Functionality : synthesis level
--  port
--   clock       : clock
--   async_reset : asynchronous reset
--   reset       : synchronous reset
--   enb         : '1' then register data
--   data_in     : data to register
--   data_out    : registered data

library IEEE;
  use IEEE.std_logic_1164.all;
  use IEEE.std_logic_unsigned.all;

entity fhm_browregfile_w32_reg32 is
  port (clock       : in  std_logic;
        async_reset : in  std_logic;
        reset       : in  std_logic;
        enb         : in  std_logic;
        data_in     : in  std_logic_vector(31 downto 0);
        data_out    : out std_logic_vector(31 downto 0) );
end fhm_browregfile_w32_reg32;

architecture synthesis of fhm_browregfile_w32_reg32 is
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

end synthesis;

-- %%'

-- Module       : 32-bit registerfile with zero and status register
--                with 32 registers, 4 read ports, 1 write ports
-- Refereces    :
-- Author       : Designed by Hirofumi IWATO (c) 2008.
-- Version      : 1.0 :

-- Functionality : synthesis level
-- port
--  clock       : clock 
--  async_reset : '1' then asynchronously reset registers
--  reset       : '1' then synchronously reset registers
--  w_enb*      : '1' then update register value
--  w_sel*      : selected register to write
--  data_in*    : data to register
--  r_sel*      : selected register to read
--  data_out*   : registered data
--  status_in   : status register in
--  status_out  : status register out
--  status_enb  : status register write enable
--  flag_in     : flag in
--  flag_enb    : flag write enable
-- do_swap : when do_swap is 1, current bank will change at the next
--  	cycle
--  next_bank   : register bank index at the next cycle
--  cur_bank    : current bank index


library IEEE;
use IEEE.std_logic_1164.all;

entity fhm_browregfile_w32 is
  
  port (
    clock		: in  std_logic;
    async_reset		: in  std_logic;
    reset		: in  std_logic;
    w_enb0		: in  std_logic;
    w_sel0		: in  std_logic_vector(4 downto 0);
    data_in0		: in  std_logic_vector(31 downto 0);
    r_sel0		: in  std_logic_vector(4 downto 0);
    r_sel1		: in  std_logic_vector(4 downto 0);
    r_sel2		: in  std_logic_vector(4 downto 0);
    r_sel3		: in  std_logic_vector(4 downto 0);
    data_out0		: out std_logic_vector(31 downto 0);
    data_out1		: out std_logic_vector(31 downto 0);
    data_out2		: out std_logic_vector(31 downto 0);
    data_out3		: out std_logic_vector(31 downto 0);
    next_bank		: in  std_logic;
    current_bank	: out std_logic;
    status_out   	: out std_logic_vector(31 downto 0);
    status_in		: in  std_logic_vector(31 downto 0);
    status_enb		: in  std_logic;
    flag_in		: in  std_logic_vector(4 downto 0);
    flag_enb		: in  std_logic;
    do_swap		: in  std_logic );

end fhm_browregfile_w32;

architecture synthesis of fhm_browregfile_w32 is

  component flag_reg5
    port (
      clock       : in  std_logic;
      async_reset : in  std_logic;
      reset       : in  std_logic;
      enb         : in  std_logic;
      data_in     : in  std_logic_vector(4 downto 0);
      data_out    : out std_logic_vector(4 downto 0));
  end component;

  component status_reg27
    port (
      clock       : in  std_logic;
      async_reset : in  std_logic;
      reset       : in  std_logic;
      enb         : in  std_logic;
      data_in     : in  std_logic_vector(26 downto 0);
      data_out    : out std_logic_vector(26 downto 0));
  end component;

  component fhm_browregfile_w32_reg32
    port (
      clock       : in  std_logic;
      async_reset : in  std_logic;
      reset       : in  std_logic;
      enb         : in  std_logic;
      data_in     : in  std_logic_vector(31 downto 0);
      data_out    : out std_logic_vector(31 downto 0));
  end component;

  signal data_in_tmp0  : std_logic_vector(31 downto 0);
  signal data_out_tmp0 : std_logic_vector(31 downto 0);
  signal w_enb_tmp0    : std_logic;
  signal data_in_tmp1  : std_logic_vector(31 downto 0);
  signal data_out_tmp1 : std_logic_vector(31 downto 0);
  signal w_enb_tmp1    : std_logic;
  signal data_in_tmp2  : std_logic_vector(31 downto 0);
  signal data_out_tmp2 : std_logic_vector(31 downto 0);
  signal w_enb_tmp2    : std_logic;
  signal data_in_tmp3  : std_logic_vector(31 downto 0);
  signal data_out_tmp3 : std_logic_vector(31 downto 0);
  signal w_enb_tmp3    : std_logic;
  signal data_in_tmp4  : std_logic_vector(31 downto 0);
  signal data_out_tmp4 : std_logic_vector(31 downto 0);
  signal w_enb_tmp4    : std_logic;
  signal data_in_tmp5  : std_logic_vector(31 downto 0);
  signal data_out_tmp5 : std_logic_vector(31 downto 0);
  signal w_enb_tmp5    : std_logic;
  signal data_in_tmp6  : std_logic_vector(31 downto 0);
  signal data_out_tmp6 : std_logic_vector(31 downto 0);
  signal w_enb_tmp6    : std_logic;
  signal data_in_tmp7  : std_logic_vector(31 downto 0);
  signal data_out_tmp7 : std_logic_vector(31 downto 0);
  signal w_enb_tmp7    : std_logic;
  signal data_in_tmp8  : std_logic_vector(31 downto 0);
  signal data_out_tmp8 : std_logic_vector(31 downto 0);
  signal w_enb_tmp8    : std_logic;
  signal data_in_tmp9  : std_logic_vector(31 downto 0);
  signal data_out_tmp9 : std_logic_vector(31 downto 0);
  signal w_enb_tmp9    : std_logic;
  signal data_in_tmp10  : std_logic_vector(31 downto 0);
  signal data_out_tmp10 : std_logic_vector(31 downto 0);
  signal w_enb_tmp10    : std_logic;
  signal data_in_tmp11  : std_logic_vector(31 downto 0);
  signal data_out_tmp11 : std_logic_vector(31 downto 0);
  signal w_enb_tmp11    : std_logic;
  signal data_in_tmp12  : std_logic_vector(31 downto 0);
  signal data_out_tmp12 : std_logic_vector(31 downto 0);
  signal w_enb_tmp12    : std_logic;
  signal data_in_tmp13  : std_logic_vector(31 downto 0);
  signal data_out_tmp13 : std_logic_vector(31 downto 0);
  signal w_enb_tmp13    : std_logic;
  signal data_in_tmp14  : std_logic_vector(31 downto 0);
  signal data_out_tmp14 : std_logic_vector(31 downto 0);
  signal w_enb_tmp14    : std_logic;
  signal data_in_tmp15  : std_logic_vector(31 downto 0);
  signal data_out_tmp15 : std_logic_vector(31 downto 0);
  signal w_enb_tmp15    : std_logic;
  signal data_in_tmp16  : std_logic_vector(31 downto 0);
  signal data_out_tmp16 : std_logic_vector(31 downto 0);
  signal w_enb_tmp16    : std_logic;
  signal data_in_tmp17  : std_logic_vector(31 downto 0);
  signal data_out_tmp17 : std_logic_vector(31 downto 0);
  signal w_enb_tmp17    : std_logic;
  signal data_in_tmp18  : std_logic_vector(31 downto 0);
  signal data_out_tmp18 : std_logic_vector(31 downto 0);
  signal w_enb_tmp18    : std_logic;
  signal data_in_tmp19  : std_logic_vector(31 downto 0);
  signal data_out_tmp19 : std_logic_vector(31 downto 0);
  signal w_enb_tmp19    : std_logic;
  signal data_in_tmp20  : std_logic_vector(31 downto 0);
  signal data_out_tmp20 : std_logic_vector(31 downto 0);
  signal w_enb_tmp20    : std_logic;
  signal data_in_tmp21  : std_logic_vector(31 downto 0);
  signal data_out_tmp21 : std_logic_vector(31 downto 0);
  signal w_enb_tmp21    : std_logic;
  signal data_in_tmp22  : std_logic_vector(31 downto 0);
  signal data_out_tmp22 : std_logic_vector(31 downto 0);
  signal w_enb_tmp22    : std_logic;
  signal data_in_tmp23  : std_logic_vector(31 downto 0);
  signal data_out_tmp23 : std_logic_vector(31 downto 0);
  signal w_enb_tmp23    : std_logic;
  signal data_in_tmp24  : std_logic_vector(31 downto 0);
  signal data_out_tmp24 : std_logic_vector(31 downto 0);
  signal w_enb_tmp24    : std_logic;
  signal data_in_tmp25  : std_logic_vector(31 downto 0);
  signal data_out_tmp25 : std_logic_vector(31 downto 0);
  signal w_enb_tmp25    : std_logic;
  signal data_in_tmp26  : std_logic_vector(31 downto 0);
  signal data_out_tmp26 : std_logic_vector(31 downto 0);
  signal w_enb_tmp26    : std_logic;
  signal data_in_tmp27  : std_logic_vector(31 downto 0);
  signal data_out_tmp27 : std_logic_vector(31 downto 0);
  signal w_enb_tmp27    : std_logic;
  signal data_in_tmp28  : std_logic_vector(31 downto 0);
  signal data_out_tmp28 : std_logic_vector(31 downto 0);
  signal w_enb_tmp28    : std_logic;
  signal data_in_tmp29  : std_logic_vector(31 downto 0);
  signal data_out_tmp29 : std_logic_vector(31 downto 0);
  signal w_enb_tmp29    : std_logic;
  signal data_in_tmp30  : std_logic_vector(31 downto 0);
  signal data_out_tmp30 : std_logic_vector(31 downto 0);
  signal w_enb_tmp30    : std_logic;
  signal data_in_tmp31  : std_logic_vector(31 downto 0);
  signal data_out_tmp31 : std_logic_vector(31 downto 0);
  signal w_enb_tmp31    : std_logic;
  signal flag_out_tmp   : std_logic_vector(4 downto 0);
  signal streg_enb_tmp  : std_logic;
  signal streg_in_tmp   : std_logic_vector(26 downto 0);
  signal streg_out_tmp  : std_logic_vector(26 downto 0);
  signal kernel_mode    : std_logic;

begin  -- synthesis

  -- zero register
  data_out_tmp0  <= "00000000000000000000000000000000";

  -- user can update status register in kernel mode only
  streg_enb_tmp <= status_enb or (w_enb_tmp1 and not kernel_mode);
  streg_in_tmp  <= status_in(31 downto 5) when status_enb = '1' else
                   data_in_tmp1(31 downto 5);

  data_out_tmp1 <= (streg_out_tmp & flag_out_tmp);
  status_out    <= data_out_tmp1;

  -- kernel flag
  kernel_mode    <= data_out_tmp1(14);

  FLAG_REG : flag_reg5
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => flag_enb,
    data_in     => flag_in,
    data_out    => flag_out_tmp);

  STREG : status_reg27
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => streg_enb_tmp,
    data_in     => streg_in_tmp,
    data_out    => streg_out_tmp);

  REG2 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp2,
    data_in     => data_in_tmp2,
    data_out    => data_out_tmp2);
    
  REG3 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp3,
    data_in     => data_in_tmp3,
    data_out    => data_out_tmp3);
    
  REG4 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp4,
    data_in     => data_in_tmp4,
    data_out    => data_out_tmp4);
    
  REG5 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp5,
    data_in     => data_in_tmp5,
    data_out    => data_out_tmp5);
    
  REG6 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp6,
    data_in     => data_in_tmp6,
    data_out    => data_out_tmp6);
    
  REG7 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp7,
    data_in     => data_in_tmp7,
    data_out    => data_out_tmp7);
    
  REG8 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp8,
    data_in     => data_in_tmp8,
    data_out    => data_out_tmp8);
    
  REG9 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp9,
    data_in     => data_in_tmp9,
    data_out    => data_out_tmp9);
    
  REG10 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp10,
    data_in     => data_in_tmp10,
    data_out    => data_out_tmp10);
    
  REG11 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp11,
    data_in     => data_in_tmp11,
    data_out    => data_out_tmp11);
    
  REG12 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp12,
    data_in     => data_in_tmp12,
    data_out    => data_out_tmp12);
    
  REG13 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp13,
    data_in     => data_in_tmp13,
    data_out    => data_out_tmp13);
    
  REG14 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp14,
    data_in     => data_in_tmp14,
    data_out    => data_out_tmp14);
    
  REG15 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp15,
    data_in     => data_in_tmp15,
    data_out    => data_out_tmp15);
    
  REG16 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp16,
    data_in     => data_in_tmp16,
    data_out    => data_out_tmp16);
    
  REG17 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp17,
    data_in     => data_in_tmp17,
    data_out    => data_out_tmp17);
    
  REG18 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp18,
    data_in     => data_in_tmp18,
    data_out    => data_out_tmp18);
    
  REG19 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp19,
    data_in     => data_in_tmp19,
    data_out    => data_out_tmp19);
    
  REG20 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp20,
    data_in     => data_in_tmp20,
    data_out    => data_out_tmp20);
    
  REG21 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp21,
    data_in     => data_in_tmp21,
    data_out    => data_out_tmp21);
    
  REG22 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp22,
    data_in     => data_in_tmp22,
    data_out    => data_out_tmp22);
    
  REG23 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp23,
    data_in     => data_in_tmp23,
    data_out    => data_out_tmp23);
    
  REG24 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp24,
    data_in     => data_in_tmp24,
    data_out    => data_out_tmp24);
    
  REG25 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp25,
    data_in     => data_in_tmp25,
    data_out    => data_out_tmp25);
    
  REG26 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp26,
    data_in     => data_in_tmp26,
    data_out    => data_out_tmp26);
    
  REG27 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp27,
    data_in     => data_in_tmp27,
    data_out    => data_out_tmp27);
    
  REG28 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp28,
    data_in     => data_in_tmp28,
    data_out    => data_out_tmp28);
    
  REG29 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp29,
    data_in     => data_in_tmp29,
    data_out    => data_out_tmp29);
    
  REG30 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp30,
    data_in     => data_in_tmp30,
    data_out    => data_out_tmp30);
    
  REG31 : fhm_browregfile_w32_reg32
  port map (
    clock       => clock,
    async_reset => async_reset,
    reset       => reset,
    enb         => w_enb_tmp31,
    data_in     => data_in_tmp31,
    data_out    => data_out_tmp31);
    
  w_enb_tmp1 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00001") else
                '0';

  w_enb_tmp2 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00010") else
                '0';

  w_enb_tmp3 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00011") else
                '0';

  w_enb_tmp4 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00100") else
                '0';

  w_enb_tmp5 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00101") else
                '0';

  w_enb_tmp6 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00110") else
                '0';

  w_enb_tmp7 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "00111") else
                '0';

  w_enb_tmp8 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01000") else
                '0';

  w_enb_tmp9 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01001") else
                '0';

  w_enb_tmp10 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01010") else
                '0';

  w_enb_tmp11 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01011") else
                '0';

  w_enb_tmp12 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01100") else
                '0';

  w_enb_tmp13 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01101") else
                '0';

  w_enb_tmp14 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01110") else
                '0';

  w_enb_tmp15 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "01111") else
                '0';

  w_enb_tmp16 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10000") else
                '0';

  w_enb_tmp17 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10001") else
                '0';

  w_enb_tmp18 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10010") else
                '0';

  w_enb_tmp19 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10011") else
                '0';

  w_enb_tmp20 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10100") else
                '0';

  w_enb_tmp21 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10101") else
                '0';

  w_enb_tmp22 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10110") else
                '0';

  w_enb_tmp23 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "10111") else
                '0';

  w_enb_tmp24 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11000") else
                '0';

  w_enb_tmp25 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11001") else
                '0';

  w_enb_tmp26 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11010") else
                '0';

  w_enb_tmp27 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11011") else
                '0';

  w_enb_tmp28 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11100") else
                '0';

  w_enb_tmp29 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11101") else
                '0';

  w_enb_tmp30 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11110") else
                '0';

  w_enb_tmp31 <= '1' when
                 (w_enb0 = '1' and w_sel0 = "11111") else
                '0';

  data_in_tmp1 <= data_in0;
  data_in_tmp2 <= data_in0;
  data_in_tmp3 <= data_in0;
  data_in_tmp4 <= data_in0;
  data_in_tmp5 <= data_in0;
  data_in_tmp6 <= data_in0;
  data_in_tmp7 <= data_in0;
  data_in_tmp8 <= data_in0;
  data_in_tmp9 <= data_in0;
  data_in_tmp10 <= data_in0;
  data_in_tmp11 <= data_in0;
  data_in_tmp12 <= data_in0;
  data_in_tmp13 <= data_in0;
  data_in_tmp14 <= data_in0;
  data_in_tmp15 <= data_in0;
  data_in_tmp16 <= data_in0;
  data_in_tmp17 <= data_in0;
  data_in_tmp18 <= data_in0;
  data_in_tmp19 <= data_in0;
  data_in_tmp20 <= data_in0;
  data_in_tmp21 <= data_in0;
  data_in_tmp22 <= data_in0;
  data_in_tmp23 <= data_in0;
  data_in_tmp24 <= data_in0;
  data_in_tmp25 <= data_in0;
  data_in_tmp26 <= data_in0;
  data_in_tmp27 <= data_in0;
  data_in_tmp28 <= data_in0;
  data_in_tmp29 <= data_in0;
  data_in_tmp30 <= data_in0;
  data_in_tmp31 <= data_in0;
  data_out0 <= data_out_tmp0 when r_sel0 = "00000" else
               data_out_tmp1 when r_sel0 = "00001" else
               data_out_tmp2 when r_sel0 = "00010" else
               data_out_tmp3 when r_sel0 = "00011" else
               data_out_tmp4 when r_sel0 = "00100" else
               data_out_tmp5 when r_sel0 = "00101" else
               data_out_tmp6 when r_sel0 = "00110" else
               data_out_tmp7 when r_sel0 = "00111" else
               data_out_tmp8 when r_sel0 = "01000" else
               data_out_tmp9 when r_sel0 = "01001" else
               data_out_tmp10 when r_sel0 = "01010" else
               data_out_tmp11 when r_sel0 = "01011" else
               data_out_tmp12 when r_sel0 = "01100" else
               data_out_tmp13 when r_sel0 = "01101" else
               data_out_tmp14 when r_sel0 = "01110" else
               data_out_tmp15 when r_sel0 = "01111" else
               data_out_tmp16 when r_sel0 = "10000" else
               data_out_tmp17 when r_sel0 = "10001" else
               data_out_tmp18 when r_sel0 = "10010" else
               data_out_tmp19 when r_sel0 = "10011" else
               data_out_tmp20 when r_sel0 = "10100" else
               data_out_tmp21 when r_sel0 = "10101" else
               data_out_tmp22 when r_sel0 = "10110" else
               data_out_tmp23 when r_sel0 = "10111" else
               data_out_tmp24 when r_sel0 = "11000" else
               data_out_tmp25 when r_sel0 = "11001" else
               data_out_tmp26 when r_sel0 = "11010" else
               data_out_tmp27 when r_sel0 = "11011" else
               data_out_tmp28 when r_sel0 = "11100" else
               data_out_tmp29 when r_sel0 = "11101" else
               data_out_tmp30 when r_sel0 = "11110" else
               data_out_tmp31;
  data_out1 <= data_out_tmp0 when r_sel1 = "00000" else
               data_out_tmp1 when r_sel1 = "00001" else
               data_out_tmp2 when r_sel1 = "00010" else
               data_out_tmp3 when r_sel1 = "00011" else
               data_out_tmp4 when r_sel1 = "00100" else
               data_out_tmp5 when r_sel1 = "00101" else
               data_out_tmp6 when r_sel1 = "00110" else
               data_out_tmp7 when r_sel1 = "00111" else
               data_out_tmp8 when r_sel1 = "01000" else
               data_out_tmp9 when r_sel1 = "01001" else
               data_out_tmp10 when r_sel1 = "01010" else
               data_out_tmp11 when r_sel1 = "01011" else
               data_out_tmp12 when r_sel1 = "01100" else
               data_out_tmp13 when r_sel1 = "01101" else
               data_out_tmp14 when r_sel1 = "01110" else
               data_out_tmp15 when r_sel1 = "01111" else
               data_out_tmp16 when r_sel1 = "10000" else
               data_out_tmp17 when r_sel1 = "10001" else
               data_out_tmp18 when r_sel1 = "10010" else
               data_out_tmp19 when r_sel1 = "10011" else
               data_out_tmp20 when r_sel1 = "10100" else
               data_out_tmp21 when r_sel1 = "10101" else
               data_out_tmp22 when r_sel1 = "10110" else
               data_out_tmp23 when r_sel1 = "10111" else
               data_out_tmp24 when r_sel1 = "11000" else
               data_out_tmp25 when r_sel1 = "11001" else
               data_out_tmp26 when r_sel1 = "11010" else
               data_out_tmp27 when r_sel1 = "11011" else
               data_out_tmp28 when r_sel1 = "11100" else
               data_out_tmp29 when r_sel1 = "11101" else
               data_out_tmp30 when r_sel1 = "11110" else
               data_out_tmp31;
  data_out2 <= data_out_tmp0 when r_sel2 = "00000" else
               data_out_tmp1 when r_sel2 = "00001" else
               data_out_tmp2 when r_sel2 = "00010" else
               data_out_tmp3 when r_sel2 = "00011" else
               data_out_tmp4 when r_sel2 = "00100" else
               data_out_tmp5 when r_sel2 = "00101" else
               data_out_tmp6 when r_sel2 = "00110" else
               data_out_tmp7 when r_sel2 = "00111" else
               data_out_tmp8 when r_sel2 = "01000" else
               data_out_tmp9 when r_sel2 = "01001" else
               data_out_tmp10 when r_sel2 = "01010" else
               data_out_tmp11 when r_sel2 = "01011" else
               data_out_tmp12 when r_sel2 = "01100" else
               data_out_tmp13 when r_sel2 = "01101" else
               data_out_tmp14 when r_sel2 = "01110" else
               data_out_tmp15 when r_sel2 = "01111" else
               data_out_tmp16 when r_sel2 = "10000" else
               data_out_tmp17 when r_sel2 = "10001" else
               data_out_tmp18 when r_sel2 = "10010" else
               data_out_tmp19 when r_sel2 = "10011" else
               data_out_tmp20 when r_sel2 = "10100" else
               data_out_tmp21 when r_sel2 = "10101" else
               data_out_tmp22 when r_sel2 = "10110" else
               data_out_tmp23 when r_sel2 = "10111" else
               data_out_tmp24 when r_sel2 = "11000" else
               data_out_tmp25 when r_sel2 = "11001" else
               data_out_tmp26 when r_sel2 = "11010" else
               data_out_tmp27 when r_sel2 = "11011" else
               data_out_tmp28 when r_sel2 = "11100" else
               data_out_tmp29 when r_sel2 = "11101" else
               data_out_tmp30 when r_sel2 = "11110" else
               data_out_tmp31;
  data_out3 <= data_out_tmp0 when r_sel3 = "00000" else
               data_out_tmp1 when r_sel3 = "00001" else
               data_out_tmp2 when r_sel3 = "00010" else
               data_out_tmp3 when r_sel3 = "00011" else
               data_out_tmp4 when r_sel3 = "00100" else
               data_out_tmp5 when r_sel3 = "00101" else
               data_out_tmp6 when r_sel3 = "00110" else
               data_out_tmp7 when r_sel3 = "00111" else
               data_out_tmp8 when r_sel3 = "01000" else
               data_out_tmp9 when r_sel3 = "01001" else
               data_out_tmp10 when r_sel3 = "01010" else
               data_out_tmp11 when r_sel3 = "01011" else
               data_out_tmp12 when r_sel3 = "01100" else
               data_out_tmp13 when r_sel3 = "01101" else
               data_out_tmp14 when r_sel3 = "01110" else
               data_out_tmp15 when r_sel3 = "01111" else
               data_out_tmp16 when r_sel3 = "10000" else
               data_out_tmp17 when r_sel3 = "10001" else
               data_out_tmp18 when r_sel3 = "10010" else
               data_out_tmp19 when r_sel3 = "10011" else
               data_out_tmp20 when r_sel3 = "10100" else
               data_out_tmp21 when r_sel3 = "10101" else
               data_out_tmp22 when r_sel3 = "10110" else
               data_out_tmp23 when r_sel3 = "10111" else
               data_out_tmp24 when r_sel3 = "11000" else
               data_out_tmp25 when r_sel3 = "11001" else
               data_out_tmp26 when r_sel3 = "11010" else
               data_out_tmp27 when r_sel3 = "11011" else
               data_out_tmp28 when r_sel3 = "11100" else
               data_out_tmp29 when r_sel3 = "11101" else
               data_out_tmp30 when r_sel3 = "11110" else
               data_out_tmp31;
end synthesis;

-----------------------------------------
-- Generated by ASIP Meister ver.2.3.4 --
-----------------------------------------
