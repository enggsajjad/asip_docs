-- Copyright (C) 2008 ASIP Solutions, Inc. All rights reserved. 
--
-- Testbench for BrownieSTD32
--


library STD, IEEE;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;
use WORK.all;
use MemoryMapperTypes.all;
use Helper.all;


---------------------------------------------------IR
entity InterruptGenerator is
  generic (
  period : integer := 200000 -- if system is driven by 20MHz, 0.1s
    );
  port (
    CLK       : in  std_logic;
    reset     : in  std_logic;
    timer_int : out std_logic;
    catch_int : in  std_logic);
end InterruptGenerator;

architecture InterruptGenerator of InterruptGenerator is
  signal timer_counter : std_logic_vector(31 downto 0);
  signal timer_int_tmp : std_logic;
  signal detection : std_logic;
  
begin  -- InterruptGenerator

  -- purpose: timer counter
  -- type   : sequential
  -- inputs : CLK, reset
  -- outputs: 
  timer : process (CLK, reset)
  begin  -- process timer
  if reset = '1' then -- asynchronous reset (active high)
      timer_counter <= X"00000000";
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      timer_counter <= timer_counter + 1;
    end if;
  end process timer;

  -- purpose: latch ext int signal
  -- type   : sequential
  -- inputs : CLK, reset
  -- outputs: 
  latch: process (CLK, reset)
  begin  -- process latch
  if reset = '1' then -- asynchronous reset (active low)
      timer_int_tmp <= '0';
    elsif CLK'event and CLK = '1' then  -- rising clock edge
      if(catch_int = '1') then
        timer_int_tmp <= '0';
      elsif(detection = '1') then
        timer_int_tmp <= '1';
      else
        timer_int_tmp <= timer_int_tmp;
      end if;
    end if;
  end process latch;
  
  detection <= '1' when timer_counter = conv_std_logic_vector(period, 32) else
               '0';

  timer_int <= timer_int_tmp;
  
end InterruptGenerator;
---------------------------------------------------IR End


library STD, IEEE;
use STD.textio.all;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_textio.all;
use WORK.all;
use MemoryMapperTypes.all;
use Helper.all;



--entity tb_BrownieSTD32 is
--end tb_BrownieSTD32;

entity TEST is
end TEST;


--architecture tb of tb_BrownieSTD32 is

architecture TestBench of TEST is

  component BrownieSTD32
    port (
      clk:	in std_logic;
      RESET:	in std_logic;
      IMEM_ADDR_OUT:	out std_logic_vector(31 downto 0);
      IMEM_DATA_IN:	in std_logic_vector(31 downto 0);
      IMEM_ADDRERR_IN:	in std_logic;
      DMEM_ADDR_OUT:	out std_logic_vector(31 downto 0);
      DMEM_DATA_IN:	in std_logic_vector(31 downto 0);
      DMEM_DATA_OUT:	out std_logic_vector(31 downto 0);
      DMEM_REQ_OUT:	out std_logic;
      DMEM_ACK_IN:	in std_logic;
      DMEM_RW_OUT:	out std_logic;
      DMEM_WMODE_OUT:	out std_logic_vector(1 downto 0);
      DMEM_EMODE_OUT:	out std_logic;
      DMEM_ADDRERR_IN:	in std_logic;
      DMEM_CANCEL_OUT:	out std_logic;
      EXTINT_IN:	in std_logic;
      EXTCATCH_OUT:	out std_logic
    );
  end component;
  
  
  component MemoryMapper
    port (
      -- The Signal-master, e.g. a CPU
      AB_master  : in    MemoryMappedAddressType;
      DB2master  : out MemoryMappedDataType;
      DB_master  : in MemoryMappedDataType;
  --    DataRMod_master  : in    std_logic_vector(2 downto 0);
  --    DataEMod_master : in    std_logic;
      RW_master : in    std_logic;
      Req_master : in    std_logic;
  --    DataCan_master : in   std_logic;
      Ack2master : out   std_logic;
  --    DataErr_master : out   std_logic;
  
  
      -- The Signal-Destination, e.g. a RAM
      DB2mem  : out MemoryMappedDataType;
      DB_mem  : in MemoryMappedDataType;
      Req2mem : out   std_logic;
      Ack_mem : in    std_logic;
  
      -- The Memory-Mapped Ports. Port i will get the connection, if
      -- AB_master is within addressRange[i].
      DB2ports  : out MemoryMappedDataArrayType(MemoryMappedNumberOfPorts-1 downto 0);
      DB_ports  : in MemoryMappedDataArrayType(MemoryMappedNumberOfPorts-1 downto 0);
      Req2ports : out   std_logic_vector(MemoryMappedNumberOfPorts-1 downto 0);
      Ack_ports : in    std_logic_vector(MemoryMappedNumberOfPorts-1 downto 0)
      );
  end component;
