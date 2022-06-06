; options passed:  -auxbase-strip -O3
; options enabled:  -falign-loops -fargument-alias -fbranch-count-reg
; -fcaller-saves -fcommon -fcprop-registers -fcrossjumping
; -fcse-follow-jumps -fcse-skip-blocks -fdefer-pop -fdelayed-branch
; -fdelete-null-pointer-checks -fearly-inlining
; -feliminate-unused-debug-types -fexpensive-optimizations -ffunction-cse
; -fgcse -fgcse-after-reload -fgcse-lm -fguess-branch-probability -fident
; -fif-conversion -fif-conversion2 -finline-functions
; -finline-functions-called-once -fipa-pure-const -fipa-reference
; -fipa-type-escape -fivopts -fkeep-static-consts -fleading-underscore
; -fmath-errno -fmerge-constants -fmove-loop-invariants
; -foptimize-register-move -foptimize-sibling-calls -fpeephole -fpeephole2
; -freg-struct-return -fregmove -freorder-blocks -freorder-functions
; -frerun-cse-after-loop -fsched-interblock -fsched-spec
; -fsched-stalled-insns-dep -fshow-column -fsplit-ivs-in-unroller
; -fstrict-aliasing -fstrict-overflow -fthread-jumps -ftoplevel-reorder
; -ftrapping-math -ftree-ccp -ftree-ch -ftree-copy-prop -ftree-copyrename
; -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-fre -ftree-loop-im
; -ftree-loop-ivcanon -ftree-loop-optimize -ftree-lrs -ftree-pre
; -ftree-salias -ftree-sink -ftree-sra -ftree-store-ccp
; -ftree-store-copy-prop -ftree-ter -ftree-vect-loop-version -ftree-vrp
; -funit-at-a-time -funswitch-loops -fzero-initialized-in-bss -mquickcall
.text
	.align 2
	.globl	_adpcm_decoder
	.type	_adpcm_decoder, @function
_adpcm_decoder:
;  Function 'adpcm_decoder'; 0 bytes of locals, 10 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-48	; alloc local storage
	sw	0(r5),r16	; save r(r16)
	sw	4(r5),r17	; save r(r17)
	sw	8(r5),r18	; save r(r18)
	sw	12(r5),r19	; save r(r19)
	sw	16(r5),r20	; save r(r20)
	sw	20(r5),r21	; save r(r21)
	sw	24(r5),r22	; save r(r22)
	sw	28(r5),r23	; save r(r23)
	sw	32(r5),r24	; save r(r24)
	sw	36(r5),r25	; save r(r25)
	add	r17,r0,r8
	addi	r7,r0,#0
	elt	r6,r7,r9
	brz	r6,L_adpcm_2
	addi	r15,r0,#7
	add	r12,r0,r7
	add	r13,r0,r7
	add	r19,r0,r7
	add	r8,r0,r7
	add	r16,r0,r7
	add	r11,r0,r7
	addi	r21,r0,#88
	addi	r18,r0,#32767
	add	r25,r0,r15
	addi	r20,r0,#-32768
	addi	r22,r0,#610
	lsoi	r22,r22,#23044
	addi	r23,r0,#610
	lsoi	r23,r23,#23048
	addi	r24,r0,#1
	jp	L_adpcm_4
L_adpcm_32:
	andi	r10,r19,#15
L_adpcm_7:
	llsi	r6,r10,#2
	addi	r7,r0,%hi(_indexTable)
	lsoi	r7,r7,%lo(_indexTable)
	add	r6,r6,r7
	lw	r6,(r6)
	nop
	add	r13,r13,r6
	elt	r6,r13,r11
	brnz	r6,L_adpcm_31
	elt	r6,r21,r13
	brz	r6,L_adpcm_11
	add	r14,r0,r18
	add	r13,r0,r21
L_adpcm_10:
	arsi	r7,r15,#3
	andi	r6,r10,#4
	eeq	r6,r6,r11
	brnz	r6,L_adpcm_13
	add	r7,r7,r15
L_adpcm_13:
	andi	r6,r10,#2
	eeq	r6,r6,r11
	brnz	r6,L_adpcm_15
	arsi	r6,r15,#1
	add	r7,r7,r6
L_adpcm_15:
	andi	r6,r10,#1
	eeq	r6,r6,r11
	brnz	r6,L_adpcm_17
	arsi	r6,r15,#2
	add	r7,r7,r6
L_adpcm_17:
	andi	r6,r10,#8
	eeq	r6,r6,r11
	brnz	r6,L_adpcm_19
	sub	r6,r12,r7
L_adpcm_21:
	add	r7,r0,r6
	elt	r6,r6,r20
	brz	r6,L_adpcm_22
	add	r7,r0,r20
L_adpcm_22:
	add	r12,r0,r7
	elt	r6,r18,r7
	brz	r6,L_adpcm_23
	add	r12,r0,r18
L_adpcm_23:
	andi	r6,r8,#1
	eeq	r6,r6,r11
	brnz	r6,L_adpcm_24
	lsoi	r7,r0,#32768
	add	r6,r12,r7
	andi	r6,r6,#65535
	sw	(r23),r6
	addi	r9,r9,#-1
	eeq	r6,r9,r11
	brnz	r6,L_adpcm_2
L_adpcm_33:
	add	r7,r0,r11
	eneq	r6,r16,r11
	brnz	r6,L_adpcm_28
	add	r7,r0,r24
L_adpcm_28:
	add	r16,r0,r7
	addi	r8,r8,#1
	add	r15,r0,r14
L_adpcm_4:
	eeq	r6,r16,r11
	brz	r6,L_adpcm_32
	lb	r19,(r17)
	nop
	andi	r19,r19,#0x00ff
	addi	r17,r17,#1
	lrsi	r10,r19,#4
	jp	L_adpcm_7
L_adpcm_24:
	lsoi	r7,r0,#32768
	add	r6,r12,r7
	andi	r6,r6,#65535
	sw	(r22),r6
	addi	r9,r9,#-1
	eeq	r6,r9,r11
	brz	r6,L_adpcm_33
	jp	L_adpcm_2
L_adpcm_19:
	add	r6,r7,r12
	jp	L_adpcm_21
L_adpcm_11:
	llsi	r6,r13,#2
	addi	r7,r0,%hi(_stepsizeTable)
	lsoi	r7,r7,%lo(_stepsizeTable)
	add	r6,r6,r7
	lw	r14,(r6)
	nop
	jp	L_adpcm_10
L_adpcm_31:
	add	r14,r0,r25
	add	r13,r0,r11
	jp	L_adpcm_10
L_adpcm_2:
	addi	r6,r0,#0
	lw	r16,0(r5)	; restore r(r16).
	lw	r17,4(r5)	; restore r(r17).
	lw	r18,8(r5)	; restore r(r18).
	lw	r19,12(r5)	; restore r(r19).
	lw	r20,16(r5)	; restore r(r20).
	lw	r21,20(r5)	; restore r(r21).
	lw	r22,24(r5)	; restore r(r22).
	lw	r23,28(r5)	; restore r(r23).
	lw	r24,32(r5)	; restore r(r24).
	lw	r25,36(r5)	; restore r(r25).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_adpcm_decoder, .-_adpcm_decoder
	.align 2
	.globl	_main
	.type	_main, @function
