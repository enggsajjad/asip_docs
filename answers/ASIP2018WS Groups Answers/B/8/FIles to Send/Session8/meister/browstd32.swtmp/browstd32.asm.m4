m4_changequote(<<<<, >>>>)

m4_define(<<<<__opcode_xxxcpu_h__>>>>,<<<<#include "opcode/libccg-brownie32.h">>>>)
m4_define(<<<<__xxxcpu_h__>>>>,<<<<#include "libccg-brownie32.h">>>>)

m4_define(<<<<__opcode_xxxcpu_sim_h__>>>>,<<<<#include "opcode/libccg-sim-brownie32.h">>>>)
m4_define(<<<<__xxxcpu_sim_h__>>>>,<<<<#include "libccg-sim-brownie32.h">>>>)

m4_define(<<<<is_opcode_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_register_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_immediate_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_multiple02_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_multiple04_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_multiple08_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_multiple16_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_multiple32_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_power2_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<is_unused_field_type>>>>,<<<<brownie32_$0$@>>>>)

m4_define(<<<<encode_opcode_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_register_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_immediate_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_multiple02_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_multiple04_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_multiple08_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_multiple16_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_multiple32_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_power2_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<encode_unused_field_type>>>>,<<<<brownie32_$0$@>>>>)

m4_define(<<<<decode_opcode_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_register_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_immediate_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_multiple02_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_multiple04_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_multiple08_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_multiple16_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_multiple32_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_power2_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<decode_unused_field_type>>>>,<<<<brownie32_$0$@>>>>)

m4_define(<<<<parse_register_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_immediate_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_multiple02_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_multiple04_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_multiple08_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_multiple16_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_multiple32_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_power2_field_type>>>>,<<<<brownie32_$0$@>>>>)
m4_define(<<<<parse_unused_field_type>>>>,<<<<brownie32_$0$@>>>>)

m4_define(<<<<__insn_id__>>>>,<<<<
>>>>)

m4_define(<<<<__field_type__>>>>,<<<<
E_INSN_FIELD_TYPE__REGBANK_GR,
>>>>)

m4_define(<<<<__register_bank_info_content__>>>>,<<<<
{ "GR", 32, 32, "r", &regbank__GR[0], &gdb_regnum_regbank__GR[0], E_INSN_FIELD_TYPE__REGBANK_GR, 1 },
{ 0, 0, 0, 0, 0, 0, E_INSN_FIELD_TYPE__END, 0 },
>>>>)

m4_define(<<<<__register_group__>>>>,<<<<
static const char *regbank__GR[] = { "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7", "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15", "r16", "r17", "r18", "r19", "r20", "r21", "r22", "r23", "r24", "r25", "r26", "r27", "r28", "r29", "r30", "r31", };
>>>>)

m4_define(<<<<__register_group_info_content__>>>>,<<<<
{ "GR", 32, &regbank__GR[0], &gdb_regnum_regbank__GR[0], E_INSN_FIELD_TYPE__REGBANK_GR },
{ 0, 0, 0, 0, E_INSN_FIELD_TYPE__END },
>>>>)

m4_define(<<<<__register_group_id__>>>>,<<<<
E_REGGROUP_ID__GR,
>>>>)

m4_define(<<<<__register_width_as_enum__>>>>,<<<<
enum register_width_as_enum
{
E_REGISTER_WIDTH__GR__0 = 32,
E_REGISTER_WIDTH__GR__1 = 32,
E_REGISTER_WIDTH__GR__2 = 32,
E_REGISTER_WIDTH__GR__3 = 32,
E_REGISTER_WIDTH__GR__4 = 32,
E_REGISTER_WIDTH__GR__5 = 32,
E_REGISTER_WIDTH__GR__6 = 32,
E_REGISTER_WIDTH__GR__7 = 32,
E_REGISTER_WIDTH__GR__8 = 32,
E_REGISTER_WIDTH__GR__9 = 32,
E_REGISTER_WIDTH__GR__10 = 32,
E_REGISTER_WIDTH__GR__11 = 32,
E_REGISTER_WIDTH__GR__12 = 32,
E_REGISTER_WIDTH__GR__13 = 32,
E_REGISTER_WIDTH__GR__14 = 32,
E_REGISTER_WIDTH__GR__15 = 32,
E_REGISTER_WIDTH__GR__16 = 32,
E_REGISTER_WIDTH__GR__17 = 32,
E_REGISTER_WIDTH__GR__18 = 32,
E_REGISTER_WIDTH__GR__19 = 32,
E_REGISTER_WIDTH__GR__20 = 32,
E_REGISTER_WIDTH__GR__21 = 32,
E_REGISTER_WIDTH__GR__22 = 32,
E_REGISTER_WIDTH__GR__23 = 32,
E_REGISTER_WIDTH__GR__24 = 32,
E_REGISTER_WIDTH__GR__25 = 32,
E_REGISTER_WIDTH__GR__26 = 32,
E_REGISTER_WIDTH__GR__27 = 32,
E_REGISTER_WIDTH__GR__28 = 32,
E_REGISTER_WIDTH__GR__29 = 32,
E_REGISTER_WIDTH__GR__30 = 32,
E_REGISTER_WIDTH__GR__31 = 32,
};
>>>>)

m4_define(<<<<__gdb_regnum_table__>>>>,<<<<
static const int gdb_regnum_regbank__GR[] = { 0 /*R0*/, 1 /*R1*/, 2 /*R2*/, 3 /*R3*/, 4 /*R4*/, 5 /*R5*/, 6 /*R6*/, 7 /*R7*/, 8 /*R8*/, 9 /*R9*/, 10 /*R10*/, 11 /*R11*/, 12 /*R12*/, 13 /*R13*/, 14 /*R14*/, 15 /*R15*/, 16 /*R16*/, 17 /*R17*/, 18 /*R18*/, 19 /*R19*/, 20 /*R20*/, 21 /*R21*/, 22 /*R22*/, 23 /*R23*/, 24 /*R24*/, 25 /*R25*/, 26 /*R26*/, 27 /*R27*/, 28 /*R28*/, 29 /*R29*/, 30 /*R30*/, 31 /*R31*/, };
>>>>)

m4_define(<<<<__gdb_regnum_as_enum__>>>>,<<<<
enum gdb_regnum_as_enum {
E_GDB_REGNUM__GR__0 = 0,
E_GDB_REGNUM__GR__1 = 1,
E_GDB_REGNUM__GR__2 = 2,
E_GDB_REGNUM__GR__3 = 3,
E_GDB_REGNUM__GR__4 = 4,
E_GDB_REGNUM__GR__5 = 5,
E_GDB_REGNUM__GR__6 = 6,
E_GDB_REGNUM__GR__7 = 7,
E_GDB_REGNUM__GR__8 = 8,
E_GDB_REGNUM__GR__9 = 9,
E_GDB_REGNUM__GR__10 = 10,
E_GDB_REGNUM__GR__11 = 11,
E_GDB_REGNUM__GR__12 = 12,
E_GDB_REGNUM__GR__13 = 13,
E_GDB_REGNUM__GR__14 = 14,
E_GDB_REGNUM__GR__15 = 15,
E_GDB_REGNUM__GR__16 = 16,
E_GDB_REGNUM__GR__17 = 17,
E_GDB_REGNUM__GR__18 = 18,
E_GDB_REGNUM__GR__19 = 19,
E_GDB_REGNUM__GR__20 = 20,
E_GDB_REGNUM__GR__21 = 21,
E_GDB_REGNUM__GR__22 = 22,
E_GDB_REGNUM__GR__23 = 23,
E_GDB_REGNUM__GR__24 = 24,
E_GDB_REGNUM__GR__25 = 25,
E_GDB_REGNUM__GR__26 = 26,
E_GDB_REGNUM__GR__27 = 27,
E_GDB_REGNUM__GR__28 = 28,
E_GDB_REGNUM__GR__29 = 29,
E_GDB_REGNUM__GR__30 = 30,
E_GDB_REGNUM__GR__31 = 31,
};
>>>>)

m4_define(<<<<__insn_info_content__>>>>,<<<<
>>>>)

m4_define(<<<<__insn_decoding_order_content__>>>>,<<<<

>>>>)

m4_define(<<<<__insn_exec_func_prototype__>>>>,<<<<
>>>>)

m4_define(<<<<__insn_exec_funcs_content__>>>>,<<<<
>>>>)

m4_define(<<<<__insn_exec_funcs_init_params__>>>>,<<<<
>>>>)

