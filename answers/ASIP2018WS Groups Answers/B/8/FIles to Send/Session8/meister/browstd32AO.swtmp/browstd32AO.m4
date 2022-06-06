m4_changequote(<<<<, >>>>)

m4_define(<<<<__HARD_REGNO_MODE_OK__>>>>,<<<<>>>>)

m4_define(<<<<__FIRST_PSEUDO_REGISTER__>>>>,<<<<#define FIRST_PSEUDO_REGISTER 32>>>>)

m4_define(<<<<__FIXED_REGISTERS__>>>>,<<<<>>>>)

m4_define(<<<<__CALL_USED_REGISTERS__>>>>,<<<<>>>>)

m4_define(<<<<__enum_reg_class__>>>>,<<<</* enum reg_class */
enum reg_class
{
NO_REGS,
GR_REGS,
ALL_REGS,
LIM_REG_CLASSES
};

>>>>)

m4_define(<<<<__REGISTER_NAMES__>>>>,<<<<#define REGISTER_NAMES \
{\
"r0",\
"r1",\
"r2",\
"r3",\
"r4",\
"r5",\
"r6",\
"r7",\
"r8",\
"r9",\
"r10",\
"r11",\
"r12",\
"r13",\
"r14",\
"r15",\
"r16",\
"r17",\
"r18",\
"r19",\
"r20",\
"r21",\
"r22",\
"r23",\
"r24",\
"r25",\
"r26",\
"r27",\
"r28",\
"r29",\
"r30",\
"r31",\
}
>>>>)

m4_define(<<<<__REG_CLASS_NAMES__>>>>,<<<</* REG_CLASS_NAMES */
#define REG_CLASS_NAMES \
{ \
"NO_REGS", \
"GR_REGS", \
"ALL_REGS", \
}

>>>>)

m4_define(<<<<__REG_CLASS_CONTENTS__>>>>,<<<</* REG_CLASS_CONTENTS */
#define REG_CLASS_CONTENTS \
{ \
{ 0x00000000,  }, /* NO_REGS */ \
{ 0xFFFFFFFF,  }, /* GR_REGS */ \
{ 0xFFFFFFFF,  }, /* ALL_REGS */ \
}

>>>>)

m4_define(<<<<__REG_CLASS_FROM_LETTER__>>>>,<<<<#define REG_CLASS_FROM_LETTER(C)  ( \
  (C) == 'd' ? GR_REGS : \
  NO_REGS)

>>>>)

m4_define(<<<<__RTL_TEMPLATES__>>>>,<<<<>>>>)

m4_define(<<<<__INIT_BUILTINS__>>>>,<<<<
>>>>)

m4_define(<<<<__MD_CONSTANTS__>>>>,<<<<;; Constants used in RTL templates.
(define_constants
[
]
)
>>>>)

m4_define(<<<<__SCHEDULING__>>>>,<<<<(define_attr "insn_mnemonic"
  "unknown"
(const_string "unknown")
)

>>>>)

m4_define(<<<<__BYPASS_FUNCTION__>>>>,<<<<>>>>)