_main:
;  Function 'main'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r14,r0,#0
	add	r15,r0,r14
	add	r11,r0,r14
	addi	r18,r0,%hi(_adpcmData)
	lsoi	r18,r18,%lo(_adpcmData)
	addi	r13,r0,#7
	add	r10,r0,r14
	add	r17,r0,r14
	add	r9,r0,r14
	addi	r20,r0,#88
	addi	r16,r0,#32767
	add	r25,r0,r13
	addi	r19,r0,#-32768
	addi	r23,r0,#610
	lsoi	r23,r23,#23044
	addi	r24,r0,#610
	lsoi	r24,r24,#23048
	addi	r21,r0,#1299
	addi	r22,r0,#1
	jp	L_adpcm_35
L_adpcm_63:
	andi	r8,r17,#15
L_adpcm_38:
	llsi	r6,r8,#2
	addi	r7,r0,%hi(_indexTable)
	lsoi	r7,r7,%lo(_indexTable)
	add	r6,r6,r7
	lw	r6,(r6)
	nop
	add	r10,r10,r6
	elt	r6,r10,r9
	brnz	r6,L_adpcm_62
	elt	r6,r20,r10
	brz	r6,L_adpcm_42
	add	r12,r0,r16
	add	r10,r0,r20
L_adpcm_41:
	arsi	r7,r13,#3
	andi	r6,r8,#4
	eeq	r6,r6,r9
	brnz	r6,L_adpcm_44
	add	r7,r7,r13
L_adpcm_44:
	andi	r6,r8,#2
	eeq	r6,r6,r9
	brnz	r6,L_adpcm_46
	arsi	r6,r13,#1
	add	r7,r7,r6
L_adpcm_46:
	andi	r6,r8,#1
	eeq	r6,r6,r9
	brnz	r6,L_adpcm_48
	arsi	r6,r13,#2
	add	r7,r7,r6
L_adpcm_48:
	andi	r6,r8,#8
	eeq	r6,r6,r9
	brnz	r6,L_adpcm_50
	sub	r6,r11,r7
L_adpcm_52:
	add	r7,r0,r6
	elt	r6,r6,r19
	brz	r6,L_adpcm_53
	add	r7,r0,r19
L_adpcm_53:
	add	r11,r0,r7
	elt	r6,r16,r7
	brz	r6,L_adpcm_54
	add	r11,r0,r16
L_adpcm_54:
	andi	r6,r14,#1
	eeq	r6,r6,r9
	brnz	r6,L_adpcm_55
	lsoi	r7,r0,#32768
	add	r6,r11,r7
	andi	r6,r6,#65535
	sw	(r24),r6
	eeq	r6,r14,r21
	brnz	r6,L_adpcm_58
L_adpcm_64:
	add	r7,r0,r6
	eneq	r6,r15,r6
	brnz	r6,L_adpcm_60
	add	r7,r0,r22
L_adpcm_60:
	add	r15,r0,r7
	addi	r14,r14,#1
	add	r13,r0,r12
L_adpcm_35:
	eeq	r6,r15,r9
	brz	r6,L_adpcm_63
	lb	r17,(r18)
	nop
	andi	r17,r17,#0x00ff
	addi	r18,r18,#1
	lrsi	r8,r17,#4
	jp	L_adpcm_38
L_adpcm_50:
	add	r6,r7,r11
	jp	L_adpcm_52
L_adpcm_55:
	lsoi	r7,r0,#32768
	add	r6,r11,r7
	andi	r6,r6,#65535
	sw	(r23),r6
	eeq	r6,r14,r21
	brz	r6,L_adpcm_64
	jp	L_adpcm_58
L_adpcm_42:
	llsi	r6,r10,#2
	addi	r7,r0,%hi(_stepsizeTable)
	lsoi	r7,r7,%lo(_stepsizeTable)
	add	r6,r6,r7
	lw	r12,(r6)
	nop
	jp	L_adpcm_41
L_adpcm_62:
	add	r12,r0,r25
	add	r10,r0,r9
	jp	L_adpcm_41
L_adpcm_58:
	addi	r6,r0,#0
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_main, .-_main
	.globl	_audioAddressR
	.section	.rodata
	.align 2
	.type	_audioAddressR, @object
	.size	_audioAddressR, 4
_audioAddressR:
	.long	40000004
	.globl	_audioAddressL
	.align 2
	.type	_audioAddressL, @object
	.size	_audioAddressL, 4
_audioAddressL:
	.long	40000008
	.globl	_clockAddress
.data
	.align 2
	.type	_clockAddress, @object
	.size	_clockAddress, 4
_clockAddress:
	.long	50331648
	.globl	_adpcmData
	.align 2
	.type	_adpcmData, @object
	.size	_adpcmData, 650