---------------------------------------------------IM

--  component tb_im_mifu
--    generic (
--      DATA_FILE_NAME: string := "TestData.IM";
--      FLUSH_DELAY: time := 10 ns
--    );
--    port (
--      CLK:	in std_logic;
--      address:	in std_logic_vector(31 downto 0);
--      data_out:	out std_logic_vector(31 downto 0);
--      addr_err:	out std_logic;
--      finish:	out std_logic
--    );
--  end component;
  
  
  
  
  
  
  ---------------------------------------------------DM
  --  component tb_dm_mifu
  --    generic (
  --      INIT_DATA_FILE_NAME: string := "TestData.DM";
  --      DUMP_DATA_FILE_NAME: string := "TestData.OUT"
  --    );
  --    port (
  --      CLK:	in std_logic;
  --      address:	in std_logic_vector(31 downto 0);
  --      data_out:	out std_logic_vector(31 downto 0);
  --      data_in:	in std_logic_vector(31 downto 0);
  --      req:	in std_logic;
  --      ack:	out std_logic;
  --      write_enb:	in std_logic;
  --      access_mode:	in std_logic_vector(1 downto 0);
  --      sign_ext:	in std_logic;
  --      addr_err:	out std_logic;
  --      cancel:	in std_logic;
  --      finish:	in std_logic
  --    );
  --  end component;
  
  ---------------------------------------------------IR
  
  component InterruptGenerator
    generic (
      period : integer := 200
    );
    port (
      CLK       : in  std_logic;
      reset     : in  std_logic;
      timer_int : out std_logic;
      catch_int : in  std_logic
    );
  end component;
  -- Debugging Output
  constant PrintMemAccess      : bit := '0';
  constant PrintThousandCycles : bit := '1';

  constant IM_SIZE             : integer                      := 65536;   -- size in 32-bit Word
  constant DM_SIZE             : integer                      := 262144;  -- size in 32-bit Word
  constant READ                : std_logic                    := '0';  -- read mode from CPU
  
  constant CLK_PERIOD           : time := 10 ns;
  constant RESET_OFFSET         : time := CLK_PERIOD / 10;
  constant FLUSH_DELAY          : time  := CLK_PERIOD * 8;
  
  signal clk:	std_logic;
  signal RESET:	std_logic;
  signal IMEM_ADDR_OUT:	std_logic_vector(31 downto 0);
  signal IMEM_DATA_IN:	std_logic_vector(31 downto 0);
  signal IMEM_ADDRERR_IN:	std_logic;
  signal DMEM_ADDR_OUT:	std_logic_vector(31 downto 0);
  signal DMEM_DATA_IN:	std_logic_vector(31 downto 0);
  signal DMEM_DATA_OUT:	std_logic_vector(31 downto 0);
  signal DMEM_REQ_OUT:	std_logic;
  signal DMEM_ACK_IN:	std_logic;
  signal DMEM_RW_OUT:	std_logic;
  signal DMEM_WMODE_OUT:	std_logic_vector(1 downto 0);
  signal DMEM_EMODE_OUT:	std_logic;
  signal DMEM_ADDRERR_IN:	std_logic;
  signal DMEM_CANCEL_OUT:	std_logic;
  signal EXTINT_IN:	std_logic;
  signal EXTCATCH_OUT:	std_logic;
  signal tb_finish:	std_logic;
  signal ig_reset:      std_logic;

  signal ack_out: std_logic;