m4_define(<<<<__SUPPORT_FUNC_FOR_IMMEDIATE__>>>>,<<<<#define IS_N_BIT_SIGNED_IMMEDIATE32(VALUE,N) \
  (((uint32_t)(VALUE) + (((uint32_t)1)<<((N)-1))) < (((uint32_t)1) << (N)))
#define IS_N_BIT_SIGNED_IMMEDIATE64(VALUE,N) \
  (((uint64_t)(VALUE) + (((uint64_t)1)<<((N)-1))) < (((uint64_t)1) << (N)))
#define IS_N_BIT_UNSIGNED_IMMEDIATE32(VALUE,N) \
  (((uint32_t)(VALUE)) < (((uint32_t)1) << (N)))
#define IS_N_BIT_UNSIGNED_IMMEDIATE64(VALUE,N) \
  (((uint64_t)(VALUE)) < (((uint64_t)1) << (N)))
int
brownie32_signed_immediate_1 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),1));
}
int
brownie32_unsigned_immediate_1 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),1));
}
int
brownie32_signed_immediate_2 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),2));
}
int
brownie32_unsigned_immediate_2 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),2));
}
int
brownie32_signed_immediate_3 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),3));
}
int
brownie32_unsigned_immediate_3 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),3));
}
int
brownie32_signed_immediate_4 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),4));
}
int
brownie32_unsigned_immediate_4 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),4));
}
int
brownie32_signed_immediate_5 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),5));
}
int
brownie32_unsigned_immediate_5 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),5));
}
int
brownie32_signed_immediate_6 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),6));
}
int
brownie32_unsigned_immediate_6 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),6));
}
int
brownie32_signed_immediate_7 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),7));
}
int
brownie32_unsigned_immediate_7 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),7));
}
int
brownie32_signed_immediate_8 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),8));
}
int
brownie32_unsigned_immediate_8 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),8));
}
int
brownie32_signed_immediate_9 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),9));
}
int
brownie32_unsigned_immediate_9 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),9));
}
int
brownie32_signed_immediate_10 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),10));
}
int
brownie32_unsigned_immediate_10 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),10));
}
int
brownie32_signed_immediate_11 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),11));
}
int
brownie32_unsigned_immediate_11 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),11));
}
int
brownie32_signed_immediate_12 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),12));
}
int
brownie32_unsigned_immediate_12 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),12));
}
int
brownie32_signed_immediate_13 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),13));
}
int
brownie32_unsigned_immediate_13 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),13));
}
int
brownie32_signed_immediate_14 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),14));
}
int
brownie32_unsigned_immediate_14 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),14));
}
int
brownie32_signed_immediate_15 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),15));
}
int
brownie32_unsigned_immediate_15 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),15));
}
int
brownie32_signed_immediate_16 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),16));
}
int
brownie32_unsigned_immediate_16 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),16));
}
int
brownie32_signed_immediate_17 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),17));
}
int
brownie32_unsigned_immediate_17 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),17));
}
int
brownie32_signed_immediate_18 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),18));
}
int
brownie32_unsigned_immediate_18 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),18));
}
int
brownie32_signed_immediate_19 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),19));
}
int
brownie32_unsigned_immediate_19 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),19));
}
int
brownie32_signed_immediate_20 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),20));
}
int
brownie32_unsigned_immediate_20 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),20));
}
int
brownie32_signed_immediate_21 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),21));
}
int
brownie32_unsigned_immediate_21 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),21));
}
int
brownie32_signed_immediate_22 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),22));
}
int
brownie32_unsigned_immediate_22 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),22));
}
int
brownie32_signed_immediate_23 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),23));
}
int
brownie32_unsigned_immediate_23 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),23));
}
int
brownie32_signed_immediate_24 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),24));
}
int
brownie32_unsigned_immediate_24 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),24));
}
int
brownie32_signed_immediate_25 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),25));
}
int
brownie32_unsigned_immediate_25 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),25));
}
int
brownie32_signed_immediate_26 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),26));
}
int
brownie32_unsigned_immediate_26 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),26));
}
int
brownie32_signed_immediate_27 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),27));
}
int
brownie32_unsigned_immediate_27 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),27));
}
int
brownie32_signed_immediate_28 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),28));
}
int
brownie32_unsigned_immediate_28 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),28));
}
int
brownie32_signed_immediate_29 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),29));
}
int
brownie32_unsigned_immediate_29 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),29));
}
int
brownie32_signed_immediate_30 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),30));
}
int
brownie32_unsigned_immediate_30 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),30));
}
int
brownie32_signed_immediate_31 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE32 (INTVAL (op),31));
}
int
brownie32_unsigned_immediate_31 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE32 (INTVAL (op),31));
}
int
brownie32_signed_immediate_32 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),32));
}
int
brownie32_unsigned_immediate_32 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),32));
}
int
brownie32_signed_immediate_33 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),33));
}
int
brownie32_unsigned_immediate_33 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),33));
}
int
brownie32_signed_immediate_34 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),34));
}
int
brownie32_unsigned_immediate_34 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),34));
}
int
brownie32_signed_immediate_35 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),35));
}
int
brownie32_unsigned_immediate_35 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),35));
}
int
brownie32_signed_immediate_36 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),36));
}
int
brownie32_unsigned_immediate_36 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),36));
}
int
brownie32_signed_immediate_37 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),37));
}
int
brownie32_unsigned_immediate_37 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),37));
}
int
brownie32_signed_immediate_38 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),38));
}
int
brownie32_unsigned_immediate_38 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),38));
}
int
brownie32_signed_immediate_39 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),39));
}
int
brownie32_unsigned_immediate_39 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),39));
}
int
brownie32_signed_immediate_40 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),40));
}
int
brownie32_unsigned_immediate_40 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),40));
}
int
brownie32_signed_immediate_41 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),41));
}
int
brownie32_unsigned_immediate_41 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),41));
}
int
brownie32_signed_immediate_42 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),42));
}
int
brownie32_unsigned_immediate_42 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),42));
}
int
brownie32_signed_immediate_43 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),43));
}
int
brownie32_unsigned_immediate_43 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),43));
}
int
brownie32_signed_immediate_44 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),44));
}
int
brownie32_unsigned_immediate_44 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),44));
}
int
brownie32_signed_immediate_45 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),45));
}
int
brownie32_unsigned_immediate_45 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),45));
}
int
brownie32_signed_immediate_46 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),46));
}
int
brownie32_unsigned_immediate_46 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),46));
}
int
brownie32_signed_immediate_47 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),47));
}
int
brownie32_unsigned_immediate_47 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),47));
}
int
brownie32_signed_immediate_48 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),48));
}
int
brownie32_unsigned_immediate_48 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),48));
}
int
brownie32_signed_immediate_49 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),49));
}
int
brownie32_unsigned_immediate_49 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),49));
}
int
brownie32_signed_immediate_50 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),50));
}
int
brownie32_unsigned_immediate_50 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),50));
}
int
brownie32_signed_immediate_51 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),51));
}
int
brownie32_unsigned_immediate_51 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),51));
}
int
brownie32_signed_immediate_52 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),52));
}
int
brownie32_unsigned_immediate_52 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),52));
}
int
brownie32_signed_immediate_53 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),53));
}
int
brownie32_unsigned_immediate_53 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),53));
}
int
brownie32_signed_immediate_54 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),54));
}
int
brownie32_unsigned_immediate_54 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),54));
}
int
brownie32_signed_immediate_55 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),55));
}
int
brownie32_unsigned_immediate_55 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),55));
}
int
brownie32_signed_immediate_56 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),56));
}
int
brownie32_unsigned_immediate_56 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),56));
}
int
brownie32_signed_immediate_57 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),57));
}
int
brownie32_unsigned_immediate_57 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),57));
}
int
brownie32_signed_immediate_58 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),58));
}
int
brownie32_unsigned_immediate_58 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),58));
}
int
brownie32_signed_immediate_59 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),59));
}
int
brownie32_unsigned_immediate_59 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),59));
}
int
brownie32_signed_immediate_60 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),60));
}
int
brownie32_unsigned_immediate_60 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),60));
}
int
brownie32_signed_immediate_61 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),61));
}
int
brownie32_unsigned_immediate_61 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),61));
}
int
brownie32_signed_immediate_62 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),62));
}
int
brownie32_unsigned_immediate_62 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),62));
}
int
brownie32_signed_immediate_63 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_SIGNED_IMMEDIATE64 (INTVAL (op),63));
}
int
brownie32_unsigned_immediate_63 (rtx op, enum machine_mode mode ATTRIBUTE_UNUSED)
{
  return ((GET_CODE (op) == CONST_INT)
          && IS_N_BIT_UNSIGNED_IMMEDIATE64 (INTVAL (op),63));
}
>>>>)