_adpcmData:
	.byte	59
	.byte	9
	.byte	8
	.byte	89
	.byte	74
	.byte	27
	.byte	-118
	.byte	24
	.byte	40
	.byte	10
	.byte	63
	.byte	77
	.byte	75
	.byte	58
	.byte	17
	.byte	-109
	.byte	-95
	.byte	-116
	.byte	63
	.byte	59
	.byte	59
	.byte	44
	.byte	42
	.byte	33
	.byte	4
	.byte	-111
	.byte	-103
	.byte	-110
	.byte	-94
	.byte	63
	.byte	79
	.byte	42
	.byte	25
	.byte	26
	.byte	58
	.byte	33
	.byte	-74
	.byte	-88
	.byte	29
	.byte	75
	.byte	32
	.byte	-109
	.byte	-78
	.byte	-102
	.byte	78
	.byte	75
	.byte	57
	.byte	0
	.byte	-95
	.byte	9
	.byte	73
	.byte	25
	.byte	-117
	.byte	29
	.byte	91
	.byte	90
	.byte	60
	.byte	43
	.byte	16
	.byte	8
	.byte	44
	.byte	59
	.byte	2
	.byte	-92
	.byte	-88
	.byte	12
	.byte	42
	.byte	74
	.byte	123
	.byte	75
	.byte	-126
	.byte	-61
	.byte	-112
	.byte	75
	.byte	76
	.byte	26
	.byte	8
	.byte	17
	.byte	-111
	.byte	-102
	.byte	61
	.byte	73
	.byte	1
	.byte	-79
	.byte	10
	.byte	122
	.byte	91
	.byte	43
	.byte	24
	.byte	-127
	.byte	-88
	.byte	-115
	.byte	122
	.byte	89
	.byte	43
	.byte	45
	.byte	0
	.byte	-108
	.byte	-77
	.byte	-112
	.byte	9
	.byte	41
	.byte	43
	.byte	76
	.byte	32
	.byte	-110
	.byte	-54
	.byte	47
	.byte	75
	.byte	72
	.byte	0
	.byte	-104
	.byte	10
	.byte	40
	.byte	1
	.byte	-112
	.byte	9
	.byte	11
	.byte	12
	.byte	41
	.byte	65
	.byte	16
	.byte	-84
	.byte	11
	.byte	121
	.byte	74
	.byte	45
	.byte	27
	.byte	57
	.byte	56
	.byte	-126
	.byte	-45
	.byte	-112
	.byte	93
	.byte	77
	.byte	42
	.byte	8
	.byte	0
	.byte	41
	.byte	59
	.byte	75
	.byte	61
	.byte	61
	.byte	59
	.byte	73
	.byte	0
	.byte	-112
	.byte	-95
	.byte	-76
	.byte	-92
	.byte	-120
	.byte	46
	.byte	44
	.byte	42
	.byte	18
	.byte	3
	.byte	12
	.byte	47
	.byte	9
	.byte	-125
	.byte	-126
	.byte	62
	.byte	44
	.byte	26
	.byte	24
	.byte	59
	.byte	91
	.byte	42
	.byte	24
	.byte	41
	.byte	91
	.byte	76
	.byte	25
	.byte	8
	.byte	10
	.byte	63
	.byte	60
	.byte	73
	.byte	32
	.byte	-111
	.byte	-63
	.byte	-112
	.byte	10
	.byte	44
	.byte	75
	.byte	73
	.byte	58
	.byte	44
	.byte	27
	.byte	62
	.byte	74
	.byte	57
	.byte	-127
	.byte	-79
	.byte	-116
	.byte	123
	.byte	74
	.byte	24
	.byte	-120
	.byte	-120
	.byte	16
	.byte	32
	.byte	27
	.byte	63
	.byte	43
	.byte	33
	.byte	-91
	.byte	-78
	.byte	-79
	.byte	-104
	.byte	25
	.byte	1
	.byte	-110
	.byte	29
	.byte	93
	.byte	42
	.byte	24
	.byte	28
	.byte	77
	.byte	41
	.byte	-125
	.byte	-92
	.byte	-119
	.byte	62
	.byte	43
	.byte	42
	.byte	42
	.byte	48
	.byte	-111
	.byte	-101
	.byte	44
	.byte	82
	.byte	-107
	.byte	-86
	.byte	63
	.byte	62
	.byte	58
	.byte	59
	.byte	59
	.byte	17
	.byte	-59
	.byte	-62
	.byte	-118
	.byte	74
	.byte	40
	.byte	-127
	.byte	-96
	.byte	9
	.byte	58
	.byte	42
	.byte	27
	.byte	60
	.byte	106
	.byte	43
	.byte	45
	.byte	42
	.byte	25
	.byte	75
	.byte	107
	.byte	74
	.byte	0
	.byte	-95
	.byte	-127
	.byte	24
	.byte	26
	.byte	29
	.byte	92
	.byte	58
	.byte	24
	.byte	-112
	.byte	58
	.byte	90
	.byte	-118
	.byte	-84
	.byte	74
	.byte	80
	.byte	-109
	.byte	-16
	.byte	-112
	.byte	57
	.byte	57
	.byte	-116
	.byte	11
	.byte	64
	.byte	3
	.byte	-88
	.byte	30
	.byte	91
	.byte	59
	.byte	25
	.byte	-92
	.byte	-91
	.byte	-119
	.byte	45
	.byte	25
	.byte	17
	.byte	-119
	.byte	63
	.byte	74
	.byte	32
	.byte	8
	.byte	-102
	.byte	12
	.byte	58
	.byte	59
	.byte	59
	.byte	35
	.byte	-57
	.byte	-112
	.byte	28
	.byte	61
	.byte	24
	.byte	-110
	.byte	-128
	.byte	92
	.byte	75
	.byte	26
	.byte	0
	.byte	8
	.byte	43
	.byte	76
	.byte	41
	.byte	24
	.byte	26
	.byte	46
	.byte	58
	.byte	34
	.byte	-109
	.byte	-102
	.byte	47
	.byte	29
	.byte	42
	.byte	57
	.byte	40
	.byte	-128
	.byte	-119
	.byte	92
	.byte	59
	.byte	24
	.byte	8
	.byte	90
	.byte	89
	.byte	11
	.byte	31
	.byte	61
	.byte	57
	.byte	24
	.byte	9
	.byte	27
	.byte	41
	.byte	18
	.byte	24
	.byte	77
	.byte	60
	.byte	26
	.byte	-119
	.byte	42
	.byte	123
	.byte	75
	.byte	8
	.byte	-94
	.byte	-110
	.byte	57
	.byte	74
	.byte	45
	.byte	63
	.byte	77
	.byte	58
	.byte	16
	.byte	-127
	.byte	-104
	.byte	29
	.byte	26
	.byte	17
	.byte	-124
	.byte	-120
	.byte	63
	.byte	42
	.byte	16
	.byte	-111
	.byte	-102
	.byte	46
	.byte	75
	.byte	57
	.byte	41
	.byte	42
	.byte	41
	.byte	0
	.byte	-119
	.byte	77
	.byte	61
	.byte	41
	.byte	-127
	.byte	-128
	.byte	44
	.byte	59
	.byte	58
	.byte	58
	.byte	10
	.byte	27
	.byte	122
	.byte	90
	.byte	26
	.byte	45
	.byte	75
	.byte	57
	.byte	-126
	.byte	-94
	.byte	-101
	.byte	30
	.byte	91
	.byte	105
	.byte	1
	.byte	-62
	.byte	-87
	.byte	75
	.byte	64
	.byte	-91
	.byte	-62
	.byte	-87
	.byte	43
	.byte	106
	.byte	58
	.byte	8
	.byte	-112
	.byte	8
	.byte	40
	.byte	8
	.byte	-86
	.byte	63
	.byte	74
	.byte	16
	.byte	9
	.byte	63
	.byte	59
	.byte	1
	.byte	-110
	.byte	10
	.byte	109
	.byte	60
	.byte	59
	.byte	40
	.byte	-109
	.byte	-96
	.byte	60
	.byte	75
	.byte	0
	.byte	-110
	.byte	1
	.byte	0
	.byte	-71
	.byte	63
	.byte	77
	.byte	58
	.byte	8
	.byte	8
	.byte	2
	.byte	-109
	.byte	29
	.byte	93
	.byte	24
	.byte	-127
	.byte	10
	.byte	77
	.byte	24
	.byte	-109
	.byte	-104
	.byte	27
	.byte	18
	.byte	-89
	.byte	-112
	.byte	30
	.byte	42
	.byte	40
	.byte	0
	.byte	-119
	.byte	9
	.byte	59
	.byte	75
	.byte	61
	.byte	76
	.byte	75
	.byte	42
	.byte	24
	.byte	0
	.byte	-104
	.byte	-88
	.byte	17
	.byte	120
	.byte	44
	.byte	45
	.byte	42
	.byte	32
	.byte	-126
	.byte	-119
	.byte	46
	.byte	44
	.byte	25
	.byte	58
	.byte	74
	.byte	26
	.byte	30
	.byte	59
	.byte	48
	.byte	-126
	.byte	11
	.byte	122
	.byte	40
	.byte	-79
	.byte	-56
	.byte	58
	.byte	121
	.byte	26
	.byte	10
	.byte	43
	.byte	122
	.byte	43
	.byte	26
	.byte	0
	.byte	74
	.byte	58
	.byte	-109
	.byte	-60
	.byte	9
	.byte	63
	.byte	28
	.byte	59
	.byte	57
	.byte	0
	.byte	-128
	.byte	108
	.byte	91
	.byte	25
	.byte	-112
	.byte	-128
	.byte	40
	.byte	56
	.byte	9
	.byte	-87
	.byte	-78
	.byte	24
	.byte	124
	.byte	107
	.byte	25
	.byte	0
	.byte	44
	.byte	61
	.byte	24
	.byte	24
	.byte	59
	.byte	60
	.byte	61
	.byte	75
	.byte	58
	.byte	0
	.byte	8
	.byte	62
	.byte	44
	.byte	43
	.byte	75
	.byte	90
	.byte	24
	.byte	-109
	.byte	-61
	.byte	-79
	.byte	29
	.byte	108
	.byte	58
	.byte	24
	.byte	-110
	.byte	-120
	.byte	44
	.byte	42
	.byte	0
	.byte	8
	.byte	44
	.byte	26
	.byte	24
	.byte	41
	.byte	91
	.byte	41
	.byte	-90
	.byte	-60
	.byte	-95
	.byte	27
	.byte	77
	.byte	42
	.byte	-110
	.byte	-76
	.byte	-111
	.byte	41
	.byte	58
	.byte	30
	.byte	63
	.byte	59
	.byte	58
	.byte	41
	.byte	9
	.byte	16
	.byte	-108
	.byte	-95
	.byte	-118
	.byte	41
	.byte	2
	.byte	-119
	.byte	59
	.byte	73
	.byte	26
	.byte	31
	.byte	31
	.byte	43
	.byte	91
	.byte	91
	.byte	58
	.byte	24
	.byte	-128
	.byte	9
	.byte	43
	.byte	1
	.byte	-110
	.byte	91
	.byte	123
	.byte	24
	.byte	-78
	.byte	-56
	.byte	62
	.byte	72
	.byte	3
	.byte	-78
	.byte	-115
	.byte	61
	.byte	40
	.byte	-128
	.byte	-112
	.byte	-128
	.byte	17
	.byte	27
	.byte	94
	.byte	74
	.byte	40
	.byte	-112
	.byte	-87
	.byte	24
	.byte	35
	.byte	-95
	.byte	-113
	.byte	94
	.byte	57
	.byte	1
	.byte	-77
	.section	.rodata
	.align 2
	.type	_stepsizeTable, @object
	.size	_stepsizeTable, 356