-- MemoryMapper Signals
signal DB2mem       : std_logic_vector(31 downto 0);
signal DB_mem       : std_logic_vector(31 downto 0);
signal Req2mem      : std_logic;
signal Ack_mem      : std_logic;
signal DB2ports     : MemoryMappedDataArrayType(MemoryMappedNumberOfPorts-1 downto 0);
signal DB_ports     : MemoryMappedDataArrayType(MemoryMappedNumberOfPorts-1 downto 0);
signal Req2ports    : std_logic_vector(MemoryMappedNumberOfPorts-1 downto 0);
signal Ack_ports    : std_logic_vector(MemoryMappedNumberOfPorts-1 downto 0);
signal port0_req_d      : std_logic;
signal port1_req_d      : std_logic;
signal port2_req_d      : std_logic;
signal port2_req_d2      : std_logic:='0';
signal port3_counter    : MemoryMappedDataType;
signal port3_req_d      : std_logic;
signal port4_req_d      : std_logic;
signal DM_dataout : std_logic_vector(31 downto 0);
signal DM_datain  : std_logic_vector(31 downto 0);

  subtype Atype is std_logic_vector(31 downto 0);  -- Address Type  
  subtype Dtype is std_logic_vector(31 downto 0);
  subtype Dtype_Byte is std_logic_vector(7 downto 0);
  type IMEMtype is array (0 to 16383) of Dtype;
  --type DMEMtype is array (0 to 16383) of Dtype;
  type DMEMtype is array (0 to 262143) of Dtype;--sajjad
  type IMtype is array (0 to IM_SIZE-1) of Dtype;  -- Instruction Memory
  type DMtype is array (0 to DM_SIZE-1) of Dtype;  -- Data Memory
  type DMtypeB is array (0 to 4*DM_SIZE-1) of Dtype_Byte;  -- Data Memory Byte

  signal finish         : std_logic := '0';
  signal EndOfInputData : std_logic;
  signal clock_counter  : integer   := -1;  -- starting with -1 to overcome the lost cycle at the beginning

  file IMin       : text open read_mode is "TestData.IM";
  file DMin     : text open read_mode is "TestData.DM";
  file Tout     : text open write_mode is "TestData.OUT";
   file LCD_outfile   : text open write_mode is "lcd.out";
  file UART_outfile  : text open write_mode is "uart.out";
  file Audio_outfile : text open write_mode is "audio.out";
  file trace_outfile : text open write_mode is "modelsim_trace.out";  -- for creating an IM trace

  
  
  
