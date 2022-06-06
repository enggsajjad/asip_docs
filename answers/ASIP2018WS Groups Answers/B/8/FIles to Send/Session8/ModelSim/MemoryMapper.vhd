----------------------------------------------------------------------------------
-- Company: ITEC-Henkel (CES), University of Karlsruhe
-- Engineer: Lars Bauer
-- 
-- Create Date:    19:09:46 05/25/2006 
-- Design Name:    MemoryMapper
-- Module Name:    MemoryMapper
-- Project Name:   MemoryMapper
-- Target Devices: xc2v3000
-- Tool versions:  ISE 8.1
-- Description:    The MemoryMapper is meant to be inserted between a master (e.g. CPU) and
--                 memory. The MemoryMapper offers additional ports with a corresponding address range.
--                 Whenever there is an access to an address within the address range of one of
--                 the ports, the access is forwarded to the specific port instead of the memory.
--
-- Dependencies:   MemoryMapperTypes.vhd  Here the number of Ports an the address ranges can be defined
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use work.all;                           -- is anyhow needed to 'use' the below MemoryMapperTypes in ModelSim
use MemoryMapperTypes.all;

entity MemoryMapper is
  port (
    -- The Signal-master, e.g. a CPU
    AB_master  : in    MemoryMappedAddressType; --AB from master
    DB2master  : out MemoryMappedDataType; -- DB to master
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
end MemoryMapper;

architecture Behavioral of MemoryMapper is

  -- integer logarithm (rounded up) [MR version]
  function ilog (x : natural; base : natural := 2) return natural is
    variable y     : natural                 := 1;
  begin
    if x = base ** y then
      return y;
    end if;
    while x > base ** y loop
      y                                      := y + 1;
    end loop;
    return y;
  end ilog;


  -- The selector chooses the connection. When the MemoryMapped region of
  -- port i matches the current address, then the selector will contain the value i.
  -- If non of the MemoryMapped regions matches the current address, then the selector
  -- will contain the value {MemoryMappedNumberOfPorts}, indicating, that the real Memory
  -- (i.e. the {...}_mem Ports) shall be connected
  constant selectorSize                     : positive := ilog(MemoryMappedNumberOfPorts+1);
  signal   selector                         : std_logic_vector(selectorSize-1 downto 0);
  signal   selector_isInRangeOfSpecificPort : std_logic_vector(MemoryMappedNumberOfPorts-1 downto 0);
  -- temporary values of an or-chain
  signal   selector_isInRangeOfAnyPort      : std_logic_vector(MemoryMappedNumberOfPorts-1 downto 0);

  signal DataDB_master_write      : MemoryMappedDataType;
  signal DataDB_memAndPorts_write : MemoryMappedDataType;

  -- The 'combined' signals combine the ports and the master in one vector.
  signal Ack2master_combined : std_logic_vector(MemoryMappedNumberOfPorts downto 0);
  signal DataDB_master_combined  : MemoryMappedDataArrayType(MemoryMappedNumberOfPorts downto 0);

  type selector_temp_type is array (natural range<>) of std_logic_vector(selectorSize-1 downto 0);
  -- A generated chain. The last entry (highest index) contains the number of
  -- the port that is selected if the requested address is in range of any port.
  signal selector_temp : selector_temp_type(MemoryMappedNumberOfPorts-1 downto 0);


begin

  -- Assert, that the MemoryMappedAddressRanges in each port is valid (low <= high)
  testAddressRangesInPort : for i in 0 to MemoryMappedNumberOfPorts-1 generate
    assert ( MemoryMappedAddressRanges(i)(0) <= MemoryMappedAddressRanges(i)(1) )
      report "INVALID ADDRESS RANGES IN PORT " & integer'image(i)
      & ". The 'low' address (" & integer'image(MemoryMappedAddressRanges(i)(0))
      & ") must be smaller or equal than the 'high' address ("
      & integer'image(MemoryMappedAddressRanges(i)(1)) & ")."
      severity failure;
  end generate testAddressRangesInPort;


  -- Assert, that the MemoryMappedAddressRanges of the different ports are not overlapping
  testAddressRangesBetweenPorts : for i in 0 to MemoryMappedNumberOfPorts-1 generate
    innerLoop                   : for j in 0 to i generate
      differentPorts            : if i /= j generate
        assert ( (MemoryMappedAddressRanges(i)(0) > MemoryMappedAddressRanges(j)(1))
                 or (MemoryMappedAddressRanges(i)(1) < MemoryMappedAddressRanges(j)(0)) )
          report "OVERLAPPING ADDRESS RANGES IN THE MEMORY-MAPPED PORTS " & integer'image(j)
          & " and " & integer'image(i) & "."
          severity failure;
      end generate differentPorts;
    end generate innerLoop;
  end generate testAddressRangesBetweenPorts;


  -- Compute the selector
  ComputeSelector : for i in 0 to MemoryMappedNumberOfPorts-1 generate

    selector_isInRangeOfSpecificPort(i) <= '1' when (AB_master >= MemoryMappedAddressRanges(i)(0)
                                                     and MemoryMappedAddressRanges(i)(1) >= AB_master )
                                           else '0';

    seletor_OrChain_start : if i = 0 generate
      selector_isInRangeOfAnyPort(0) <= selector_isInRangeOfSpecificPort(0);
      selector_temp(i)               <= conv_std_logic_vector(i, selectorSize)
                                        when selector_isInRangeOfSpecificPort(i) = '1'
                                        else (others => '0');
    end generate seletor_OrChain_start;

    seletor_OrChain_middle : if i > 0 generate
      selector_isInRangeOfAnyPort(i) <= selector_isInRangeOfAnyPort(i-1)
                                        or selector_isInRangeOfSpecificPort(i);
      selector_temp(i)               <= conv_std_logic_vector(i, selectorSize)
                                        when selector_isInRangeOfSpecificPort(i) = '1'
                                        else selector_temp(i-1);
    end generate seletor_OrChain_middle;
  end generate ComputeSelector;
  selector                           <= conv_std_logic_vector(MemoryMappedNumberOfPorts, selectorSize)
                                        when selector_isInRangeOfAnyPort(MemoryMappedNumberOfPorts-1) = '0'
                                        else selector_temp(MemoryMappedNumberOfPorts-1);


  -- Connect the Request Signal
  Req2mem        <= Req_master when selector = MemoryMappedNumberOfPorts else '0';
  DataReqPorts : for i in MemoryMappedNumberOfPorts-1 downto 0 generate
    Req2ports(i) <= Req_master when selector = i                         else '0';
  end generate DataReqPorts;


  -- Connect the Acknowledge Signal
  Ack2master_combined <= Ack_mem & Ack_ports;
  Ack2master          <= Ack2master_combined(conv_integer(selector));


  -- Connect The Data Bus
  createCombinedArray         : for i in 0 to MemoryMappedNumberOfPorts generate
    createCombinedArray_mem   : if i = MemoryMappedNumberOfPorts generate
--      DataDB_master_combined(MemoryMappedNumberOfPorts) <= DataDB_mem;
      DataDB_master_combined(MemoryMappedNumberOfPorts) <= DB_mem;
    end generate createCombinedArray_mem;
    createCombinedArray_ports : if i < MemoryMappedNumberOfPorts generate
--          DataDB_master_combined(MemoryMappedNumberOfPorts) <= DataDB_mem;
          DataDB_master_combined(MemoryMappedNumberOfPorts) <= DB_mem;
--      DataDB_master_combined(i)                         <= DataDB_ports(i);
      DataDB_master_combined(i)                         <= DB_ports(i);
    end generate createCombinedArray_ports;
  end generate createCombinedArray;

  DataDB_master_write <= DataDB_master_combined(conv_integer(selector));
--  DataDB_master       <= DataDB_master_write when RW_master = "1111" else (others => 'Z');  -- "1111" is read mode
  DB2master       <= DataDB_master_write when RW_master = '0' else (others => 'Z');  -- "1111" is read mode

--  DataDB_memAndPorts_write <= DataDB_master when RW_master /= "1111" else (others => 'Z');  -- "1111" is read mode;
  DataDB_memAndPorts_write <= DB_master when RW_master /= '0' else (others => 'Z');  -- "1111" is read mode;
--  DataDB_mem               <= DataDB_memAndPorts_write;
  DB2mem               <= DataDB_memAndPorts_write;
  DataDBPorts : for i in MemoryMappedNumberOfPorts-1 downto 0 generate
--    DataDB_ports(i)        <= DataDB_memAndPorts_write;
    DB2ports(i)        <= DataDB_memAndPorts_write;
  end generate DataDBPorts;


end Behavioral;
