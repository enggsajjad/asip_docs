-------------------------------------------------------------------------------
-- Title      : i2c interface toplevel
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_toplevel.vhd
-- Author     : <Administrator@CHRISTIAN>
-- Company    : 
-- Last update: 2006/05/31
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: the toplevel architecture containing all necessary components
-- for the i2c interface
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2006/04/04  0.01     kraemer Created
-- 2006/05/12  0.10     kraemer added arbiter, added generic
-- 2006/05/22  0.20     kraemer added multiclock latch
-- 2006/05/29  0.30     kraemer change to external frequency, added DCM and BUFG
-------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;
USE IEEE.std_logic_unsigned.ALL;

LIBRARY UNISIM;
USE UNISIM.vcomponents.ALL;

ENTITY i2c_toplevel IS

  GENERIC (
    devcount : positive := 4
    );

  PORT (
    -- clock signal for the IP core, independent from the clock signal of the
    -- devices connected to the IP core
    clock_ip : IN std_logic;
	 clock_ip_half : IN std_logic;
    -- data input / output and address input, rw-selector
    data_in       : IN  std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
    data_out      : OUT std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
    address       : IN  std_logic_vector ((7 * devcount) - 1 DOWNTO 0);
    rw            : IN  std_logic_vector (devcount - 1 DOWNTO 0);  -- rw = '0' = write
    bytes_to_read : IN  std_logic_vector ((8 * devcount) - 1 DOWNTO 0);

    -- fifo control signals: read and write enable signals, empty and full
    -- signals, acknowledge and valid signals 
    rd_en    : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    wr_en    : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    empty    : OUT std_logic_vector (devcount - 1 DOWNTO 0);
    full     : OUT std_logic_vector (devcount - 1 DOWNTO 0);
    wr_ack   : OUT std_logic_vector (devcount - 1 DOWNTO 0);
    rd_valid : OUT std_logic_vector (devcount - 1 DOWNTO 0);

    -- clock and reset signal, data valid signal
    clock      : IN std_logic_vector (devcount - 1 DOWNTO 0);
    reset      : IN std_logic_vector (devcount - 1 DOWNTO 0);
    data_valid : IN std_logic_vector (devcount - 1 DOWNTO 0);

    -- status information of the ip-core
    done : OUT std_logic_vector (devcount - 1 DOWNTO 0);  -- active low

    -- handshake signals / check which connected device requests access on bus
    request     : IN  std_logic_vector (devcount - 1 DOWNTO 0);
    acknowledge : OUT std_logic_vector (devcount - 1 DOWNTO 0);

    -- connections to the PCA9564, to be mapped to FPGA IO pins
    pca9564_data    : INOUT std_logic_vector (7 DOWNTO 0);  -- 8 bits to / from PCA9564
    pca9564_wr      : OUT   std_logic;  -- write strobe
    pca9564_rd      : OUT   std_logic;  -- read strobe
    pca9564_ce      : OUT   std_logic;  -- chip enable
    pca9564_address : OUT   std_logic_vector (1 DOWNTO 0);  -- select PCA9564
                                        -- register, format is A1A0
    pca9564_int     : IN    std_logic;  -- interrupt line from PCA9564
    pca9564_reset   : OUT   std_logic;   -- reset PCA9564

    -- connections to debug leds, to be mapped to FPGA IO pins
    debug_pca9564_registers  : OUT std_logic_vector (31 DOWNTO 0);  -- external debug LED connection
    debug_statemachine_state : OUT std_logic_vector (7 DOWNTO 0)  -- internal debug LED connection
    );

END i2c_toplevel;