m4_define(<<<<__SUPPORT_FUNC_FOR_REGCLASS__>>>>,<<<<int
brownie32_gr_regs_operand (rtx op, enum machine_mode mode)
{
  if (!op)
    return 0;
  if (REG_P (op) && reg_renumber)
  {
    int regno = REGNO (op);
    int regno_renum = reg_renumber[regno];
    if (0 <= regno_renum)
      return TEST_HARD_REG_BIT (reg_class_contents[(int)GR_REGS], regno_renum);
    else if (FIRST_PSEUDO_REGISTER <= regno)
      return 1;
    else
      return 0;
  }
  else
  {
    return register_operand (op, mode);
  }
}
>>>>)

m4_define(<<<<__REGNO_REG_CLASS__>>>>,<<<<extern enum reg_class brownie32_regno_reg_class[];
#define REGNO_REG_CLASS(REGNO) (brownie32_regno_reg_class[REGNO])>>>>)

m4_define(<<<<__ENUM_REGNO_REG_CLASS__>>>>,<<<</* enum reg_class regno_reg_class[] */
enum reg_class  brownie32_regno_reg_class[] = {
GR_REGS, /*r0*/
GR_REGS, /*r1*/
GR_REGS, /*r2*/
GR_REGS, /*r3*/
GR_REGS, /*r4*/
GR_REGS, /*r5*/
GR_REGS, /*r6*/
GR_REGS, /*r7*/
GR_REGS, /*r8*/
GR_REGS, /*r9*/
GR_REGS, /*r10*/
GR_REGS, /*r11*/
GR_REGS, /*r12*/
GR_REGS, /*r13*/
GR_REGS, /*r14*/
GR_REGS, /*r15*/
GR_REGS, /*r16*/
GR_REGS, /*r17*/
GR_REGS, /*r18*/
GR_REGS, /*r19*/
GR_REGS, /*r20*/
GR_REGS, /*r21*/
GR_REGS, /*r22*/
GR_REGS, /*r23*/
GR_REGS, /*r24*/
GR_REGS, /*r25*/
GR_REGS, /*r26*/
GR_REGS, /*r27*/
GR_REGS, /*r28*/
GR_REGS, /*r29*/
GR_REGS, /*r30*/
GR_REGS, /*r31*/
};
>>>>)

m4_define(<<<<__FUNC_PROTOTYPES__>>>>,<<<<extern int brownie32_signed_immediate_1 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_1 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_2 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_2 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_3 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_3 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_4 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_4 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_5 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_5 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_6 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_6 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_7 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_7 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_8 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_8 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_9 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_9 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_10 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_10 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_11 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_11 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_12 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_12 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_13 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_13 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_14 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_14 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_15 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_15 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_16 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_16 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_17 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_17 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_18 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_18 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_19 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_19 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_20 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_20 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_21 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_21 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_22 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_22 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_23 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_23 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_24 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_24 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_25 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_25 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_26 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_26 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_27 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_27 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_28 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_28 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_29 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_29 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_30 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_30 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_31 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_31 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_32 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_32 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_33 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_33 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_34 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_34 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_35 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_35 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_36 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_36 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_37 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_37 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_38 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_38 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_39 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_39 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_40 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_40 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_41 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_41 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_42 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_42 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_43 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_43 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_44 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_44 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_45 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_45 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_46 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_46 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_47 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_47 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_48 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_48 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_49 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_49 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_50 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_50 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_51 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_51 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_52 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_52 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_53 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_53 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_54 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_54 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_55 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_55 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_56 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_56 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_57 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_57 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_58 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_58 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_59 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_59 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_60 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_60 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_61 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_61 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_62 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_62 (rtx op, enum machine_mode mode);
extern int brownie32_signed_immediate_63 (rtx op, enum machine_mode mode);
extern int brownie32_unsigned_immediate_63 (rtx op, enum machine_mode mode);
extern int brownie32_gr_regs_operand (rtx op, enum machine_mode mode);
>>>>)

m4_define(<<<<__EXTRA_PREDICATE_CODES__>>>>,<<<<{ "brownie32_signed_immediate_1", { CONST_INT }},\
{ "brownie32_unsigned_immediate_1", { CONST_INT }},\
{ "brownie32_signed_immediate_2", { CONST_INT }},\
{ "brownie32_unsigned_immediate_2", { CONST_INT }},\
{ "brownie32_signed_immediate_3", { CONST_INT }},\
{ "brownie32_unsigned_immediate_3", { CONST_INT }},\
{ "brownie32_signed_immediate_4", { CONST_INT }},\
{ "brownie32_unsigned_immediate_4", { CONST_INT }},\
{ "brownie32_signed_immediate_5", { CONST_INT }},\
{ "brownie32_unsigned_immediate_5", { CONST_INT }},\
{ "brownie32_signed_immediate_6", { CONST_INT }},\
{ "brownie32_unsigned_immediate_6", { CONST_INT }},\
{ "brownie32_signed_immediate_7", { CONST_INT }},\
{ "brownie32_unsigned_immediate_7", { CONST_INT }},\
{ "brownie32_signed_immediate_8", { CONST_INT }},\
{ "brownie32_unsigned_immediate_8", { CONST_INT }},\
{ "brownie32_signed_immediate_9", { CONST_INT }},\
{ "brownie32_unsigned_immediate_9", { CONST_INT }},\
{ "brownie32_signed_immediate_10", { CONST_INT }},\
{ "brownie32_unsigned_immediate_10", { CONST_INT }},\
{ "brownie32_signed_immediate_11", { CONST_INT }},\
{ "brownie32_unsigned_immediate_11", { CONST_INT }},\
{ "brownie32_signed_immediate_12", { CONST_INT }},\
{ "brownie32_unsigned_immediate_12", { CONST_INT }},\
{ "brownie32_signed_immediate_13", { CONST_INT }},\
{ "brownie32_unsigned_immediate_13", { CONST_INT }},\
{ "brownie32_signed_immediate_14", { CONST_INT }},\
{ "brownie32_unsigned_immediate_14", { CONST_INT }},\
{ "brownie32_signed_immediate_15", { CONST_INT }},\
{ "brownie32_unsigned_immediate_15", { CONST_INT }},\
{ "brownie32_signed_immediate_16", { CONST_INT }},\
{ "brownie32_unsigned_immediate_16", { CONST_INT }},\
{ "brownie32_signed_immediate_17", { CONST_INT }},\
{ "brownie32_unsigned_immediate_17", { CONST_INT }},\
{ "brownie32_signed_immediate_18", { CONST_INT }},\
{ "brownie32_unsigned_immediate_18", { CONST_INT }},\
{ "brownie32_signed_immediate_19", { CONST_INT }},\
{ "brownie32_unsigned_immediate_19", { CONST_INT }},\
{ "brownie32_signed_immediate_20", { CONST_INT }},\
{ "brownie32_unsigned_immediate_20", { CONST_INT }},\
{ "brownie32_signed_immediate_21", { CONST_INT }},\
{ "brownie32_unsigned_immediate_21", { CONST_INT }},\
{ "brownie32_signed_immediate_22", { CONST_INT }},\
{ "brownie32_unsigned_immediate_22", { CONST_INT }},\
{ "brownie32_signed_immediate_23", { CONST_INT }},\
{ "brownie32_unsigned_immediate_23", { CONST_INT }},\
{ "brownie32_signed_immediate_24", { CONST_INT }},\
{ "brownie32_unsigned_immediate_24", { CONST_INT }},\
{ "brownie32_signed_immediate_25", { CONST_INT }},\
{ "brownie32_unsigned_immediate_25", { CONST_INT }},\
{ "brownie32_signed_immediate_26", { CONST_INT }},\
{ "brownie32_unsigned_immediate_26", { CONST_INT }},\
{ "brownie32_signed_immediate_27", { CONST_INT }},\
{ "brownie32_unsigned_immediate_27", { CONST_INT }},\
{ "brownie32_signed_immediate_28", { CONST_INT }},\
{ "brownie32_unsigned_immediate_28", { CONST_INT }},\
{ "brownie32_signed_immediate_29", { CONST_INT }},\
{ "brownie32_unsigned_immediate_29", { CONST_INT }},\
{ "brownie32_signed_immediate_30", { CONST_INT }},\
{ "brownie32_unsigned_immediate_30", { CONST_INT }},\
{ "brownie32_signed_immediate_31", { CONST_INT }},\
{ "brownie32_unsigned_immediate_31", { CONST_INT }},\
{ "brownie32_signed_immediate_32", { CONST_INT }},\
{ "brownie32_unsigned_immediate_32", { CONST_INT }},\
{ "brownie32_signed_immediate_33", { CONST_INT }},\
{ "brownie32_unsigned_immediate_33", { CONST_INT }},\
{ "brownie32_signed_immediate_34", { CONST_INT }},\
{ "brownie32_unsigned_immediate_34", { CONST_INT }},\
{ "brownie32_signed_immediate_35", { CONST_INT }},\
{ "brownie32_unsigned_immediate_35", { CONST_INT }},\
{ "brownie32_signed_immediate_36", { CONST_INT }},\
{ "brownie32_unsigned_immediate_36", { CONST_INT }},\
{ "brownie32_signed_immediate_37", { CONST_INT }},\
{ "brownie32_unsigned_immediate_37", { CONST_INT }},\
{ "brownie32_signed_immediate_38", { CONST_INT }},\
{ "brownie32_unsigned_immediate_38", { CONST_INT }},\
{ "brownie32_signed_immediate_39", { CONST_INT }},\
{ "brownie32_unsigned_immediate_39", { CONST_INT }},\
{ "brownie32_signed_immediate_40", { CONST_INT }},\
{ "brownie32_unsigned_immediate_40", { CONST_INT }},\
{ "brownie32_signed_immediate_41", { CONST_INT }},\
{ "brownie32_unsigned_immediate_41", { CONST_INT }},\
{ "brownie32_signed_immediate_42", { CONST_INT }},\
{ "brownie32_unsigned_immediate_42", { CONST_INT }},\
{ "brownie32_signed_immediate_43", { CONST_INT }},\
{ "brownie32_unsigned_immediate_43", { CONST_INT }},\
{ "brownie32_signed_immediate_44", { CONST_INT }},\
{ "brownie32_unsigned_immediate_44", { CONST_INT }},\
{ "brownie32_signed_immediate_45", { CONST_INT }},\
{ "brownie32_unsigned_immediate_45", { CONST_INT }},\
{ "brownie32_signed_immediate_46", { CONST_INT }},\
{ "brownie32_unsigned_immediate_46", { CONST_INT }},\
{ "brownie32_signed_immediate_47", { CONST_INT }},\
{ "brownie32_unsigned_immediate_47", { CONST_INT }},\
{ "brownie32_signed_immediate_48", { CONST_INT }},\
{ "brownie32_unsigned_immediate_48", { CONST_INT }},\
{ "brownie32_signed_immediate_49", { CONST_INT }},\
{ "brownie32_unsigned_immediate_49", { CONST_INT }},\
{ "brownie32_signed_immediate_50", { CONST_INT }},\
{ "brownie32_unsigned_immediate_50", { CONST_INT }},\
{ "brownie32_signed_immediate_51", { CONST_INT }},\
{ "brownie32_unsigned_immediate_51", { CONST_INT }},\
{ "brownie32_signed_immediate_52", { CONST_INT }},\
{ "brownie32_unsigned_immediate_52", { CONST_INT }},\
{ "brownie32_signed_immediate_53", { CONST_INT }},\
{ "brownie32_unsigned_immediate_53", { CONST_INT }},\
{ "brownie32_signed_immediate_54", { CONST_INT }},\
{ "brownie32_unsigned_immediate_54", { CONST_INT }},\
{ "brownie32_signed_immediate_55", { CONST_INT }},\
{ "brownie32_unsigned_immediate_55", { CONST_INT }},\
{ "brownie32_signed_immediate_56", { CONST_INT }},\
{ "brownie32_unsigned_immediate_56", { CONST_INT }},\
{ "brownie32_signed_immediate_57", { CONST_INT }},\
{ "brownie32_unsigned_immediate_57", { CONST_INT }},\
{ "brownie32_signed_immediate_58", { CONST_INT }},\
{ "brownie32_unsigned_immediate_58", { CONST_INT }},\
{ "brownie32_signed_immediate_59", { CONST_INT }},\
{ "brownie32_unsigned_immediate_59", { CONST_INT }},\
{ "brownie32_signed_immediate_60", { CONST_INT }},\
{ "brownie32_unsigned_immediate_60", { CONST_INT }},\
{ "brownie32_signed_immediate_61", { CONST_INT }},\
{ "brownie32_unsigned_immediate_61", { CONST_INT }},\
{ "brownie32_signed_immediate_62", { CONST_INT }},\
{ "brownie32_unsigned_immediate_62", { CONST_INT }},\
{ "brownie32_signed_immediate_63", { CONST_INT }},\
{ "brownie32_unsigned_immediate_63", { CONST_INT }},\
{ "brownie32_gr_regs_operand", { REG }},\
>>>>)

m4_define(<<<<__MOVQI_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__MOVHI_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__MOVSI_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__MOVDI_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__MOVTI_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__MOVSF_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__MOVDF_RTL__>>>>,<<<<>>>>)

m4_define(<<<<__CONST_OK_FOR_LETTER_P__>>>>,<<<<#define CONST_OK_FOR_LETTER_P(VALUE, C) \
((C) == 'I' ? ((VALUE) >= -32768 && (VALUE) <= 32767 )  \
 : (C) == 'J' ? (VALUE) == 0  \
 : (C) == 'K' ? (VALUE) == 65535  \
 : (C) == 'L' ? ((VALUE) >= 0 && (VALUE) <= 65535 )  \
: 0)
>>>>)

