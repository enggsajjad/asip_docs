














































































/*
 * Copyright (c) 2007-2008 NEC Corpoartion.
 * All rights reserved.
 * Use and distribution of this program without permission are not allowed.
 *
 */

/*
 * Library for reading and writing registers and memory specified by XML
 * processor model files.
 *
 * This file is used as a template of the instruction
 * encoding/decodign library
 *
 * !!! This file is under construction. !!!
 */

/*
 * To support new registers added by CCG, the following original
 * functions to address CPU registers in GDB have to be modified.
 *   gdb/sim/cpu/xxx.c:  sim_fetch_register()
 *   gdb/sim/cpu/xxx.c:  sim_store_register()
 *   gdb/cpu-tdep.c:   cpu_register_name()
 *   gdb/cpu-tdep.c:   cpu_register_type()
 *   gdb/cpu-tdep.c:   cpu_register_byte()      which may not exist in some cpus.
 *   gdb/cpu-tdep.c:   cpu_register_sim_regno() which may not exist in some cpus.
 *
 *
 * To support new registers added by CCG, the target dependent
 * initialization in a function of cpu_gdbarch_init() in cpu-tdep.c
 * have to be modified in terms of the following items.
 *   set_gdbarch_deprecated_register_byte (gdbarch, cpu_register_byte);
 *   set_gdbarch_num_regs (gdbarch, NUM_REGS);
 *   set_gdbarch_register_type (gdbarch, cpu_register_type);
 *   set_gdbarch_register_name (gdbarch, cpu_register_name);
 *   set_gdbarch_register_sim_regno (gdbarch, cpu_register_sim_regno);
 *
 *
 * To support new instructions added by CCG, the following original
 * functions in GDB have to be modified to execute instructions in the
 * simulator built in GDB.
 *   sim_engine_run()  which may be generated by igen (gdb/sim/igen),
 *                     or may be hand-coded.
 */



#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

#include "sysdep.h"
#include "bfd.h"
#include "gdb/callback.h"
#include "gdb/remote-sim.h"
#include "sim-main.h"

#ifndef _XXXCPU_TEST_
#include "opcode/libccg-brownie32.h"
#include "libccg-sim-brownie32.h"
#else  /*_XXXCPU_TEST_*/
#include "libccg-brownie32.h"
#include "libccg-sim-brownie32.h"
#endif /*_XXXCPU_TEST_*/


/* Function prototypes for executing instructions. */

static void insn_exec_STEP2 (insn_info_t *insn, int32_t *operands);
static void insn_exec_STEP5 (insn_info_t *insn, int32_t *operands);
static void insn_exec_STEP4a (insn_info_t *insn, int32_t *operands);
static void insn_exec_STEP4b (insn_info_t *insn, int32_t *operands);


/*
 * Functions in this file are intented to be used for executing new
 * instructions added by CCG.
 */

/* Functions to execute instructions. */
static  insn_exec_func_t  insn_exec_funcs[(int)E_INSN_ID_END] =
{

insn_exec_STEP2,
insn_exec_STEP5,
insn_exec_STEP4A,
insn_exec_STEP4B,

};

/*
 * Simulator descriptor (SIM_DESC).
 * This is a pointer to a structure representing a target processor.
 */
static SIM_DESC  libccg_current_sim_desc;

/*
 * Register pointers array.
 * This array has register pointers to the contents of all registers.
 * Only pointers to the contents of extended registers are used, and
 * the contents of original registers in the base processor are not
 * used.
 */
static void **libccg_registers_array;



/***********************************************************/

/* Return the current simulator descriptor (SIM_DESC). */ 
SIM_DESC
libccg_get_current_sim_desc (void)
{
  return libccg_current_sim_desc;
}

/* Set the given SD as the current simulator descriptor (SIM_DESC).
 *
 * This function should be invoked in sim_engine_run() before
 * executing any instructions.
 */
int
libccg_set_current_sim_desc (SIM_DESC sd)
{
  libccg_current_sim_desc = sd;
  return 0;
}

/* Initialize this library for the simulator.
 *
 * This function should be invoked in sim_open().
 */