ARCHITECTURE i2c_toplevel_arch OF i2c_toplevel IS
  -- signals to latch input signals, connect toplevel input and arbiter
  SIGNAL mport_done_i          : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL mport_acknowledge_i   : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL address_latched       : std_logic_vector ((7 * devcount) - 1 DOWNTO 0);
  SIGNAL rw_latched            : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL bytes_to_read_latched : std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
  SIGNAL data_valid_latched    : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL request_latched       : std_logic_vector (devcount - 1 DOWNTO 0);

  -- signals to connect arbiter and input fifo
  SIGNAL mport_data_in_i  : std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
  SIGNAL mport_rd_en_i    : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL mport_rd_valid_i : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL mport_empty_i    : std_logic_vector (devcount - 1 DOWNTO 0);

  -- signals to connect arbiter and output fifo
  SIGNAL mport_data_out_i : std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
  SIGNAL mport_wr_en_i    : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL mport_wr_ack_i   : std_logic_vector (devcount - 1 DOWNTO 0);
  SIGNAL mport_full_i     : std_logic_vector (devcount - 1 DOWNTO 0);

  -- signals to connect arbiter and the PCA9564 interface
  SIGNAL sport_data_in_i       : std_logic_vector (7 DOWNTO 0);
  SIGNAL sport_data_out_i      : std_logic_vector (7 DOWNTO 0);
  SIGNAL sport_address_i       : std_logic_vector (6 DOWNTO 0);
  SIGNAL sport_rw_i            : std_logic;
  SIGNAL sport_bytes_to_read_i : std_logic_vector (7 DOWNTO 0);
  SIGNAL sport_rd_en_i         : std_logic;
  SIGNAL sport_wr_en_i         : std_logic;
  SIGNAL sport_wr_ack_i        : std_logic;
  SIGNAL sport_rd_valid_i      : std_logic;
  SIGNAL sport_empty_i         : std_logic;
  SIGNAL sport_full_i          : std_logic;
  SIGNAL sport_reset_i         : std_logic;
  SIGNAL sport_data_valid_i    : std_logic;
  SIGNAL sport_done_i          : std_logic;

  -- signals for clock management
--  SIGNAL clock_ip_half : std_logic;
--  SIGNAL dcm_clk0_bufg : std_logic;
--  SIGNAL dcm_dv_bufg   : std_logic;
--  SIGNAL clock_fb      : std_logic;

  COMPONENT multiclock_latch
    PORT (
      clock_1             : IN  std_logic;
      clock_2             : IN  std_logic;
      i_cl1_address       : IN  std_logic_vector (6 DOWNTO 0);
      i_cl1_rw            : IN  std_logic;
      i_cl1_bytes_to_read : IN  std_logic_vector (7 DOWNTO 0);
      i_cl1_data_valid    : IN  std_logic;
      i_cl2_done          : IN  std_logic;
      i_cl1_request       : IN  std_logic;
      i_cl2_acknowledge   : IN  std_logic;
      o_address           : OUT std_logic_vector (6 DOWNTO 0);
      o_rw                : OUT std_logic;
      o_bytes_to_read     : OUT std_logic_vector (7 DOWNTO 0);
      o_data_valid        : OUT std_logic;
      o_done              : OUT std_logic;
      o_request           : OUT std_logic;
      o_acknowledge       : OUT std_logic);
  END COMPONENT;

  COMPONENT pca9564_interface
    PORT (
      fifo_data_in     : IN    std_logic_vector (7 DOWNTO 0);
      fifo_rd_ack      : IN    std_logic;
      fifo_rd_en       : OUT   std_logic;
      fifo_empty       : IN    std_logic;
      fifo_data_out    : OUT   std_logic_vector (7 DOWNTO 0);
      fifo_wr_ack      : IN    std_logic;
      fifo_wr_en       : OUT   std_logic;
      fifo_full        : IN    std_logic;
      clock            : IN    std_logic;
      reset            : IN    std_logic;
      device_address   : IN    std_logic_vector (6 DOWNTO 0);
      rw               : IN    std_logic;
      data_valid       : IN    std_logic;
      bytes_to_read    : IN    std_logic_vector (7 DOWNTO 0);
      done             : INOUT std_logic;
      pca9564_data     : INOUT std_logic_vector (7 DOWNTO 0);
      pca9564_wr       : OUT   std_logic;
      pca9564_rd       : OUT   std_logic;
      pca9564_ce       : OUT   std_logic;
      pca9564_address  : OUT   std_logic_vector (1 DOWNTO 0);
      pca9564_int      : IN    std_logic;
      pca9564_reset    : OUT   std_logic;
      debug_led_extern : OUT   std_logic_vector (31 DOWNTO 0);
      debug_led_intern : OUT   std_logic_vector (7 DOWNTO 0));
  END COMPONENT;

  COMPONENT i2c_arbiter
    GENERIC (
      devcount            :       positive);
    PORT (
      mport_data_in       : IN    std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
      mport_data_out      : OUT   std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
      mport_address       : IN    std_logic_vector ((7 * devcount) - 1 DOWNTO 0);
      mport_rw            : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_bytes_to_read : IN    std_logic_vector ((8 * devcount) - 1 DOWNTO 0);
      mport_rd_en         : OUT   std_logic_vector (devcount - 1 DOWNTO 0);
      mport_wr_en         : OUT   std_logic_vector (devcount - 1 DOWNTO 0);
      mport_wr_ack        : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_rd_valid      : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_empty         : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_full          : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_reset         : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_data_valid    : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      mport_done          : OUT   std_logic_vector (devcount - 1 DOWNTO 0);
      request             : IN    std_logic_vector (devcount - 1 DOWNTO 0);
      acknowledge         : OUT   std_logic_vector (devcount - 1 DOWNTO 0);
      clock_arbiter       : IN    std_logic;
      sport_data_in       : IN    std_logic_vector (7 DOWNTO 0);
      sport_data_out      : OUT   std_logic_vector (7 DOWNTO 0);
      sport_address       : OUT   std_logic_vector (6 DOWNTO 0);
      sport_rw            : OUT   std_logic;
      sport_bytes_to_read : OUT   std_logic_vector (7 DOWNTO 0);
      sport_rd_en         : IN    std_logic;
      sport_wr_en         : IN    std_logic;
      sport_wr_ack        : OUT   std_logic;
      sport_rd_valid      : OUT   std_logic;
      sport_empty         : OUT   std_logic;
      sport_full          : OUT   std_logic;
      sport_reset         : INOUT std_logic;
      sport_data_valid    : OUT   std_logic;
      sport_done          : IN    std_logic);
  END COMPONENT;

  COMPONENT fifo_generator_v2_1
    PORT (
      din    : IN  std_logic_vector(7 DOWNTO 0);
      rd_clk : IN  std_logic;
      rd_en  : IN  std_logic;
      rst    : IN  std_logic;
      wr_clk : IN  std_logic;
      wr_en  : IN  std_logic;
      dout   : OUT std_logic_vector(7 DOWNTO 0);
      empty  : OUT std_logic;
      full   : OUT std_logic;
      valid  : OUT std_logic;
      wr_ack : OUT std_logic);
  END COMPONENT;