_stepsizeTable:
	.long	7
	.long	8
	.long	9
	.long	10
	.long	11
	.long	12
	.long	13
	.long	14
	.long	16
	.long	17
	.long	19
	.long	21
	.long	23
	.long	25
	.long	28
	.long	31
	.long	34
	.long	37
	.long	41
	.long	45
	.long	50
	.long	55
	.long	60
	.long	66
	.long	73
	.long	80
	.long	88
	.long	97
	.long	107
	.long	118
	.long	130
	.long	143
	.long	157
	.long	173
	.long	190
	.long	209
	.long	230
	.long	253
	.long	279
	.long	307
	.long	337
	.long	371
	.long	408
	.long	449
	.long	494
	.long	544
	.long	598
	.long	658
	.long	724
	.long	796
	.long	876
	.long	963
	.long	1060
	.long	1166
	.long	1282
	.long	1411
	.long	1552
	.long	1707
	.long	1878
	.long	2066
	.long	2272
	.long	2499
	.long	2749
	.long	3024
	.long	3327
	.long	3660
	.long	4026
	.long	4428
	.long	4871
	.long	5358
	.long	5894
	.long	6484
	.long	7132
	.long	7845
	.long	8630
	.long	9493
	.long	10442
	.long	11487
	.long	12635
	.long	13899
	.long	15289
	.long	16818
	.long	18500
	.long	20350
	.long	22385
	.long	24623
	.long	27086
	.long	29794
	.long	32767
	.align 2
	.type	_indexTable, @object
	.size	_indexTable, 64
_indexTable:
	.long	-1
	.long	-1
	.long	-1
	.long	-1
	.long	2
	.long	4
	.long	6
	.long	8
	.long	-1
	.long	-1
	.long	-1
	.long	-1
	.long	2
	.long	4
	.long	6
	.long	8
	.ident	"GCC: (GNU) 4.2.2"
; options passed:  -auxbase-strip -O3
; options enabled:  -falign-loops -fargument-alias -fbranch-count-reg
; -fcaller-saves -fcommon -fcprop-registers -fcrossjumping
; -fcse-follow-jumps -fcse-skip-blocks -fdefer-pop -fdelayed-branch
; -fdelete-null-pointer-checks -fearly-inlining
; -feliminate-unused-debug-types -fexpensive-optimizations -ffunction-cse
; -fgcse -fgcse-after-reload -fgcse-lm -fguess-branch-probability -fident
; -fif-conversion -fif-conversion2 -finline-functions
; -finline-functions-called-once -fipa-pure-const -fipa-reference
; -fipa-type-escape -fivopts -fkeep-static-consts -fleading-underscore
; -fmath-errno -fmerge-constants -fmove-loop-invariants
; -foptimize-register-move -foptimize-sibling-calls -fpeephole -fpeephole2
; -freg-struct-return -fregmove -freorder-blocks -freorder-functions
; -frerun-cse-after-loop -fsched-interblock -fsched-spec
; -fsched-stalled-insns-dep -fshow-column -fsplit-ivs-in-unroller
; -fstrict-aliasing -fstrict-overflow -fthread-jumps -ftoplevel-reorder
; -ftrapping-math -ftree-ccp -ftree-ch -ftree-copy-prop -ftree-copyrename
; -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-fre -ftree-loop-im
; -ftree-loop-ivcanon -ftree-loop-optimize -ftree-lrs -ftree-pre
; -ftree-salias -ftree-sink -ftree-sra -ftree-store-ccp
; -ftree-store-copy-prop -ftree-ter -ftree-vect-loop-version -ftree-vrp
; -funit-at-a-time -funswitch-loops -fzero-initialized-in-bss -mquickcall
.text
	.align 2
	.globl	_t_print
	.type	_t_print, @function
_t_print:
;  Function 't_print'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	lb	r7,(r8)
	nop
	andi	r7,r7,#0x00ff
	addi	r9,r0,#0
	eeq	r6,r7,r9
	brnz	r6,L_lib_lcd_dlxsim_2
	addi	r10,r0,#512
	lsoi	r10,r10,#0
L_lib_lcd_dlxsim_5:
	sw	(r10),r7
	addi	r8,r8,#1
	lb	r7,(r8)
	nop
	andi	r7,r7,#0x00ff
	eneq	r6,r7,r9
	brnz	r6,L_lib_lcd_dlxsim_5
L_lib_lcd_dlxsim_2:
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_print, .-_t_print
	.align 2
	.globl	_checkbuffer
	.type	_checkbuffer, @function
_checkbuffer:
;  Function 'checkbuffer'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_checkbuffer, .-_checkbuffer
	.align 2
	.globl	_getbytes
	.type	_getbytes, @function
_getbytes:
;  Function 'getbytes'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_getbytes, .-_getbytes
	.align 2
	.globl	_sendcommand
	.type	_sendcommand, @function
_sendcommand:
;  Function 'sendcommand'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_sendcommand, .-_sendcommand
	.align 2
	.globl	_t_cursor
	.type	_t_cursor, @function
_t_cursor:
;  Function 't_cursor'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_cursor, .-_t_cursor
	.align 2
	.globl	_t_enable
	.type	_t_enable, @function