void
libccg_init_sim (void)
{
  /* Allocate memory area for registers and fill it with zero. */
  libccg_registers_array = libccg_malloc_for_extended_registers ();

//   int i;
//   register_bank_info_t *regbank_info = libccg_get_register_bank_info_ptr ();
//   int regs_max_num = libccg_get_num_of_all_regs ();

//   libccg_registers_array = malloc (regs_max_num * sizeof (void *));

//   for ( i = 0 ; &regbank_info[i] && regbank_info[i].size ; i++ )
//   {
//     int k;
//     const int *gdb_regnums_array = regbank_info[i].gdb_regnums;
//     for ( k = 0 ; k < regbank_info[i].size ; k++ )
//     {
//       int reg_num = gdb_regnums_array[k];
//       int reg_size = libccg_get_register_width_by_regnum (regnum);
//       reg_size = ((reg_size + 7) / 8);

//       if (regs_max_num <= reg_num)
//       {
//         fprintf (stderr, "illegal register number");
//         abort ();
//       }

//       libccg_registers_array[reg_num] = calloc (reg_size * sizeof (void *), 1);
//     }
//   }
}

/* Read the extended register specified by the register number. */
int
libccg_fetch_extended_register (int regnum, uint8_t *buff, int length)
{
  int i;
  int result = 0;
  uint8_t *dest = (uint8_t *) libccg_registers_array[regnum];

  for ( i = 0 ; i < length ; i++ )
  {
    dest[i] = buff[i];
  }

  return result;
}

/* Write the extended register specified by the register number. */
int
libccg_store_extended_register (int regnum, uint8_t *buff, int length)
{
  int i;
  int result = 0;
  uint8_t *src = (uint8_t *) libccg_registers_array[regnum];

  for ( i = 0 ; i < length ; i++ )
  {
    buff[i] = src[i];
  }

  return result;
}

/* Read the register specified by the register number. */
int
libccg_fetch_register (int regnum, uint8_t *buff)
{
  SIM_DESC sd = libccg_get_current_sim_desc ();
  int length  = libccg_get_register_width_by_regnum (regnum);

  sim_fetch_register (sd, regnum, buff, length);

  return 0;
}

/* Write the register specified by the register number. */
int
libccg_store_register (int regnum, uint8_t *buff)
{
  SIM_DESC sd = libccg_get_current_sim_desc ();
  int length  = libccg_get_register_width_by_regnum (regnum);

  sim_store_register (sd, regnum, buff, length);

  return 0;
}

/* Read a register. */
int8_t
libccg_fetch_register8 (int regnum)
{
  uint8_t buff[1];
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_fetch_register (sd, regnum, &buff[0], 1);
  return *((int8_t*)(&buff[0]));
}
int16_t
libccg_fetch_register16 (int regnum)
{
  /* FIXME:
   * We have to treat an endian problem here.
   * The following code can only work in case of little endian target
   * and host machines. */
  uint8_t buff[2];
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_fetch_register (sd, regnum, &buff[0], 2);
  return *((int16_t*)(&buff[0]));
}
int32_t
libccg_fetch_register32 (int regnum)
{
  /* FIXME:
   * We have to treat an endian problem here.
   * The following code can only work in case of little endian target
   * and host machines. */
  uint8_t buff[4];
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_fetch_register (sd, regnum, &buff[0], 4);
  return T2H_4(*((int32_t*)(&buff[0])));
}
int64_t
libccg_fetch_register64 (int regnum)
{
  /* FIXME:
   * We have to treat an endian problem here.
   * The following code can only work in case of little endian target
   * and host machines. */
  uint8_t buff[8];
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_fetch_register (sd, regnum, &buff[0], 8);
  return *((int64_t*)(&buff[0]));
}

/* Write a register. */
void
libccg_store_register8 (int regnum, int8_t value)
{
  uint8_t buff[1];
  buff[0] = value;
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_store_register (sd, regnum, &buff[0], 1);
}
void
libccg_store_register16 (int regnum, int16_t value)
{
  /* FIXME:
   * We have to treat an endian problem here.
   * The following code can only work in case of little endian target
   * and host machines. */
  uint8_t buff[2];
  *((int16_t*)(&buff[0])) = value;
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_store_register (sd, regnum, &buff[0], 2);
}
void
libccg_store_register32 (int regnum, int32_t value)
{
  /* FIXME:
   * We have to treat an endian problem here.
   * The following code can only work in case of little endian target
   * and host machines. */
  uint8_t buff[4];
  *((int32_t*)(&buff[0])) = H2T_4(value);
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_store_register (sd, regnum, &buff[0], 4);
}
void
libccg_store_register64 (int regnum, int64_t value)
{
  /* FIXME:
   * We have to treat an endian problem here.
   * The following code can only work in case of little endian target
   * and host machines. */
  uint8_t buff[8];
  *((int64_t*)(&buff[0])) = value;
  SIM_DESC sd = libccg_get_current_sim_desc ();
  sim_store_register (sd, regnum, &buff[0], 8);
}