----  COMPONENT BUFG
----    PORT (O : OUT std_ulogic;
----          I : IN  std_ulogic);
----  END COMPONENT;

-- FPGA Express Black Box declaration ATTRIBUTE fpga_dont_touch :
-- string; ATTRIBUTE fpga_dont_touch OF fifo_generator_v2_1 :
-- COMPONENT IS "true";

--  -- Synplicity black box declaration
--   ATTRIBUTE syn_black_box                        : boolean;
--   ATTRIBUTE syn_black_box OF fifo_generator_v2_1 : COMPONENT IS TRUE;

BEGIN  -- i2c_toplevel_arch

  input_fifo          : FOR k IN 1 TO devcount GENERATE
    input_fifo_asynch : fifo_generator_v2_1
      PORT MAP (
        din    => data_in ( ((k * 8) - 1) DOWNTO ((k * 8) - 8)),
        rd_clk => clock_ip_half,
        rd_en  => mport_rd_en_i (k - 1),
        rst    => reset (k - 1),        -- toplevel extern
        wr_clk => clock (k - 1),        -- toplevel extern
        wr_en  => wr_en (k - 1),        -- toplevel extern
        dout   => mport_data_in_i ( ((k * 8) - 1) DOWNTO ((k * 8) - 8)),
        empty  => mport_empty_i (k - 1),
        full   => full (k - 1),         -- toplevel extern
        valid  => mport_rd_valid_i (k - 1),
        wr_ack => wr_ack (k - 1)        -- toplevel extern
        );
  END GENERATE input_fifo;

  output_fifo          : FOR k IN 1 TO devcount GENERATE
    output_fifo_asynch : fifo_generator_v2_1
      PORT MAP (
        din    => mport_data_out_i ( ((k * 8) - 1) DOWNTO ((k * 8) - 8)),
        rd_clk => clock (k - 1),        -- toplevel extern
        rd_en  => rd_en (k - 1),        -- toplevel extern
        rst    => reset (k - 1),        -- toplevel extern
        wr_clk => clock_ip_half,
        wr_en  => mport_wr_en_i (k - 1),
        dout   => data_out ( ((k * 8) - 1) DOWNTO ((k * 8) - 8)),
        empty  => empty (k - 1),        -- toplevel extern
        full   => mport_full_i (k - 1),
        valid  => rd_valid (k - 1),     -- toplevel extern
        wr_ack => mport_wr_ack_i (k - 1));
  END GENERATE output_fifo;

  multiclock         : FOR k IN 1 TO devcount GENERATE
    clock_transition : multiclock_latch
      PORT MAP (
        clock_1             => clock (k - 1),  -- toplevel extern
        clock_2             => clock_ip_half,
        i_cl1_address       => address ( ((k * 7) - 1) DOWNTO ((k * 7) - 7)),  -- toplevel extern
        i_cl1_rw            => rw (k - 1),  -- toplevel extern
        i_cl1_bytes_to_read => bytes_to_read ( ((k * 8) - 1) DOWNTO ((k * 8) - 8)),  -- toplevel extern
        i_cl1_data_valid    => data_valid (k - 1),  -- toplevel extern
        i_cl2_done          => mport_done_i (k - 1),
        i_cl1_request       => request (k - 1),  -- toplevel extern
        i_cl2_acknowledge   => mport_acknowledge_i (k - 1),
        o_address           => address_latched ( ((k * 7) - 1) DOWNTO ((k * 7) - 7)),
        o_rw                => rw_latched (k - 1),
        o_bytes_to_read     => bytes_to_read_latched ( ((k * 8) - 1) DOWNTO ((k * 8) - 8)),
        o_data_valid        => data_valid_latched (k - 1),
        o_done              => done (k - 1),  -- toplevel extern
        o_request           => request_latched (k - 1),
        o_acknowledge       => acknowledge (k - 1));  -- toplevel extern
  END GENERATE multiclock;

  arbiter : i2c_arbiter
    GENERIC MAP (
      devcount            => devcount)
    PORT MAP (
      mport_data_in       => mport_data_in_i,
      mport_data_out      => mport_data_out_i,
      mport_address       => address_latched,
      mport_rw            => rw_latched,
      mport_bytes_to_read => bytes_to_read_latched,
      mport_rd_en         => mport_rd_en_i,
      mport_wr_en         => mport_wr_en_i,
      mport_wr_ack        => mport_wr_ack_i,
      mport_rd_valid      => mport_rd_valid_i,
      mport_empty         => mport_empty_i,
      mport_full          => mport_full_i,
      mport_reset         => reset,     -- toplevel extern
      mport_data_valid    => data_valid_latched,
      mport_done          => mport_done_i,
      request             => request_latched,
      acknowledge         => mport_acknowledge_i,
      clock_arbiter       => clock_ip_half,
      sport_data_in       => sport_data_in_i,
      sport_data_out      => sport_data_out_i,
      sport_address       => sport_address_i,
      sport_rw            => sport_rw_i,
      sport_bytes_to_read => sport_bytes_to_read_i,
      sport_rd_en         => sport_rd_en_i,
      sport_wr_en         => sport_wr_en_i,
      sport_wr_ack        => sport_wr_ack_i,
      sport_rd_valid      => sport_rd_valid_i,
      sport_empty         => sport_empty_i,
      sport_full          => sport_full_i,
      sport_reset         => sport_reset_i,
      sport_data_valid    => sport_data_valid_i,
      sport_done          => sport_done_i);

  pca9564 : pca9564_interface
    PORT MAP (
      fifo_data_in     => sport_data_out_i,
      fifo_rd_ack      => sport_rd_valid_i,
      fifo_rd_en       => sport_rd_en_i,
      fifo_empty       => sport_empty_i,
      fifo_data_out    => sport_data_in_i,
      fifo_wr_ack      => sport_wr_ack_i,
      fifo_wr_en       => sport_wr_en_i,
      fifo_full        => sport_full_i,
      clock            => clock_ip_half,
      reset            => sport_reset_i,
      device_address   => sport_address_i,
      rw               => sport_rw_i,
      data_valid       => sport_data_valid_i,
      bytes_to_read    => sport_bytes_to_read_i,
      done             => sport_done_i,
      pca9564_data     => pca9564_data,
      pca9564_wr       => pca9564_wr,
      pca9564_rd       => pca9564_rd,
      pca9564_ce       => pca9564_ce,
      pca9564_address  => pca9564_address,
      pca9564_int      => pca9564_int,
      pca9564_reset    => pca9564_reset,
      debug_led_extern => debug_pca9564_registers,
      debug_led_intern => debug_statemachine_state);