_t_enable:
;  Function 't_enable'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_enable, .-_t_enable
	.align 2
	.globl	_g_print
	.type	_g_print, @function
_g_print:
;  Function 'g_print'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_print, .-_g_print
	.align 2
	.globl	_g_drawrect
	.type	_g_drawrect, @function
_g_drawrect:
;  Function 'g_drawrect'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_drawrect, .-_g_drawrect
	.align 2
	.globl	_g_drawline
	.type	_g_drawline, @function
_g_drawline:
;  Function 'g_drawline'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_drawline, .-_g_drawline
	.align 2
	.globl	_g_makebar
	.type	_g_makebar, @function
_g_makebar:
;  Function 'g_makebar'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_makebar, .-_g_makebar
	.align 2
	.globl	_g_setbar
	.type	_g_setbar, @function
_g_setbar:
;  Function 'g_setbar'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_setbar, .-_g_setbar
	.align 2
	.globl	_g_makeswitch
	.type	_g_makeswitch, @function
_g_makeswitch:
;  Function 'g_makeswitch'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_makeswitch, .-_g_makeswitch
	.align 2
	.globl	_g_makemenubutton
	.type	_g_makemenubutton, @function
_g_makemenubutton:
;  Function 'g_makemenubutton'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_makemenubutton, .-_g_makemenubutton
	.align 2
	.globl	_g_makeradiogroup
	.type	_g_makeradiogroup, @function
_g_makeradiogroup:
;  Function 'g_makeradiogroup'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_makeradiogroup, .-_g_makeradiogroup
	.align 2
	.globl	_d_clear
	.type	_d_clear, @function
_d_clear:
;  Function 'd_clear'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_d_clear, .-_d_clear
	.align 2
	.globl	_t_printInt
	.type	_t_printInt, @function
_t_printInt:
;  Function 't_printInt'; 20 bytes of locals, 1 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-68	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	addi	r16,r4,#-20
	add	r9,r0,r16
	jpl	_intToStr
	lb	r7,-20(r4)
	nop
	andi	r7,r7,#0x00ff
	addi	r8,r0,#0
	eeq	r6,r7,r8
	brnz	r6,L_lib_lcd_dlxsim_37
	add	r9,r0,r16
	addi	r10,r0,#512
	lsoi	r10,r10,#0
L_lib_lcd_dlxsim_39:
	sw	(r10),r7
	addi	r9,r9,#1
	lb	r7,(r9)
	nop
	andi	r7,r7,#0x00ff
	eneq	r6,r7,r8
	brnz	r6,L_lib_lcd_dlxsim_39
L_lib_lcd_dlxsim_37:
	addi	r6,r0,#0
	lw	r16,32(r5)	; restore r(r16).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_printInt, .-_t_printInt
	.section	.rodata.str1.4,"aMS",@progbits,1
	.align 2
LC_lib_lcd_dlxsim_0:
	.string	"0x"
.text
	.align 2
	.globl	_t_printHex
	.type	_t_printHex, @function
_t_printHex:
;  Function 't_printHex'; 12 bytes of locals, 1 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-60	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	add	r6,r0,r9
	addi	r16,r4,#-10
	add	r9,r0,r16
	add	r10,r0,r6
	jpl	_intToHexStr
	addi	r7,r0,%hi(LC_lib_lcd_dlxsim_0)
	lsoi	r7,r7,%lo(LC_lib_lcd_dlxsim_0)
	addi	r6,r0,#48
	addi	r9,r0,#512
	lsoi	r9,r9,#0
	addi	r10,r0,#0
L_lib_lcd_dlxsim_43:
	sw	(r9),r6
	addi	r7,r7,#1
	lb	r6,(r7)
	nop
	andi	r6,r6,#0x00ff
	eneq	r8,r6,r10
	brnz	r8,L_lib_lcd_dlxsim_43
	lb	r7,-10(r4)
	nop
	andi	r7,r7,#0x00ff
	eeq	r6,r7,r10
	brnz	r6,L_lib_lcd_dlxsim_45
	add	r9,r0,r16
	addi	r10,r0,#512
	lsoi	r10,r10,#0
L_lib_lcd_dlxsim_47:
	sw	(r10),r7
	addi	r9,r9,#1
	lb	r7,(r9)
	nop
	andi	r7,r7,#0x00ff
	eneq	r6,r7,r8
	brnz	r6,L_lib_lcd_dlxsim_47
L_lib_lcd_dlxsim_45:
	addi	r6,r0,#0
	lw	r16,32(r5)	; restore r(r16).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_printHex, .-_t_printHex
	.ident	"GCC: (GNU) 4.2.2"
; options passed:  -auxbase-strip -O3
; options enabled:  -falign-loops -fargument-alias -fbranch-count-reg
; -fcaller-saves -fcommon -fcprop-registers -fcrossjumping
; -fcse-follow-jumps -fcse-skip-blocks -fdefer-pop -fdelayed-branch
; -fdelete-null-pointer-checks -fearly-inlining
; -feliminate-unused-debug-types -fexpensive-optimizations -ffunction-cse
; -fgcse -fgcse-after-reload -fgcse-lm -fguess-branch-probability -fident
; -fif-conversion -fif-conversion2 -finline-functions
; -finline-functions-called-once -fipa-pure-const -fipa-reference
; -fipa-type-escape -fivopts -fkeep-static-consts -fleading-underscore
; -fmath-errno -fmerge-constants -fmove-loop-invariants
; -foptimize-register-move -foptimize-sibling-calls -fpeephole -fpeephole2
; -freg-struct-return -fregmove -freorder-blocks -freorder-functions
; -frerun-cse-after-loop -fsched-interblock -fsched-spec
; -fsched-stalled-insns-dep -fshow-column -fsplit-ivs-in-unroller
; -fstrict-aliasing -fstrict-overflow -fthread-jumps -ftoplevel-reorder
; -ftrapping-math -ftree-ccp -ftree-ch -ftree-copy-prop -ftree-copyrename
; -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-fre -ftree-loop-im
; -ftree-loop-ivcanon -ftree-loop-optimize -ftree-lrs -ftree-pre
; -ftree-salias -ftree-sink -ftree-sra -ftree-store-ccp
; -ftree-store-copy-prop -ftree-ter -ftree-vect-loop-version -ftree-vrp
; -funit-at-a-time -funswitch-loops -fzero-initialized-in-bss -mquickcall
.text
	.align 2
	.globl	_storeByte
	.type	_storeByte, @function
_storeByte:
;  Function 'storeByte'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#-4
	and	r11,r8,r6
	lw	r10,(r11)
	nop
	sub	r6,r0,r8
	subi	r6,r6,#1
	andi	r6,r6,#3
	llsi	r7,r6,#3
	addi	r6,r0,#255
	lls	r6,r6,r7
	sub	r6,r0,r6
	subi	r6,r6,#1
	and	r7,r6,r10
	andi	r6,r8,#3
	sub	r6,r0,r6
	subi	r6,r6,#1
	llsi	r6,r6,#3
	lls	r6,r9,r6
	or	r6,r7,r6
	sw	(r11),r6
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_storeByte, .-_storeByte
	.align 2
	.globl	_storeShort
	.type	_storeShort, @function