// /* Read the register specified by the register group ID and index. */
// int
// libccg_fetch_register_by_reggrp_idx (
//   /* register group ID */
//   register_group_id_t reggrp_id,
//   /* register index in the register group */
//   int index,
//   /* buffer to place the content of the registers */
//   uint8_t *buff )
// {
//   /* const int *gdb_regnums_array = register_group_info[reggrp_id].gdb_regnums; */
//   /* int regnum = gdb_regnums_array[index]; */
//   int regnum = libccg_get_gdbregnum_by_reggrp_idx (reggrp_id, index);
//   int result = libccg_fetch_register (regnum, buff);
//   return result;
// }

// /* Read the register specified by the register group ID and index
//  * and return the lower 32-bit content of the register.
//  */
// int32_t
// libccg_fetch32_register_by_reggrp_idx (
//   register_group_id_t reggrp_id,
//   int index )
// {
//   int result;
//   int32_t value;
//   uint8_t buff[128];
//   /*const int *gdb_regnums_array = register_group_info[reggrp_id].gdb_regnums;*/
//   /*int regnum = gdb_regnums_array[index];*/
//   int regnum = libccg_get_gdbregnum_by_reggrp_idx (reggrp_id, index);

//   bzero (&buff[0], 4);
//   result = libccg_fetch_register (regnum, &buff[0]);
//   if (result)
//     abort ();
//   /* FIXME:
//    * We have to treat an endian problem here.
//    * The following code can only work in case of little endian target
//    * and host machines. */
//   value = *((int32_t*)(&buff[0]));

//   return value;
// }

// /* Read the register specified by the register group ID and index
//  * and return the lower 64-bit content of the register.
//  */
// int64_t
// libccg_fetch64_register_by_reggrp_idx (
//   register_group_id_t reggrp_id,
//   int index )
// {
//   int result;
//   int64_t value;
//   uint8_t buff[128];
//   /*const int *gdb_regnums_array = register_group_info[reggrp_id].gdb_regnums;*/
//   /*int regnum = gdb_regnums_array[index];*/
//   int regnum = libccg_get_gdbregnum_by_reggrp_idx (reggrp_id, index);

//   bzero (&buff[0], 8);
//   result = libccg_fetch_register (regnum, &buff[0]);
//   if (result)
//     abort ();
//   /* FIXME:
//    * We have to treat an endian problem here.
//    * The following code can only work in case of little endian target
//    * and host machines. */
//   value = *((int64_t*)(&buff[0]));

//   return value;
// }

// /* Write the register specified by the register group ID and index. */
// int
// libccg_store_register_by_reggrp_idx (
//   register_group_id_t reggrp_id,
//   int index,
//   uint8_t *buff )
// {
//   /*const int *gdb_regnums_array = register_group_info[reggrp_id].gdb_regnums;*/
//   /*int regnum = gdb_regnums_array[index];*/
//   int regnum = libccg_get_gdbregnum_by_reggrp_idx (reggrp_id, index);
//   int result = libccg_store_register (regnum, buff);
//   return result;
// }

// /* Write the register specified by the register group ID and index
//  * and the register is 32-bit wide. */
// int
// libccg_store32_register_by_reggrp_idx (
//   register_group_id_t reggrp_id,
//   int index,
//   int32_t value )
// {
//   int result;
//   uint8_t buff[128];
//   /*const int *gdb_regnums_array = register_group_info[reggrp_id].gdb_regnums;*/
//   /*int regnum = gdb_regnums_array[index];*/
//   int regnum = libccg_get_gdbregnum_by_reggrp_idx (reggrp_id, index);

//   /* FIXME:
//    * We have to treat an endian problem here.
//    * The following code can only work in case of little endian target
//    * and host machines. */
//   bzero (&buff[0], 4);
//   *((int32_t*)(&buff[0])) = value;
//   result = libccg_store_register (regnum, &buff[0]);
//   if (result)
//     abort ();

//   return result;
// }

