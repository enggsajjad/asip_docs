----------------------------------------------------------------------------------
-- Company: ITEC-Henkel (CES), University of Karlsruhe
-- Engineer: Lars Bauer
-- 
-- Create Date:    19:09:46 05/25/2006 
-- Design Name:    MemoryMapperTypes
-- Module Name:    MemoryMapperTypes
-- Project Name:   MemoryMapper
-- Target Devices: xc2v3000
-- Tool versions:  ISE 8.1
-- Description:    The number of Ports an the specific address ranges can be defined.
--
-- Dependencies:
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

PACKAGE dlxTypes IS
  CONSTANT DATA_AB_WIDTH : natural := 17; -- 16
  CONSTANT INST_AB_WIDTH : natural := 14;
  --CONSTANT INST_AB_WIDTH : natural := 16;
END dlxTypes;


PACKAGE BODY dlxTypes IS
END dlxTypes;