_storeShort:
;  Function 'storeShort'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r0,#-4
	and	r10,r8,r6
	lw	r7,(r10)
	nop
	andi	r6,r8,#1
	brnz	r6,L_loadStoreByte_4
	lsoi	r6,r0,#65535
	jp	L_loadStoreByte_6
L_loadStoreByte_4:
	addi	r6,r0,#-1
	lsoi	r6,r6,#0
L_loadStoreByte_6:
	and	r7,r6,r7
	andi	r6,r8,#2
	arsi	r6,r6,#1
	sub	r6,r0,r6
	subi	r6,r6,#1
	llsi	r6,r6,#4
	ars	r6,r9,r6
	or	r6,r7,r6
	sw	(r10),r6
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_storeShort, .-_storeShort
	.align 2
	.globl	_loadByteUnsigned
	.type	_loadByteUnsigned, @function
_loadByteUnsigned:
;  Function 'loadByteUnsigned'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	add	r7,r0,r8
	addi	r8,r0,#-4
	and	r6,r7,r8
	lw	r8,(r6)
	nop
	andi	r6,r7,#3
	sub	r6,r0,r6
	subi	r6,r6,#1
	llsi	r6,r6,#3
	ars	r6,r8,r6
	andi	r6,r6,#0x00ff
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_loadByteUnsigned, .-_loadByteUnsigned
	.align 2
	.globl	_loadByteSigned
	.type	_loadByteSigned, @function
_loadByteSigned:
;  Function 'loadByteSigned'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	add	r7,r0,r8
	addi	r8,r0,#-4
	and	r6,r7,r8
	lw	r8,(r6)
	nop
	andi	r6,r7,#3
	sub	r6,r0,r6
	subi	r6,r6,#1
	llsi	r6,r6,#3
	ars	r6,r8,r6
	exbw	r6,r6
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_loadByteSigned, .-_loadByteSigned
	.ident	"GCC: (GNU) 4.2.2"
; options passed:  -auxbase-strip -O3
; options enabled:  -falign-loops -fargument-alias -fbranch-count-reg
; -fcaller-saves -fcommon -fcprop-registers -fcrossjumping
; -fcse-follow-jumps -fcse-skip-blocks -fdefer-pop -fdelayed-branch
; -fdelete-null-pointer-checks -fearly-inlining
; -feliminate-unused-debug-types -fexpensive-optimizations -ffunction-cse
; -fgcse -fgcse-after-reload -fgcse-lm -fguess-branch-probability -fident
; -fif-conversion -fif-conversion2 -finline-functions
; -finline-functions-called-once -fipa-pure-const -fipa-reference
; -fipa-type-escape -fivopts -fkeep-static-consts -fleading-underscore
; -fmath-errno -fmerge-constants -fmove-loop-invariants
; -foptimize-register-move -foptimize-sibling-calls -fpeephole -fpeephole2
; -freg-struct-return -fregmove -freorder-blocks -freorder-functions
; -frerun-cse-after-loop -fsched-interblock -fsched-spec
; -fsched-stalled-insns-dep -fshow-column -fsplit-ivs-in-unroller
; -fstrict-aliasing -fstrict-overflow -fthread-jumps -ftoplevel-reorder
; -ftrapping-math -ftree-ccp -ftree-ch -ftree-copy-prop -ftree-copyrename
; -ftree-dce -ftree-dominator-opts -ftree-dse -ftree-fre -ftree-loop-im
; -ftree-loop-ivcanon -ftree-loop-optimize -ftree-lrs -ftree-pre
; -ftree-salias -ftree-sink -ftree-sra -ftree-store-ccp
; -ftree-store-copy-prop -ftree-ter -ftree-vect-loop-version -ftree-vrp
; -funit-at-a-time -funswitch-loops -fzero-initialized-in-bss -mquickcall
.text
	.align 2
	.globl	_strlen
	.type	_strlen, @function
_strlen:
;  Function 'strlen'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	lb	r6,(r8)
	nop
	andi	r6,r6,#0x00ff
	addi	r7,r0,#0
	eneq	r6,r6,r7
	brz	r6,L_string_4
	add	r9,r0,r7
L_string_5:
	addi	r7,r7,#1
	add	r6,r8,r7
	lb	r6,(r6)
	nop
	andi	r6,r6,#0x00ff
	eneq	r6,r6,r9
	brnz	r6,L_string_5
L_string_4:
	add	r6,r0,r7
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strlen, .-_strlen
	.align 2
	.globl	_strcmp
	.type	_strcmp, @function
_strcmp:
;  Function 'strcmp'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	lb	r10,(r9)
	nop
	andi	r10,r10,#0x00ff
	lb	r7,(r8)
	nop
	andi	r7,r7,#0x00ff
	addi	r11,r0,#0
	eeq	r6,r7,r11
	brnz	r6,L_string_10
	eeq	r6,r10,r11
	brnz	r6,L_string_12
	elt	r6,r7,r10
	brnz	r6,L_string_14
	elt	r6,r10,r7
	brnz	r6,L_string_12
	addi	r8,r8,#1
	addi	r9,r9,#1
	jp	L_string_17
L_string_24:
	eneq	r6,r10,r11
	brz	r6,L_string_12
	elt	r6,r7,r10
	brnz	r6,L_string_14
	elt	r6,r10,r7
	brnz	r6,L_string_12
L_string_17:
	lb	r6,(r8)
	nop
	andi	r6,r6,#0x00ff
	addi	r8,r8,#1
	lb	r10,(r9)
	nop
	andi	r10,r10,#0x00ff
	addi	r9,r9,#1
	add	r7,r0,r6
	eeq	r6,r6,r11
	brz	r6,L_string_24
L_string_10:
	addi	r7,r0,#0
	eneq	r6,r10,r7
	brnz	r6,L_string_14
	add	r6,r0,r7
	jp	L_string_22
L_string_12:
	addi	r6,r0,#1
	jp	L_string_22
L_string_14:
	addi	r6,r0,#-1
L_string_22:
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strcmp, .-_strcmp
	.align 2
	.globl	_strncmp
	.type	_strncmp, @function
_strncmp:
;  Function 'strncmp'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	lb	r13,(r9)
	nop
	lb	r8,(r8)
	nop
	andi	r8,r8,#0x00ff
	addi	r11,r0,#0
	eeq	r6,r8,r11
	brz	r6,L_string_41
L_string_26:
	addi	r6,r0,#0
L_string_31:
	eeq	r9,r6,r10
	brnz	r9,L_string_36
	eeq	r6,r8,r9
	brz	r6,L_string_42
	andi	r6,r13,#0x00ff
	eeq	r6,r6,r9
	brz	r6,L_string_32
L_string_36:
	addi	r6,r0,#0
	jp	L_string_35
L_string_41:
	andi	r7,r13,#0x00ff
	eeq	r6,r7,r11
	brnz	r6,L_string_26
	addi	r12,r0,#1
	elt	r6,r12,r10
	brz	r6,L_string_43
	elt	r6,r8,r7
	brnz	r6,L_string_32
	add	r9,r0,r11
	elt	r6,r7,r8
	brz	r6,L_string_34
	add	r9,r0,r12
L_string_34:
	add	r6,r0,r9
	jp	L_string_35
L_string_42:
	addi	r6,r0,#1
	jp	L_string_35
L_string_32:
	addi	r6,r0,#-1
	jp	L_string_35
