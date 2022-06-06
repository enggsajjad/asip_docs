-------------------------------------------------------------------------------
-- Title      : multiclock latch for I2C interface
-- Project    : 
-------------------------------------------------------------------------------
-- File       : i2c_multiclock_latch.vhd
-- Author     :   <kraemer@I80PC03>
-- Company    : 
-- Last update: 2006/05/30
-- Platform   : 
-------------------------------------------------------------------------------
-- Description: latches all signals traversing the clock boundary
-------------------------------------------------------------------------------
-- Revisions  :
-- Date        Version  Author  Description
-- 2006/05/22  0.01     kraemer Created
-------------------------------------------------------------------------------

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

USE IEEE.std_logic_unsigned.ALL;

ENTITY multiclock_latch IS

  PORT (
    clock_1 : IN std_logic;
    clock_2 : IN std_logic;

    i_cl1_address       : IN std_logic_vector (6 DOWNTO 0);
    i_cl1_rw            : IN std_logic;
    i_cl1_bytes_to_read : IN std_logic_vector (7 DOWNTO 0);
    i_cl1_data_valid    : IN std_logic;
    i_cl2_done          : IN std_logic;
    i_cl1_request       : IN std_logic;
    i_cl2_acknowledge   : IN std_logic;

    o_address       : OUT std_logic_vector (6 DOWNTO 0);
    o_rw            : OUT std_logic;
    o_bytes_to_read : OUT std_logic_vector (7 DOWNTO 0);
    o_data_valid    : OUT std_logic;
    o_done          : OUT std_logic;
    o_request       : OUT std_logic;
    o_acknowledge   : OUT std_logic
    );

END multiclock_latch;

ARCHITECTURE multiclock_latch_arch OF multiclock_latch IS
  SIGNAL address_i       : std_logic_vector (6 DOWNTO 0);
  SIGNAL rw_i            : std_logic;
  SIGNAL bytes_to_read_i : std_logic_vector (7 DOWNTO 0);
  SIGNAL data_valid_i    : std_logic;
  SIGNAL done_i          : std_logic;
  SIGNAL request_i       : std_logic;
  SIGNAL acknowledge_i  : std_logic;
BEGIN  -- multiclock_latch_arch

  -- purpose: latches the input signals on positive clock edge
  -- type   : combinational
  -- inputs : clock_1
  -- outputs: output
  latch_clock_1 : PROCESS (clock_1)
  BEGIN  -- PROCESS latch
    IF clock_1'EVENT AND clock_1 = '1' THEN
      -- store the data from clock-domain clock_1
      address_i       <= i_cl1_address;
      rw_i            <= i_cl1_rw;
      bytes_to_read_i <= i_cl1_bytes_to_read;
      data_valid_i    <= i_cl1_data_valid;
      request_i       <= i_cl1_request;

      -- write sampled data from clock-domain clock_1
      o_done        <= done_i;
      o_acknowledge <= acknowledge_i;
    END IF;
  END PROCESS latch_clock_1;

  -- purpose: latches the input signals on positive clock edge
  -- type   : combinational
  -- inputs : clock_2
  -- outputs: output
  latch_clock_2 : PROCESS (clock_2)
  BEGIN  -- PROCESS latch
    IF clock_2'EVENT AND clock_2 = '1' THEN
      -- store the data from clock-domain clock_2
      done_i        <= i_cl2_done;
      acknowledge_i <= i_cl2_acknowledge;

      -- write sampled data from clock-domain clock_1
      o_address       <= address_i;
      o_rw            <= rw_i;
      o_bytes_to_read <= bytes_to_read_i;
      o_data_valid    <= data_valid_i;
      o_request       <= request_i;      
    END IF;
  END PROCESS latch_clock_2;

END multiclock_latch_arch;