// /* Write the register specified by the register group ID and index
//  * and the register is 64-bit wide. */
// int
// libccg_store64_register_by_reggrp_idx (
//   register_group_id_t reggrp_id,
//   int index,
//   int64_t value )
// {
//   int result;
//   uint8_t buff[128];
//   /*const int *gdb_regnums_array = register_group_info[reggrp_id].gdb_regnums;*/
//   /*int regnum = gdb_regnums_array[index];*/
//   int regnum = libccg_get_gdbregnum_by_reggrp_idx (reggrp_id, index);

//   /* FIXME:
//    * We have to treat an endian problem here.
//    * The following code can only work in case of little endian target
//    * and host machines. */
//   bzero (&buff[0], 8);
//   *((int64_t*)(&buff[0])) = value;
//   result = libccg_store_register (regnum, &buff[0]);
//   if (result)
//     abort ();

//   return result;
// }


/***********************************************************/

/* This function read data from memory.
 *
 * The simulator in GDB have to provide a function of sim_read(),
 * which is a function to read memory and can be found in
 * include/gdb/remote-sim.h and sim/common/xxx.c.
 */
int
libccg_read_memory (int32_t address, uint8_t *buff, int length)
{
  SIM_DESC sd = libccg_get_current_sim_desc ();
  int result = sim_read (sd, address, buff, length);
  return result;
}

int8_t
libccg_read_memory8 (int32_t address)
{
  int8_t val;
  libccg_read_memory (address, (uint8_t*)&val, 1);
  return val;
}

int16_t
libccg_read_memory16 (int32_t address)
{
  int16_t val;
  libccg_read_memory (address, (uint8_t*)&val, 2);
  return val;
}

int32_t
libccg_read_memory32 (int32_t address)
{
  int32_t val;
  libccg_read_memory (address, (uint8_t*)&val, 4);
  return val;
}

int64_t
libccg_read_memory64 (int32_t address)
{
  int64_t val;
  libccg_read_memory (address, (uint8_t*)&val, 8);
  return val;
}

/* This function write data to memory.
 *
 * The simulator in GDB have to provide a function of sim_write(),
 * which is a function to write memory and can be found in
 * include/gdb/remote-sim.h and sim/common/xxx.c.
 */
int
libccg_write_memory (int32_t address, uint8_t *buff, int length)
{
  SIM_DESC sd = libccg_get_current_sim_desc ();
  int result = sim_write (sd, address, buff, length);
  return result;
}

void
libccg_write_memory8 (int32_t address, int8_t value)
{
  int8_t val = value;
  libccg_write_memory (address, (uint8_t*)&val, 1);
}

void
libccg_write_memory16 (int32_t address, int16_t value)
{
  int16_t val = value;
  libccg_write_memory (address, (uint8_t*)&val, 2);
}

void
libccg_write_memory32 (int32_t address, int32_t value)
{
  int32_t val = value;
  libccg_write_memory (address, (uint8_t*)&val, 4);
}

void
libccg_write_memory64 (int32_t address, int64_t value)
{
  int64_t val = value;
  libccg_write_memory (address, (uint8_t*)&val, 8);
}

/***********************************************************/

/* Execute an instruction at the given instruction address and return
 * the next instruction address. */
uint32_t
libccg_exec_insn (
  /* Simulator descriptor */
  SIM_DESC sd,
  /* Instruction address */
  uint32_t addr,
  /* Instruction (64 bits) */
  int64_t  bits )
{
  int  i;
  insn_exec_func_t  exec_func;
  int       length;
  int32_t   op_values[32];
  params_t  operands;
  uint32_t  addr_next = addr;
  insn_id_t id = libccg_decode_insn (bits);
  insn_info_t *insn = libccg_get_insn_info (id);

  if ((int)id < 0
      || (int)E_INSN_ID_END <= (int)id )
    return addr_next;

  exec_func = insn_exec_funcs[(int)id];
  length = libccg_get_insn_length (id);
  libccg_get_insn_operands (&operands, id, bits);

  if (length < 0 || 32 <= operands.size)
    abort ();

  for ( i=0 ; i<operands.size ; i++ )
  {
    op_values[i] = operands.values[i];
  }

  libccg_set_current_sim_desc (sd);
  exec_func (insn, &op_values[0]);
  addr_next += length;

  return addr_next;
}


/***********************************************************/

/* Function prototypes for executing instructions. */
__insn_exec_funcs_body__