L_string_43:
	add	r6,r0,r12
	jp	L_string_31
L_string_35:
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strncmp, .-_strncmp
	.align 2
	.globl	_tolower
	.type	_tolower, @function
_tolower:
;  Function 'tolower'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r8,#-65
	addi	r7,r0,#25
	eltu	r6,r7,r6
	brnz	r6,L_string_45
	addi	r8,r8,#32
L_string_45:
	add	r6,r0,r8
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_tolower, .-_tolower
	.align 2
	.globl	_toupper
	.type	_toupper, @function
_toupper:
;  Function 'toupper'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r6,r8,#-97
	addi	r7,r0,#25
	eltu	r6,r7,r6
	brnz	r6,L_string_49
	addi	r8,r8,#-32
L_string_49:
	add	r6,r0,r8
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_toupper, .-_toupper
	.align 2
	.globl	_isdigit
	.type	_isdigit, @function
_isdigit:
;  Function 'isdigit'; 0 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-8	; alloc local storage
	addi	r9,r0,#0
	addi	r6,r8,#-48
	addi	r7,r0,#9
	eltu	r6,r7,r6
	brnz	r6,L_string_53
	addi	r9,r0,#1
L_string_53:
	add	r6,r0,r9
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_isdigit, .-_isdigit
	.align 2
	.globl	_strncpy
	.type	_strncpy, @function
_strncpy:
;  Function 'strncpy'; 0 bytes of locals, 5 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-64	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	sw	40(r5),r18	; save r(r18)
	sw	44(r5),r19	; save r(r19)
	sw	48(r5),r20	; save r(r20)
	add	r20,r0,r8
	add	r19,r0,r10
	lb	r18,(r9)
	nop
	andi	r18,r18,#0x00ff
	addi	r6,r0,#0
	eeq	r6,r18,r6
	brnz	r6,L_string_56
	addi	r7,r0,#1
	elt	r6,r7,r10
	brz	r6,L_string_56
	add	r16,r0,r7
	jp	L_string_59
L_string_63:
	add	r8,r0,r17
L_string_59:
	addi	r17,r8,#1
	add	r9,r0,r18
	jpl	_storeByte
	addi	r16,r16,#1
	eeq	r6,r16,r19
	brz	r6,L_string_63
	add	r6,r20,r19
	addi	r20,r6,#-1
L_string_56:
	add	r8,r0,r20
	addi	r9,r0,#0
	jpl	_storeByte
	add	r6,r0,r20
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
	lw	r18,40(r5)	; restore r(r18).
	lw	r19,44(r5)	; restore r(r19).
	lw	r20,48(r5)	; restore r(r20).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strncpy, .-_strncpy
	.align 2
	.globl	_strcpy
	.type	_strcpy, @function
_strcpy:
;  Function 'strcpy'; 0 bytes of locals, 3 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-56	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	sw	40(r5),r18	; save r(r18)
	add	r17,r0,r8
	lb	r18,(r9)
	nop
	andi	r18,r18,#0x00ff
	addi	r9,r0,#0
	eeq	r6,r18,r9
	brnz	r6,L_string_65
L_string_68:
	addi	r16,r17,#1
	add	r8,r0,r17
	add	r9,r0,r18
	jpl	_storeByte
	add	r17,r0,r16
	addi	r16,r17,#1
	add	r8,r0,r17
	add	r9,r0,r18
	jpl	_storeByte
	add	r17,r0,r16
	jp	L_string_68
L_string_65:
	jpl	_storeByte
	add	r6,r0,r17
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
	lw	r18,40(r5)	; restore r(r18).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strcpy, .-_strcpy
	.align 2
	.globl	_strncat
	.type	_strncat, @function
_strncat:
;  Function 'strncat'; 0 bytes of locals, 5 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-64	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	sw	40(r5),r18	; save r(r18)
	sw	44(r5),r19	; save r(r19)
	sw	48(r5),r20	; save r(r20)
	add	r20,r0,r10
	addi	r16,r8,#1
	lb	r6,(r8)
	nop
	andi	r6,r6,#0x00ff
	addi	r7,r0,#0
	eeq	r6,r6,r7
	brnz	r6,L_string_70
L_string_79:
	lb	r6,(r16)
	nop
	andi	r6,r6,#0x00ff
	addi	r16,r16,#1
	eneq	r6,r6,r7
	brnz	r6,L_string_79
L_string_70:
	lb	r19,(r9)
	nop
	andi	r19,r19,#0x00ff
	addi	r6,r0,#0
	eeq	r6,r19,r6
	brnz	r6,L_string_72
	addi	r7,r0,#1
	elt	r6,r7,r20
	brz	r6,L_string_72
	add	r8,r0,r16
	add	r17,r0,r7
	jp	L_string_75
L_string_81:
	add	r8,r0,r18
L_string_75:
	addi	r18,r8,#1
	add	r9,r0,r19
	jpl	_storeByte
	addi	r17,r17,#1
	eeq	r6,r17,r20
	brz	r6,L_string_81
	add	r6,r16,r20
	addi	r16,r6,#-1
L_string_72:
	add	r8,r0,r16
	addi	r9,r0,#0
	jpl	_storeByte
	add	r6,r0,r16
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
	lw	r18,40(r5)	; restore r(r18).
	lw	r19,44(r5)	; restore r(r19).
	lw	r20,48(r5)	; restore r(r20).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strncat, .-_strncat
	.align 2
	.globl	_strcat
	.type	_strcat, @function
_strcat:
;  Function 'strcat'; 0 bytes of locals, 2 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-48	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	add	r6,r0,r8
	addi	r8,r8,#1
	lb	r6,(r6)
	nop
	andi	r6,r6,#0x00ff
	addi	r7,r0,#0
	eeq	r6,r6,r7
	brnz	r6,L_string_83
L_string_88:
	lb	r6,(r8)
	nop
	andi	r6,r6,#0x00ff
	addi	r8,r8,#1
	eneq	r6,r6,r7
	brnz	r6,L_string_88
L_string_83:
	lb	r17,(r9)
	nop
	andi	r17,r17,#0x00ff
	addi	r9,r0,#0
	eeq	r6,r17,r9
	brnz	r6,L_string_85
L_string_90:
	addi	r16,r8,#1
	add	r9,r0,r17
	jpl	_storeByte
	add	r8,r0,r16
	addi	r16,r8,#1
	add	r9,r0,r17
	jpl	_storeByte
	add	r8,r0,r16
	jp	L_string_90
L_string_85:
	jpl	_storeByte
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_strcat, .-_strcat
	.align 2
	.globl	_intToHexStr
	.type	_intToHexStr, @function
_intToHexStr:
;  Function 'intToHexStr'; 12 bytes of locals, 5 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-76	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	sw	40(r5),r18	; save r(r18)
	sw	44(r5),r19	; save r(r19)
	sw	48(r5),r20	; save r(r20)
	add	r16,r0,r8
	add	r20,r0,r9
	add	r17,r0,r10
	addi	r7,r0,#0
	eeq	r6,r8,r7
	brz	r6,L_string_190
	eneq	r6,r10,r7
	brz	r6,L_string_167
	elt	r6,r7,r10
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_95:
	addi	r18,r4,#-10
	add	r8,r0,r18
	jpl	_storeByte