begin  -- Architecture Body

  DUT: BrownieSTD32 
  port map (
      clk	 => clk,
      RESET	 => RESET,
      IMEM_ADDR_OUT	 => IMEM_ADDR_OUT,
      IMEM_DATA_IN	 => IMEM_DATA_IN,
      IMEM_ADDRERR_IN	 => IMEM_ADDRERR_IN,
      DMEM_ADDR_OUT	 => DMEM_ADDR_OUT,
      DMEM_DATA_IN	 => DMEM_DATA_IN,
      DMEM_DATA_OUT	 => DMEM_DATA_OUT,
      DMEM_REQ_OUT	 => DMEM_REQ_OUT,
      DMEM_ACK_IN	 => DMEM_ACK_IN,
      DMEM_RW_OUT	 => DMEM_RW_OUT,
      DMEM_WMODE_OUT	 => DMEM_WMODE_OUT,
      DMEM_EMODE_OUT	 => DMEM_EMODE_OUT,
      DMEM_ADDRERR_IN	 => DMEM_ADDRERR_IN,
      DMEM_CANCEL_OUT	 => DMEM_CANCEL_OUT,
      EXTINT_IN	 => EXTINT_IN,
      EXTCATCH_OUT	 => EXTCATCH_OUT
  );
  

  
  i_memorymapper : MemoryMapper
    port map (
      -- CPU
      AB_master  => DMEM_ADDR_OUT,
--      DB2master  => DMEM_DATA_OUT,
--      DB_master  => DMEM_DATA_IN,
      DB_master  => DMEM_DATA_OUT,
      DB2master  => DMEM_DATA_IN,
      Req_master => DMEM_REQ_OUT,
      Ack2master => DMEM_ACK_IN,
      RW_master  => DMEM_RW_OUT,
      -- bram_dm
      DB2mem     => DB2mem,
      DB_mem     => DB_mem,
      Req2mem    => Req2mem,
      Ack_mem    => Ack_mem,
      -- ports
      DB2ports   => DB2ports,
      DB_ports   => DB_ports,
      Req2ports  => Req2ports,
      Ack_ports  => Ack_ports
      );
  
  
  -- ------------------------------------------------------------------------
  -- Instruction Memory
  --
--  IMEM: tb_im_mifu
--    generic map (FLUSH_DELAY => CLK_PERIOD * 8)
--    port map (
--      CLK	 => clk,
--      address	 => IMEM_ADDR_OUT,
--      data_out	 => IMEM_DATA_IN,
--      addr_err	 => IMEM_ADDRERR_IN,
--      finish	 => tb_finish
--    );

  IMem: process
    variable addr : std_logic_vector(31 downto 0);
    variable mapped_intr_addr : std_logic_vector(31 downto 0);
    variable datum : std_logic_vector(7 downto 0);
    variable data : Dtype;
    variable lbuf : line;
    variable IM   : IMEMtype;

    variable base_addr : integer;
    variable offset : integer;
  begin
    for A in IM'range loop
      IM(A) := (others => '0');
    end loop;
    
    while (not(endfile(IMin))) loop
      for i in 0 to 4 - 1 loop
        readline(IMin, lbuf);
        hread(lbuf, addr); -- 1st column in file is address
        hread(lbuf, datum); -- 2nd column in file is data
        data(32 - 8 * i - 1 downto 32 - 8 * (i + 1)) := datum;
      end loop;
      
--      if(X"00000000" <= addr and addr <= X"0000EFFF") then 
--        IM(conv_integer(addr(31 downto 2))) := data;
--      elsif(X"0FFE0000" <= addr and addr <= X"0FFE0FFF") then 
--        mapped_intr_addr := (X"0000F" & addr(11 downto 0)); -- contatenate to F000 - FFFF
--        IM(conv_integer(mapped_intr_addr(31 downto 2))) := data;
--      else
--        assert false;
--      end if;
      -- Sajjad
      IM(conv_integer(addr(31 downto 2))) := data;
          -- byte address to word address
    end loop;

    IMEM_ADDRERR_IN <= '0';
    tb_finish <= '0';
    loop
      wait until IMEM_ADDR_OUT'event;
              if IMEM_ADDR_OUT > addr then
                wait for FLUSH_DELAY;
                tb_finish <= '1';
                wait;
              end if;
              
--              base_addr := conv_integer(address(31 downto 2));
              
