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
library IEEE;
use IEEE.STD_LOGIC_1164.all;

package MemoryMapperTypes is

  subtype MemoryMappedAddressType is std_logic_vector(31 downto 0);
  subtype MemoryMappedDataType is std_logic_vector(31 downto 0);

  type MemoryMappedAddressArrayType is array (natural range<>) of MemoryMappedAddressType;
  type MemoryMappedDataArrayType is array (natural range<>) of MemoryMappedDataType;

  -- Port specifications:
  -- ( is done in this package, because ModelSim doesn't allow me to declare numberOfPorts as generic
  --   and to use numberOfPorts in the same generic, what is needed to declare the AddressRanges (see below) )
  constant MemoryMappedNumberOfPorts : positive := 7;

  type MemoryMappedAddressRange is array (0 to 1) of natural;
  type MemoryMappedAddressRangeArray is array (natural range <>) of MemoryMappedAddressRange;
  -- The AddressRanges are an array of tuples (lowAddress, highAddress).
  constant MemoryMappedAddressRanges : MemoryMappedAddressRangeArray(0 to MemoryMappedNumberOfPorts-1)
    := ( (40000000, 40000000),          -- switch port
         (40000004, 40000011),          -- audio out (4:right chanel, 8:left chanel)
         (16777216, 16777216),          -- uart port: 0x100 0000
         (50331648, 50331648),          -- clock counter: 0x300 0000
         (33554432, 33554432),          -- putchar port: 0x200 0000
         (67108864, 71303164),          -- SRAM port1
         (83886080, 88080380));         -- SRAM port2,			  
		   
  -- If you have only one port you have to use the syntax ":= (0=>(from, to));".
  -- When you have two or more ports you can write ":= ( (100, 102), (200, 202), ... );"

end MemoryMapperTypes;


package body MemoryMapperTypes is
end MemoryMapperTypes;