--  bufg_clock_ip : BUFG
--    PORT MAP (O => clock_ip_half,
--              I => dcm_dv_bufg);
--
--  bufg_clock : BUFG
--    PORT MAP (O => clock_fb,
--              I => dcm_clk0_bufg);
--
--  DCM_toplevel : DCM
--    -- The following generics are only necessary if you wish to change the default behavior.
--    GENERIC MAP (
--      CLKDV_DIVIDE          => 2.0,     -- Divide by: 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0, 5.5, 6.0, 6.5
--                                        -- 7.0, 7.5, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0 OR 16.0
--      CLKFX_DIVIDE          => 1,       -- Can be any integer from 1 to 32
--      CLKFX_MULTIPLY        => 4,       -- Can be any integer from 1 to 32
--      CLKIN_DIVIDE_BY_2     => FALSE,   -- TRUE/FALSE to enable CLKIN divide by two feature
--      CLKIN_PERIOD          => 0.0,     -- Specify period of input clock
--      CLKOUT_PHASE_SHIFT    => "NONE",  -- Specify phase shift of NONE, FIXED or VARIABLE
--      CLK_FEEDBACK          => "1X",    -- Specify clock feedback of NONE, 1X or 2X
--      DESKEW_ADJUST         => "SYSTEM_SYNCHRONOUS",  -- SOURCE_SYNCHRONOUS, SYSTEM_SYNCHRONOUS or an integer from 0 to 15
--      DFS_FREQUENCY_MODE    => "LOW",   -- HIGH or LOW frequency mode for frequency synthesis
--      DLL_FREQUENCY_MODE    => "LOW",   -- HIGH or LOW frequency mode for DLL
--      DUTY_CYCLE_CORRECTION => TRUE,    -- Duty cycle correction, TRUE or FALSE
--      FACTORY_JF            => X"C080",  -- FACTORY JF Values
--      PHASE_SHIFT           => 0,       -- Amount of fixed phase shift from -255 to 255
--      STARTUP_WAIT          => FALSE)   -- Delay configuration DONE until DCM LOCK, TRUE/FALSE
--    PORT MAP (
--      CLK0                  => dcm_clk0_bufg,  -- 0 degree DCM CLK ouptput
----       CLK180                => CLK180,  -- 180 degree DCM CLK output
----       CLK270                => CLK270,  -- 270 degree DCM CLK output
----       CLK2X                 => CLK2X,  -- 2X DCM CLK output
----       CLK2X180              => CLK2X180,  -- 2X, 180 degree DCM CLK out
----       CLK90                 => CLK90,  -- 90 degree DCM CLK output
--      CLKDV                 => dcm_dv_bufg,  -- Divided DCM CLK out (CLKDV_DIVIDE)
----       CLKFX                 => CLKFX,  -- DCM CLK synthesis out (M/D)
----       CLKFX180              => CLKFX180,  -- 180 degree CLK synthesis out
----       LOCKED                => LOCKED,  -- DCM LOCK status output
----       PSDONE                => PSDONE,  -- Dynamic phase adjust done output
----       STATUS                => STATUS,  -- 8-bit DCM status bits output
--      CLKFB                 => clock_fb,  -- DCM clock feedback
--      CLKIN                 => clock_ip  -- Clock input (from IBUFG, BUFG or DCM)
----       PSCLK                 => PSCLK,  -- Dynamic phase adjust clock input
----       PSEN                  => PSEN,  -- Dynamic phase adjust enable input
----       PSINCDEC              => PSINCDEC,  -- Dynamic phase adjust increment/decrement
----       RST                   => reset (0)  -- DCM asynchronous reset input
--      );
--  -- End of DCM_inst instantiation

END i2c_toplevel_arch;
