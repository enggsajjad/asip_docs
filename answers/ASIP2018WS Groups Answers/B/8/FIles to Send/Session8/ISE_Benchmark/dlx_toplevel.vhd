library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

library UNISIM;
use UNISIM.VComponents.all;

entity dlx_toplevel is
 port (  reset     : in  std_logic;
         clk_in    : in  std_logic;
			dummy_out : out std_logic
         );
 end dlx_toplevel;
  
 architecture Behavioral of dlx_toplevel is

 component BrownieSTD32
  port (
    CLK : in std_logic;
    RESET : in std_logic;
    IMEM_ADDR_OUT : out std_logic_vector(31 downto 0);
    IMEM_DATA_IN : in std_logic_vector(31 downto 0);
    IMEM_ADDRERR_IN : in std_logic;
    DMEM_ADDR_OUT : out std_logic_vector(31 downto 0);
    DMEM_DATA_IN : in std_logic_vector(31 downto 0);
    DMEM_DATA_OUT : out std_logic_vector(31 downto 0);
    DMEM_REQ_OUT : out std_logic;
    DMEM_ACK_IN : in std_logic;
    DMEM_RW_OUT : out std_logic;
    DMEM_WMODE_OUT : out std_logic_vector(1 downto 0);
    DMEM_EMODE_OUT : out std_logic;
    DMEM_ADDRERR_IN : in std_logic;
    DMEM_CANCEL_OUT : out std_logic;
    EXTINT_IN : in std_logic;
    EXTCATCH_OUT : out std_logic
  );
end component;

component brom_im
 port (
	clka : IN std_logic;
	addra: IN std_logic_VECTOR(13 DOWNTO 0);
	douta: OUT std_logic_VECTOR(31 DOWNTO 0));
end component;

component bram_dm
 port (
	clka: IN std_logic;
	dina: IN std_logic_VECTOR(31 downto 0);
	addra: IN std_logic_VECTOR(16 downto 0);
	wea: IN std_logic_VECTOR(0 downto 0);
	douta: OUT std_logic_VECTOR(31 downto 0));
end component;

  
  --CPU Signals
  signal instrdb : std_logic_vector(31 downto 0);
  signal instrab : std_logic_vector(31 downto 0);
  signal instrae : std_logic;
  signal dataab_cpu  : std_logic_vector(31 downto 0);
  signal datadbi_cpu  : std_logic_vector(31 downto 0);
  signal datadbo_cpu  : std_logic_vector(31 downto 0);
  signal datareq_cpu : std_logic;
  signal dataack_cpu : std_logic:='1';
  signal wmode_cpu  : std_logic_vector(1 downto 0);
  signal dataae_cpu : std_logic;
  signal cancel_cpu : std_logic;
  signal datarw_cpu : std_logic;
  signal emode_cpu : std_logic;
  signal extint : std_logic;
  signal extcatch : std_logic;
  
  --Memory Singals
  signal dataab_ram  : std_logic_vector(16 downto 0);
  signal we      : std_logic_VECTOR(0 downto 0);
  signal mem_in  : std_logic_vector(31 downto 0);
  signal mem_out : std_logic_vector(31 downto 0);
  signal datareq_mem_d1 : std_logic;
  signal datareq_mem_d2 : std_logic;
  signal mem_out1 : std_logic_vector(31 downto 0);
  
  -- Reset, Clocks and Swithes
  signal reset_cpu : std_logic := '0';
  
  signal clk :    std_logic;
  
  -- Starting the TOP Design here
  begin

	CPU0 : BrownieSTD32
     port map (
    CLK					=> clk,					-- in
    RESET				=> reset_cpu, 			-- in
    IMEM_ADDR_OUT		=>	instrab, 			-- out
    IMEM_DATA_IN		=> instrdb, 			-- in
    IMEM_ADDRERR_IN	=>	instrae, 			-- in
    DMEM_ADDR_OUT		=>	dataab_cpu, 		-- out
    DMEM_DATA_IN		=>	datadbi_cpu, 		-- in
    DMEM_DATA_OUT		=>	datadbo_cpu,  		-- out
    DMEM_REQ_OUT		=>	datareq_cpu, 		-- out
    DMEM_ACK_IN		=>	dataack_cpu, 		-- in
    DMEM_RW_OUT		=>	datarw_cpu, 		-- out
    DMEM_WMODE_OUT	=>	wmode_cpu, 			-- out
    DMEM_EMODE_OUT	=>	emode_cpu, 			-- out
    DMEM_ADDRERR_IN	=>	dataae_cpu, 		-- in
    DMEM_CANCEL_OUT	=>	cancel_cpu, 	   -- out
    EXTINT_IN			=>	extint, 				-- in
    EXTCATCH_OUT		=>	extcatch				-- out
    );


	BROM_instance : brom_im
	 port map (
	 addra 	=> instrab(15 downto 2),
	 clka  	=> (not clk),
	 douta    => instrdb
	 );
	
	BRAM_instance : bram_dm
	 port map (
		addra  => dataab_ram,
		clka   	=> clk,
		dina   	=> mem_in,
		douta    => mem_out,
		wea   	=> we
		);

	
  clk <= clk_in;
  -- Reset Logic
  reset_cpu <= reset;

  --External Interrupt Logic
  extint <= '0';
  
  --Instruction Memory Logic
  instrae <= '0'; 
 
  -- Data Memory Logic

  dataab_ram  <= dataab_cpu(18 downto 2); 
  
  we     <= "1" when (not(datarw_cpu = '0') and  datareq_cpu = '1' ) else "0"; 

  mem_out1 <= mem_out  when (datarw_cpu = '0' and datareq_mem_d2 = '1');--Sajjad OCT
  
  datareq_mem_d1 <= datareq_cpu when rising_edge(clk);
  datareq_mem_d2 <= datareq_mem_d1 when rising_edge(clk);
  dataack_cpu <= datareq_mem_d2 when rising_edge(clk);

  dataae_cpu <= '0';
  
 datadbi_cpu  <= mem_out1;

	mem_in <= datadbo_cpu;
   dummy_out <= instrab(0);
 
end Behavioral;