--              if(X"00000000" <= IMEM_ADDR_OUT and IMEM_ADDR_OUT <= X"0000EFFF") then 
--                base_addr := conv_integer(IMEM_ADDR_OUT(31 downto 2));
--              elsif(X"0FFE0000" <= addr and addr <= X"0FFE0FFF") then 
--                base_addr := conv_integer((X"0000F" & IMEM_ADDR_OUT(11 downto 2)));
--              else
--                assert false;
--              end if;
              -- Sajjad
              base_addr := conv_integer(IMEM_ADDR_OUT(31 downto 2));
              
              offset := conv_integer(IMEM_ADDR_OUT(2 - 1 downto 0));
              data := IM(base_addr);

              if conv_integer(IMEM_ADDR_OUT(2 - 1 downto 0)) >= 4 then
                IMEM_ADDRERR_IN <= '1';
                IMEM_DATA_IN <= (others => 'X');
              else
                IMEM_ADDRERR_IN <= '0';
                  for i in 4 - 1 downto 0 loop
                      IMEM_DATA_IN((i + 1) * 8 - 1 downto i * 8) <= data((i + 1 + offset) * 8 - 1 downto (i + offset) * 8);
                  end loop;
              end if;
    end loop;
  end process IMem;
  ---------------------------------------------------End IM
  
  
    -- --------------------------------------------------------------------------
    -- Data Memory
    
--  DMEM: tb_dm_mifu port map (
--      CLK	 => clk,
--      address	 => DMEM_ADDR_OUT,
--      data_out	 => DMEM_DATA_IN,
--      data_in	 => DMEM_DATA_OUT,
--      req	 => DMEM_REQ_OUT,
--      ack	 => DMEM_ACK_IN,
--      write_enb	 => DMEM_RW_OUT,
--      access_mode	 => DMEM_WMODE_OUT,
--      sign_ext	 => DMEM_EMODE_OUT,
--      addr_err	 => DMEM_ADDRERR_IN,
--      cancel	 => DMEM_CANCEL_OUT,
--      finish	 => tb_finish
--  );



--DM_datain  <= DataDB_mem;
--DataDB_mem <= DM_dataout when (DataWMode = "1111") else (others => 'Z');
--DM_datain  <= DB2mem;
--DB_mem <= DM_dataout when (DMEM_RW_OUT = '0') else (others => 'Z');
  

  Ack_mem <= ack_out and not Req2mem;

DMem : process
  variable addr : std_logic_vector(31 downto 0);
  variable datum : std_logic_vector(7 downto 0);
  variable data : Dtype;
  variable data_tmp : Dtype;
  variable access_mode_num : integer;
  variable lbuf : line;
  variable DM : DMEMType;
  variable Tbuf : line;
  
  variable base_addr : integer;
  variable offset : integer;
  
  variable printWriteAccess   : bit := '0';
  
  type state is (st0, st1, st2, st2a, st2b);
  variable dm_s : state := st0;

begin
  for A in DM'range loop
    DM(A) := (others => '0');
  end loop;
  
  addr := (others => '0');
  
  while (not(endfile(DMin))) loop
    for i in 0 to 4 - 1 loop
      if(endfile(DMin)) then
        exit;
      end if;
      readline(DMin, lbuf);
      hread(lbuf, addr); -- 1st column in file is address
      hread(lbuf, datum); -- 2nd column in file is data
      data(32 - 8 * i - 1 downto 32 - 8 * (i + 1)) := datum;
    end loop;
    --DM(conv_integer(addr(15 downto 2))) := data;
    DM(conv_integer(addr(19 downto 2))) := data;
        -- byte address to word address
  end loop;

  DMEM_ADDRERR_IN <= '0';
  ack_out <= '0';
  loop
    wait on clk, tb_finish;
    if clk'event and clk = '1' then
      case dm_s is
        when st0 =>
          ack_out <= not Req2mem;
          if Req2mem = '1' then
            dm_s := st1;
          end if;

        when st1 =>
          if DMEM_CANCEL_OUT = '1' then
            dm_s := st0;
          elsif Req2mem = '0' then
            ack_out <= '0';