L_string_96:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,L_string_191
	eneq	r6,r17,r7
	brz	r6,L_string_192
	addi	r7,r0,#1
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_106:
	addi	r8,r4,#-9
	jpl	_storeByte
L_string_107:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,L_string_193
	eneq	r6,r17,r7
	brz	r6,L_string_194
	addi	r7,r0,#2
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_116:
	addi	r8,r4,#-8
	jpl	_storeByte
L_string_117:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,L_string_195
	eneq	r6,r17,r7
	brz	r6,L_string_196
	addi	r7,r0,#3
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_126:
	addi	r8,r4,#-7
	jpl	_storeByte
L_string_127:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,L_string_197
	eneq	r6,r17,r7
	brz	r6,L_string_198
	addi	r7,r0,#4
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_136:
	addi	r8,r4,#-6
	jpl	_storeByte
L_string_137:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,L_string_199
	eneq	r6,r17,r7
	brz	r6,L_string_200
	addi	r7,r0,#5
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_146:
	addi	r8,r4,#-5
	jpl	_storeByte
L_string_147:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,L_string_201
	eneq	r6,r17,r7
	brz	r6,L_string_202
	addi	r7,r0,#6
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_156:
	addi	r8,r4,#-4
	jpl	_storeByte
L_string_157:
	arsi	r8,r16,#4
	addi	r7,r0,#0
	eneq	r6,r8,r7
	brnz	r6,L_string_163
	eneq	r6,r17,r7
	brz	r6,L_string_203
	addi	r7,r0,#7
	elt	r6,r7,r17
	brz	r6,L_string_167
	addi	r9,r0,#48
L_string_169:
	addi	r8,r4,#-3
	jpl	_storeByte
L_string_172:
	addi	r19,r0,#8
	addi	r8,r0,#7
L_string_173:
	add	r16,r18,r8
	add	r17,r0,r20
	addi	r18,r4,#-11
L_string_176:
	add	r8,r0,r17
	lb	r9,(r16)
	nop
	andi	r9,r9,#0x00ff
	jpl	_storeByte
	addi	r16,r16,#-1
	addi	r17,r17,#1
	eneq	r6,r16,r18
	brnz	r6,L_string_176
	add	r6,r0,r19
	jp	L_string_175
L_string_190:
	andi	r9,r8,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_97
	addi	r9,r9,#48
	jp	L_string_95
L_string_191:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_108
	addi	r9,r9,#48
	jp	L_string_106
L_string_193:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_118
	addi	r9,r9,#48
	jp	L_string_116
L_string_195:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_128
	addi	r9,r9,#48
	jp	L_string_126
L_string_197:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_138
	addi	r9,r9,#48
	jp	L_string_136
L_string_199:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_148
	addi	r9,r9,#48
	jp	L_string_146
L_string_201:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_158
	addi	r9,r9,#48
	jp	L_string_156
L_string_163:
	andi	r9,r8,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,L_string_170
	addi	r9,r9,#48
	jp	L_string_169
L_string_97:
	addi	r18,r4,#-10
	add	r8,r0,r18
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_96
L_string_167:
	add	r19,r0,r7
L_string_101:
	addi	r8,r19,#-1
	addi	r7,r0,#0
	elt	r6,r8,r7
	brnz	r6,L_string_204
	addi	r18,r4,#-10
	jp	L_string_173
L_string_108:
	addi	r8,r4,#-9
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_107
L_string_118:
	addi	r8,r4,#-8
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_117
L_string_128:
	addi	r8,r4,#-7
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_127
L_string_138:
	addi	r8,r4,#-6
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_137
L_string_148:
	addi	r8,r4,#-5
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_147
L_string_158:
	addi	r8,r4,#-4
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_157
L_string_170:
	addi	r8,r4,#-3
	addi	r9,r9,#55
	jpl	_storeByte
	jp	L_string_172
L_string_204:
	add	r6,r0,r7
	jp	L_string_175
L_string_194:
	addi	r19,r0,#2
	jp	L_string_101
L_string_192:
	addi	r19,r0,#1
	jp	L_string_101
L_string_198:
	addi	r19,r0,#4
	jp	L_string_101
L_string_196:
	addi	r19,r0,#3
	jp	L_string_101
L_string_202:
	addi	r19,r0,#6
	jp	L_string_101
L_string_200:
	addi	r19,r0,#5
	jp	L_string_101
L_string_203:
	addi	r19,r0,#7
	jp	L_string_101
L_string_175:
	add	r8,r20,r6
	addi	r9,r0,#0
	jpl	_storeByte
	addi	r6,r0,#0
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
	lw	r18,40(r5)	; restore r(r18).
	lw	r19,44(r5)	; restore r(r19).
	lw	r20,48(r5)	; restore r(r20).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_intToHexStr, .-_intToHexStr
	.align 2
	.globl	_intToStr
	.type	_intToStr, @function
_intToStr:
;  Function 'intToStr'; 32 bytes of locals, 7 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-104	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	sw	40(r5),r18	; save r(r18)
	sw	44(r5),r19	; save r(r19)
	sw	48(r5),r20	; save r(r20)
	sw	52(r5),r21	; save r(r21)
	sw	56(r5),r22	; save r(r22)
	add	r16,r0,r8
	add	r22,r0,r9
	addi	r7,r0,#0
	elt	r6,r8,r7
	brnz	r6,L_string_221
	eeq	r6,r8,r7
	brnz	r6,L_string_209
	add	r21,r0,r7
L_string_208:
	addi	r17,r0,#0
	addi	r20,r4,#-32
	addi	r18,r0,#10
	add	r19,r0,r17
L_string_211:
	mod	r6,r16,r18
	add	r8,r20,r17
	addi	r9,r6,#48
	jpl	_storeByte
	div	r16,r16,r18
	addi	r17,r17,#1
	eneq	r6,r16,r19
	brnz	r6,L_string_211
	addi	r19,r17,#-1
	add	r16,r20,r19
	add	r17,r22,r21
	addi	r18,r4,#-33
L_string_214:
	add	r8,r0,r17
	lb	r9,(r16)
	nop
	andi	r9,r9,#0x00ff
	jpl	_storeByte
	addi	r16,r16,#-1
	addi	r17,r17,#1
	eneq	r6,r16,r18
	brnz	r6,L_string_214
	addi	r6,r21,#1
	add	r6,r6,r19
	jp	L_string_212
L_string_209:
	add	r8,r0,r9
	addi	r9,r0,#48
	jpl	_storeByte
	addi	r6,r0,#1
	jp	L_string_212
L_string_221:
	sub	r16,r0,r8
	add	r8,r0,r9
	addi	r9,r0,#45
	jpl	_storeByte
	addi	r21,r0,#1
	jp	L_string_208
L_string_212:
	add	r8,r22,r6
	addi	r9,r0,#0
	jpl	_storeByte
	addi	r6,r0,#0
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
	lw	r18,40(r5)	; restore r(r18).
	lw	r19,44(r5)	; restore r(r19).
	lw	r20,48(r5)	; restore r(r20).
	lw	r21,52(r5)	; restore r(r21).
	lw	r22,56(r5)	; restore r(r22).
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_intToStr, .-_intToStr
	.ident	"GCC: (GNU) 4.2.2"