--            base_addr := conv_integer(DMEM_ADDR_OUT(15 downto 2));
            base_addr := conv_integer(DMEM_ADDR_OUT(19 downto 2));
            --base_addr := conv_integer(DMEM_ADDR_OUT(31 downto 2));--Sajjad 15
            offset := conv_integer(DMEM_ADDR_OUT(2 - 1 downto 0));
            data := DM(base_addr);
            access_mode_num := conv_integer(DMEM_WMODE_OUT);

            if(DMEM_WMODE_OUT = "00") then 
                data_tmp(31 downto 24) := data(7 downto 0);
                data_tmp(23 downto 16) := data(15 downto 8);
                data_tmp(15 downto 8) := data(23 downto 16);
                data_tmp(7 downto 0) := data(31 downto 24);
            elsif(DMEM_WMODE_OUT = "01") then
                data_tmp(31 downto 16) := data(15 downto 0);
                data_tmp(15 downto 0) := data(31 downto 16);
            elsif(DMEM_WMODE_OUT = "10") then                   -- because it is not used by browstd32, not implemented correctly
                data_tmp := data;
            elsif(DMEM_WMODE_OUT = "11") then
                data_tmp := data;
            end if;


            if conv_integer(DMEM_WMODE_OUT) + conv_integer(DMEM_ADDR_OUT(2 - 1 downto 0)) >= 4 then -- if mismatch in address accessed
              DMEM_ADDRERR_IN <= '1';
              DB_mem <= (others => 'X');
            else -- valid address
              DMEM_ADDRERR_IN <= '0';
              if DMEM_RW_OUT = '0' then 
              -------- read --------------
                for i in 4 - 1 downto 0 loop
                  if i > DMEM_WMODE_OUT then
                    DB_mem((i + 1) * 8 - 1 downto i * 8) <= (others => DMEM_EMODE_OUT and data_tmp(7 + offset * 8));                    
                  else
                    DB_mem((i + 1) * 8 - 1 downto i * 8) <= data_tmp((i + 1 + offset) * 8 - 1 downto (i + offset) * 8);
                  end if;
                end loop;

              else 
              -------- write --------------
                DB_mem <= DB2mem;
                for i in 4 - 1 downto 0 loop
                  if i <= DMEM_WMODE_OUT then
                    data((i + 1 + (3-access_mode_num) - offset) * 8 - 1 downto (i + (3-access_mode_num) - offset) * 8)
                        := DB2mem((i + 1) * 8 - 1 downto i * 8);
                      
                  end if;
                end loop;

                DM(base_addr) := data;
              end if;
             -------- write --------------
            end if;

            dm_s := st2a;
          end if;
        when st2a =>
            dm_s := st2b;
        when st2b =>
                dm_s := st2;
       when st2 =>
          ack_out <= '1';
          if Req2mem = '0' then
            dm_s := st0;
          else
            dm_s := st1;
          end if;
      end case;
    end if;

    if tb_finish'event and tb_finish = '1' then

 
      for A in DM'range loop
--          if addr <= 0 or A * 4 <= addr then
          data := DM(A);
--            for i in 0 to 4 - 1 loop
            hwrite(Tbuf, conv_std_logic_vector(A * 4, 32), RIGHT, 8);
            hwrite(Tbuf, data, RIGHT, 9);
            writeline(Tout, Tbuf);
--            end loop;
--          end if;
      end loop;

wait for 2*CLK_PERIOD;
write(Tbuf, string'("          ----------------------------------------------------------------------------------------------------------------------------------------------------------------"));
writeline (Output, Tbuf);
write(Tbuf, string'("***** ") );
write(Tbuf, clock_counter-2, right, 6);  -- "-2" cause the two "wait for clk_period" for the HLT-command.
write(Tbuf, string'(" ClockCycles altogether simulated *****") );
writeline(Output, Tbuf);
write(Tbuf, string'("          ----------------------------------------------------------------------------------------------------------------------------------------------------------------"));
writeline (Output, Tbuf);
assert false report "SUCCESSFUL: Simulation End." severity failure; 

    end if;
  end loop;
end process DMem;

---------------------------------------------------End DM


  -- ------------------------------------------------------------------------
  -- Port 0: Switch Port
  DB_ports(0)  <= (others => 'Z');
  Ack_ports(0) <= '0'              when reset = '1' else port0_req_d;
  port0_req_d      <= Req2ports(0) when rising_edge(clk);


  -- ------------------------------------------------------------------------
  -- Port 1: AudioOut
  DB_ports(1)  <= (others => 'Z');
  Ack_ports(1) <= '0'              when reset = '1' else port1_req_d;
  port1_req_d      <= Req2ports(1) when rising_edge(clk);

  writeAudioOut : process (reset, clk)
    variable lineBuf  : line;
  begin
--    if rising_edge(clk) and Req2ports(1) = '1' and not DataWMode = READ then
    if rising_edge(clk) and Req2ports(1) = '1' and not DMEM_RW_OUT = READ then
--      if DataAB32(3 downto 2) = "01" then
      if DMEM_ADDR_OUT(3 downto 2) = "01" then
        write(lineBuf, string'("L: ") );
--      elsif DataAB32(3 downto 2) = "10" then
      elsif DMEM_ADDR_OUT(3 downto 2) = "10" then
        write(lineBuf, string'("R: ") );
      else
        write(lineBuf, string'("?: ") );
      end if;
      write(lineBuf, conv_integer(DB2ports(1)(15 downto 0)) );
      write(lineBuf, string'(", ") );
      writeline(audio_outfile, lineBuf);
      
      port2_req_d2 <= not port2_req_d2;
    end if;
  end process;


  -- ------------------------------------------------------------------------
  -- Port 2: UART output
  DB_ports(2)  <= (others => 'Z');
  Ack_ports(2) <= '0'              when reset = '1' else port2_req_d;
  port2_req_d      <= Req2ports(2) when rising_edge(clk) else
                   '1' when reset = '1' ;

  uartout             : process (reset, clk)
    variable lineBuf  : line;
    variable dataTemp : integer;

  begin
--    if rising_edge(clk) and Req2ports(2) = '1' and not DataWMode = READ then 
   if rising_edge(clk) and Req2ports(2) = '1' and not DMEM_RW_OUT = READ then 
      dataTemp := conv_integer(DB2ports(2));
      if dataTemp = 10 then           -- Line Feed
      elsif dataTemp = 9 then         -- Tabulator
        write(lineBuf, HT);
      elsif dataTemp = 13 then        -- Carriage Return
        writeline(uart_outfile, lineBuf);
      else
        write(lineBuf, int2char(dataTemp) );
      end if;
    end if;
  end process;


  -- ------------------------------------------------------------------------
  -- Port 3: Clock Counter
  --datadb_ports(3) <= port3_counter    when DataWMode = READ and port3_req_d = '1' else (others => 'Z');
  DB_ports(3) <= port3_counter    when DMEM_RW_OUT = READ and port3_req_d = '1' else (others => 'Z');
  
  port3_req_d     <= Req2ports(3) when rising_edge(clk);
  Ack_ports(3) <= port3_req_d after 1 ns;  -- Note: the 'after 1 ns' statement is a workarround that assures
                                               -- that the code works with simulation and on FPGA. For any reason
                                               -- the simulation seems to take the data from the bus whenever the ack has
                                               -- a rising edge, that's why we delay it by 1 ns (not required for FPGA).
  
  port3counter       : process (reset, clk)
  begin
    if rising_edge(clk) then
      if reset = '1' then
        port3_counter      <= (others => '0');
      else
        if Req2ports(3) = '1' then
--          if DataWMode /= READ then 
          if DMEM_RW_OUT /= READ then
            port3_counter <= DB2ports(3);
          end if;
        end if;

        -- Count up, if there was no write-request
--        if Req2ports(3) = '0' or DataWMode = READ then DMEM_RW_OUT
          if (Req2ports(3) = '0' or DMEM_RW_OUT = READ) then
            port3_counter <= conv_std_logic_vector(conv_integer(port3_counter)+1, 32);
        end if;

      end if;
    end if;
  end process;


  -- ------------------------------------------------------------------------
  -- Port 4: LCD output
  DB_ports(4)  <= (others => 'Z');
  Ack_ports(4) <= '0'              when reset = '1' else port4_req_d;
  port4_req_d      <= Req2ports(4) when rising_edge(clk);

  lcdout              : process (reset, clk)
    variable lineBuf  : line;
    variable dataTemp : integer;
  begin
--    if rising_edge(clk) and Req2ports(4) = '1' and not DataWMode = READ then DMEM_RW_OUT
    if rising_edge(clk) and Req2ports(4) = '1' and not DMEM_RW_OUT = READ then
      dataTemp := conv_integer(DB2ports(4));
      if dataTemp = 10 then           -- Line Feed
      elsif dataTemp = 9 then         -- Tabulator
        write(lineBuf, HT);
      elsif dataTemp = 13 then        -- Carriage Return
        writeline(lcd_outfile, lineBuf);
      else
        write(lineBuf, int2char(dataTemp) );
      end if;
    end if;
  end process;


  -- ------------------------------------------------------------------------
  -- Port 5: SRAM 1
  DB_ports(5)  <= (others => 'Z');
  Ack_ports(5) <= '0';


  -- ------------------------------------------------------------------------
  -- Port 6: SRAM 2
  DB_ports(6)  <= (others => 'Z');
  Ack_ports(6) <= '0';


  -- ------------------------------------------------------------------------
  
  
  -- Clock Signal
  --  clk_proc                  : process
  --    variable lineBuf        : line;
  --    variable clockThousands : integer := 0;
  --  begin
  --    CLK             <= '0';
  --    wait for CLK_HALF_PERIOD;
  --    CLK             <= '1';
  --    if RESET = '0' then
  --      clock_counter <= clock_counter + 1;
  --    end if;
  --    if (PrintThousandCycles = '1' and clock_counter+1 >= 1000*clockThousands ) then
  --      clockThousands                  := clockThousands + 1;
  --      write(lineBuf, string'("***** ") );
  --      write(lineBuf, clock_counter+1, right, 6);
  --      write(lineBuf, string'(" ClockCycles simulated *****") );
  --      writeline(Output, lineBuf);
  --    end if;
  --    wait for CLK_HALF_PERIOD;
  --  end process;

--  process
--  begin
--    clk <= '1';
--    wait for CLK_PERIOD/2;
--    clk <= '0';
--    wait for CLK_PERIOD/2;
--  end process;

-------------------------------
clk_proc                  : process
  variable lineBuf        : line;
  variable clockThousands : integer := 0;
begin
  clk             <= '0';
  wait for CLK_PERIOD/2;
  clk             <= '1';
  if RESET = '0' then
    clock_counter <= clock_counter + 1;
  end if;
  if (PrintThousandCycles = '1' and clock_counter+1 >= 1000*clockThousands ) then
    clockThousands                  := clockThousands + 1;
    write(lineBuf, string'("***** ") );
    write(lineBuf, clock_counter+1, right, 6);
    write(lineBuf, string'(" ClockCycles simulated *****") );
    writeline(Output, lineBuf);
  end if;
  wait for CLK_PERIOD/2;
end process;

---------------------
  -- Reset Signal
  --
  --  reset_proc : process
  --  begin
  --    RESET <= '1';
  --    wait for SETUP_TIME + 2*CLK_HALF_PERIOD;
  --    wait until CLK = '0' and CLK'event;
  --    RESET <= '0';
  --    wait;
  --  end process;
  
  RESET <= '1',
           '0' after CLK_PERIOD + RESET_OFFSET;

  -- External Interrupt
  ig_reset <= RESET or EXTCATCH_OUT;

  EXTINT_IN <= '0';

  TIMER : InterruptGenerator port map (
    CLK   => clk,
    reset => ig_reset,
    timer_int => open,
    catch_int => EXTCATCH_OUT);
  
end TestBench;

configuration CFG of TEST is
  for TestBench
  end for;
end;

-----------------------------------
-----------------------------------

