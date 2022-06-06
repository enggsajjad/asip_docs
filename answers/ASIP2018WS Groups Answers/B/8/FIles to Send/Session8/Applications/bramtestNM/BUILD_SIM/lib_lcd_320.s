; options passed:  -auxbase-strip -O0
; options enabled:  -falign-loops -fargument-alias -fbranch-count-reg
; -fcommon -fearly-inlining -feliminate-unused-debug-types -ffunction-cse
; -fgcse-lm -fident -finline-functions-called-once -fivopts
; -fkeep-static-consts -fleading-underscore -fmath-errno
; -fmove-loop-invariants -fpeephole -freg-struct-return -fsched-interblock
; -fsched-spec -fsched-stalled-insns-dep -fshow-column
; -fsplit-ivs-in-unroller -ftoplevel-reorder -ftrapping-math -ftree-loop-im
; -ftree-loop-ivcanon -ftree-loop-optimize -ftree-vect-loop-version
; -fzero-initialized-in-bss -mquickcall
.text
	.align 2
	.globl	_wait
	.type	_wait, @function
_wait:
;  Function 'wait'; 8 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-16	; alloc local storage
	sw	8(r4),r8
	addi	r6,r0,#0
	sw	-4(r4),r6
.L2:
	addi	r6,r0,#0x0
	sb	-5(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r7,8(r4)
	nop
	eeq	r6,r6,r7
	brnz	r6,.L3
	addi	r6,r0,#0x1
	sb	-5(r4),r6
.L3:
	lw	r6,-4(r4)
	nop
	addi	r6,r6,#1
	sw	-4(r4),r6
	lb	r7,-5(r4)
	nop
	andi	r7,r7,#0x00ff
	addi	r6,r0,#0
	eneq	r6,r7,r6
	brnz	r6,.L2
	lw	r6,-4(r4)
	nop
	addi	r6,r6,#-1
	sw	-4(r4),r6
	lw	r6,-4(r4)
	nop
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_wait, .-_wait
	.align 2
	.globl	_getack
	.type	_getack, @function
_getack:
;  Function 'getack'; 12 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-20	; alloc local storage
	sw	8(r4),r8
	addi	r6,r0,#512
	lsoi	r6,r6,#0
	sw	-4(r4),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#0
	sw	(r7),r6
	lw	r6,8(r4)
	nop
	addi	r6,r6,#1
	sw	8(r4),r6
	lw	r7,-4(r4)
	nop
	lw	r6,8(r4)
	nop
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#1
	sw	(r7),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-8(r4),r6
	lw	r7,-8(r4)
	nop
	addi	r6,r0,#15
	eneq	r6,r7,r6
	brnz	r6,.L7
	addi	r6,r0,#1
	sw	-12(r4),r6
	jp	.L9
.L7:
	addi	r6,r0,#0
	sw	-12(r4),r6
.L9:
	lw	r6,-12(r4)
	nop
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_getack, .-_getack
	.align 2
	.globl	_checkbuffer
	.type	_checkbuffer, @function
_checkbuffer:
;  Function 'checkbuffer'; 36 bytes of locals, 0 regs to save, 0 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-44	; alloc local storage
	addi	r6,r0,#0
	sw	-32(r4),r6
	addi	r6,r0,#0
	sw	-24(r4),r6
	addi	r6,r0,#0
	sw	-20(r4),r6
	addi	r6,r0,#0
	sw	-16(r4),r6
	addi	r6,r0,#0
	sw	-12(r4),r6
	addi	r6,r0,#222
	sw	-8(r4),r6
	addi	r6,r0,#512
	lsoi	r6,r6,#0
	sw	-4(r4),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#4
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	lw	r6,-8(r4)
	nop
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#18
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#1
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#73
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#92
	sw	(r7),r6
	addi	r6,r0,#-1
	sw	-28(r4),r6
	jp	.L12
.L13:
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#0
	sw	(r7),r6
	lw	r6,-8(r4)
	nop
	addi	r7,r6,#1
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#6
	sw	(r7),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-32(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-32(r4),r6
	lw	r6,-32(r4)
	nop
	sw	-28(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-24(r4),r6
	lw	r7,-28(r4)
	nop
	lw	r6,-24(r4)
	nop
	add	r6,r7,r6
	sw	-28(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-20(r4),r6
	lw	r7,-28(r4)
	nop
	lw	r6,-20(r4)
	nop
	add	r6,r7,r6
	sw	-28(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-16(r4),r6
	lw	r7,-28(r4)
	nop
	lw	r6,-16(r4)
	nop
	add	r6,r7,r6
	sw	-28(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-12(r4),r6
	lw	r6,-28(r4)
	nop
	addi	r7,r0,#-32768
	lsoi	r7,r7,#255
	and	r7,r6,r7
	sw	-36(r4),r7
	addi	r6,r0,#0
	lw	r7,-36(r4)
	nop
	elt	r6,r7,r6
	brz	r6,.L14
	lw	r6,-36(r4)
	nop
	addi	r6,r6,#-1
	sw	-36(r4),r6
	lw	r7,-36(r4)
	nop
	addi	r6,r0,#-256
	or	r7,r7,r6
	sw	-36(r4),r7
	lw	r7,-36(r4)
	nop
	addi	r7,r7,#1
	sw	-36(r4),r7
.L14:
	lw	r6,-36(r4)
	nop
	sw	-28(r4),r6
	lw	r6,-28(r4)
	nop
	lw	r7,-12(r4)
	nop
	eeq	r6,r6,r7
	brnz	r6,.L12
	addi	r6,r0,#-1
	sw	-28(r4),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#4
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	lw	r6,-8(r4)
	nop
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#18
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#1
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#82
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#101
	sw	(r7),r6
.L12:
	lw	r6,-28(r4)
	nop
	addi	r7,r0,#-1
	eeq	r6,r6,r7
	brnz	r6,.L13
	lw	r6,-20(r4)
	nop
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
;  Function 'getbytes'; 28 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-68	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	addi	r6,r0,#0
	sw	-28(r4),r6
	addi	r6,r0,#0
	sw	-16(r4),r6
	addi	r6,r0,#0
	sw	-12(r4),r6
	addi	r6,r0,#222
	sw	-8(r4),r6
	addi	r6,r0,#512
	lsoi	r6,r6,#0
	sw	-4(r4),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#4
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	lw	r6,-8(r4)
	nop
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#18
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#1
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#83
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#102
	sw	(r7),r6
	addi	r6,r0,#-1
	sw	-20(r4),r6
	jp	.L19
.L20:
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#0
	sw	(r7),r6
	lw	r6,-8(r4)
	nop
	addi	r7,r6,#1
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lw	r6,12(r4)
	nop
	addi	r7,r6,#4
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-24(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-24(r4),r6
	lw	r6,-24(r4)
	nop
	sw	-20(r4),r6
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-16(r4),r6
	lw	r7,-20(r4)
	nop
	lw	r6,-16(r4)
	nop
	add	r6,r7,r6
	sw	-20(r4),r6
	jp	.L21
.L22:
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-24(r4),r6
	lw	r6,-28(r4)
	nop
	add	r7,r0,r6
	lw	r6,8(r4)
	nop
	add	r6,r7,r6
	add	r8,r0,r6
	lw	r9,-24(r4)
	nop
	jpl	_storeByte
	lw	r6,-28(r4)
	nop
	addi	r6,r6,#1
	sw	-28(r4),r6
	lw	r7,-20(r4)
	nop
	lw	r6,-24(r4)
	nop
	add	r6,r7,r6
	sw	-20(r4),r6
.L21:
	lw	r6,-28(r4)
	nop
	lw	r7,12(r4)
	nop
	eneq	r6,r6,r7
	brnz	r6,.L22
	lw	r6,-4(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-12(r4),r6
	lw	r6,-20(r4)
	nop
	andi	r6,r6,#255
	sw	-20(r4),r6
	lw	r7,-20(r4)
	nop
	lw	r6,-12(r4)
	nop
	eeq	r6,r7,r6
	brnz	r6,.L19
	addi	r6,r0,#-1
	sw	-20(r4),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#4
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	lw	r6,-8(r4)
	nop
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#18
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#1
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#82
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#101
	sw	(r7),r6
.L19:
	lw	r6,-20(r4)
	nop
	addi	r7,r0,#-1
	eeq	r6,r6,r7
	brnz	r6,.L20
	lw	r6,-28(r4)
	nop
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
;  Function 'sendcommand'; 32 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-72	; alloc local storage
	sb	8(r4),r8
	sb	12(r4),r9
	sw	16(r4),r10
	sw	20(r4),r11
	sw	24(r4),r12
	sw	28(r4),r13
	sw	32(r4),r14
	addi	r6,r0,#512
	lsoi	r6,r6,#0
	sw	-4(r4),r6
.L28:
	lw	r6,16(r4)
	nop
	sw	-20(r4),r6
	lw	r6,20(r4)
	nop
	sw	-16(r4),r6
	lw	r6,24(r4)
	nop
	sw	-12(r4),r6
	lw	r6,28(r4)
	nop
	sw	-8(r4),r6
	lw	r7,24(r4)
	nop
	lw	r6,28(r4)
	nop
	add	r6,r7,r6
	addi	r7,r6,#6
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lw	r7,-4(r4)
	nop
	lw	r6,32(r4)
	nop
	sw	(r7),r6
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#17
	sw	(r7),r6
	lw	r7,24(r4)
	nop
	lw	r6,28(r4)
	nop
	add	r6,r7,r6
	addi	r7,r6,#3
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lw	r7,-4(r4)
	nop
	addi	r6,r0,#27
	sw	(r7),r6
	lb	r7,8(r4)
	nop
	andi	r7,r7,#0x00ff
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lb	r7,12(r4)
	nop
	andi	r7,r7,#0x00ff
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	lw	r7,24(r4)
	nop
	lw	r6,28(r4)
	nop
	add	r6,r7,r6
	addi	r7,r6,#47
	lb	r6,8(r4)
	nop
	andi	r6,r6,#0x00ff
	add	r7,r7,r6
	lb	r6,12(r4)
	nop
	andi	r6,r6,#0x00ff
	add	r6,r7,r6
	sw	-28(r4),r6
	jp	.L29
.L30:
	lw	r6,-20(r4)
	nop
	lw	r6,(r6)
	nop
	sw	-24(r4),r6
	lw	r6,-20(r4)
	nop
	addi	r6,r6,#4
	sw	-20(r4),r6
	lw	r7,-4(r4)
	nop
	lw	r6,-24(r4)
	nop
	sw	(r7),r6
	lw	r7,-28(r4)
	nop
	lw	r6,-24(r4)
	nop
	add	r6,r7,r6
	sw	-28(r4),r6
.L29:
	lw	r6,-12(r4)
	nop
	addi	r6,r6,#-1
	sw	-12(r4),r6
	lw	r7,-12(r4)
	nop
	addi	r6,r0,#-1
	eneq	r6,r7,r6
	brnz	r6,.L30
	jp	.L32
.L33:
	lw	r6,-16(r4)
	nop
	lb	r6,(r6)
	nop
	andi	r6,r6,#0x00ff
	sw	-24(r4),r6
	lw	r6,-16(r4)
	nop
	addi	r6,r6,#1
	sw	-16(r4),r6
	lw	r7,-4(r4)
	nop
	lw	r6,-24(r4)
	nop
	sw	(r7),r6
	lw	r7,-28(r4)
	nop
	lw	r6,-24(r4)
	nop
	add	r6,r7,r6
	sw	-28(r4),r6
.L32:
	lw	r6,-8(r4)
	nop
	addi	r6,r6,#-1
	sw	-8(r4),r6
	lw	r7,-8(r4)
	nop
	addi	r6,r0,#-1
	eneq	r6,r7,r6
	brnz	r6,.L33
	lw	r6,-28(r4)
	nop
	addi	r7,r0,#-32768
	lsoi	r7,r7,#255
	and	r7,r6,r7
	sw	-32(r4),r7
	addi	r6,r0,#0
	lw	r7,-32(r4)
	nop
	elt	r6,r7,r6
	brz	r6,.L35
	lw	r6,-32(r4)
	nop
	addi	r6,r6,#-1
	sw	-32(r4),r6
	lw	r7,-32(r4)
	nop
	addi	r6,r0,#-256
	or	r7,r7,r6
	sw	-32(r4),r7
	lw	r7,-32(r4)
	nop
	addi	r7,r7,#1
	sw	-32(r4),r7
.L35:
	lw	r7,-32(r4)
	nop
	lw	r6,-4(r4)
	nop
	sw	(r6),r7
	addi	r8,r0,#10000
	jpl	_wait
	lw	r8,32(r4)
	nop
	jpl	_getack
	add	r7,r0,r6
	addi	r6,r0,#0
	eneq	r6,r7,r6
	brnz	r6,.L28
	addi	r8,r0,#10000
	jpl	_wait
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_sendcommand, .-_sendcommand
	.align 2
	.globl	_g_print
	.type	_g_print, @function
_g_print:
;  Function 'g_print'; 16 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-56	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	sw	16(r4),r10
	lw	r6,12(r4)
	nop
	sw	-16(r4),r6
	lw	r6,12(r4)
	nop
	arsi	r6,r6,#8
	sw	-12(r4),r6
	lw	r6,16(r4)
	nop
	sw	-8(r4),r6
	lw	r6,16(r4)
	nop
	arsi	r6,r6,#8
	sw	-4(r4),r6
	lw	r8,8(r4)
	nop
	jpl	_strlen
	addi	r7,r6,#1
	addi	r6,r4,#-16
	addi	r8,r0,#0x5a
	addi	r9,r0,#0x4c
	add	r10,r0,r6
	lw	r11,8(r4)
	nop
	addi	r12,r0,#4
	add	r13,r0,r7
	addi	r14,r0,#222
	jpl	_sendcommand
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
;  Function 'g_drawrect'; 32 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-72	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	sw	16(r4),r10
	sw	20(r4),r11
	lw	r6,8(r4)
	nop
	sw	-32(r4),r6
	lw	r6,8(r4)
	nop
	arsi	r6,r6,#8
	sw	-28(r4),r6
	lw	r6,12(r4)
	nop
	sw	-24(r4),r6
	lw	r6,12(r4)
	nop
	arsi	r6,r6,#8
	sw	-20(r4),r6
	lw	r6,16(r4)
	nop
	sw	-16(r4),r6
	lw	r6,16(r4)
	nop
	arsi	r6,r6,#8
	sw	-12(r4),r6
	lw	r6,20(r4)
	nop
	sw	-8(r4),r6
	lw	r6,20(r4)
	nop
	arsi	r6,r6,#8
	sw	-4(r4),r6
	addi	r6,r4,#-32
	addi	r8,r0,#0x47
	addi	r9,r0,#0x52
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#8
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
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
;  Function 'g_drawline'; 32 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-72	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	sw	16(r4),r10
	sw	20(r4),r11
	lw	r6,8(r4)
	nop
	sw	-32(r4),r6
	lw	r6,8(r4)
	nop
	arsi	r6,r6,#8
	sw	-28(r4),r6
	lw	r6,12(r4)
	nop
	sw	-24(r4),r6
	lw	r6,12(r4)
	nop
	arsi	r6,r6,#8
	sw	-20(r4),r6
	lw	r6,16(r4)
	nop
	sw	-16(r4),r6
	lw	r6,16(r4)
	nop
	arsi	r6,r6,#8
	sw	-12(r4),r6
	lw	r6,20(r4)
	nop
	sw	-8(r4),r6
	lw	r6,20(r4)
	nop
	arsi	r6,r6,#8
	sw	-4(r4),r6
	addi	r6,r4,#-32
	addi	r8,r0,#0x47
	addi	r9,r0,#0x44
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#8
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_drawline, .-_g_drawline
.data
	.align 2
	.type	_barcounter1675, @object
	.size	_barcounter1675, 4
_barcounter1675:
	.long	1
.text
	.align 2
	.globl	_g_makebar
	.type	_g_makebar, @function
_g_makebar:
;  Function 'g_makebar'; 56 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-96	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	sw	16(r4),r10
	sw	20(r4),r11
	sw	24(r4),r12
	sw	28(r4),r13
	sw	32(r4),r14
	sw	36(r4),r15
	addi	r6,r0,%hi(_barcounter1675)
	lsoi	r6,r6,%lo(_barcounter1675)
	lw	r7,(r6)
	nop
	addi	r6,r0,#31
	elt	r6,r6,r7
	brnz	r6,.L45
	addi	r6,r0,%hi(_barcounter1675)
	lsoi	r6,r6,%lo(_barcounter1675)
	lw	r6,(r6)
	nop
	sw	-52(r4),r6
	lw	r6,8(r4)
	nop
	sw	-48(r4),r6
	lw	r6,8(r4)
	nop
	arsi	r6,r6,#8
	sw	-44(r4),r6
	lw	r6,12(r4)
	nop
	sw	-40(r4),r6
	lw	r6,12(r4)
	nop
	arsi	r6,r6,#8
	sw	-36(r4),r6
	lw	r6,16(r4)
	nop
	sw	-32(r4),r6
	lw	r6,16(r4)
	nop
	arsi	r6,r6,#8
	sw	-28(r4),r6
	lw	r6,20(r4)
	nop
	sw	-24(r4),r6
	lw	r6,20(r4)
	nop
	arsi	r6,r6,#8
	sw	-20(r4),r6
	lw	r6,24(r4)
	nop
	sw	-16(r4),r6
	lw	r6,28(r4)
	nop
	sw	-12(r4),r6
	lw	r6,36(r4)
	nop
	sw	-8(r4),r6
	lw	r6,40(r4)
	nop
	sw	-4(r4),r6
	addi	r6,r4,#-52
	addi	r8,r0,#0x42
	addi	r9,r0,#0x52
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#13
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	lw	r7,44(r4)
	nop
	addi	r6,r0,#0
	eeq	r6,r7,r6
	brnz	r6,.L47
	addi	r6,r0,%hi(_barcounter1675)
	lsoi	r6,r6,%lo(_barcounter1675)
	lw	r6,(r6)
	nop
	sw	-52(r4),r6
	addi	r6,r4,#-52
	addi	r8,r0,#0x41
	addi	r9,r0,#0x42
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#1
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
.L47:
	addi	r6,r0,%hi(_barcounter1675)
	lsoi	r6,r6,%lo(_barcounter1675)
	lw	r6,(r6)
	nop
	sw	-52(r4),r6
	addi	r7,r6,#1
	addi	r6,r0,%hi(_barcounter1675)
	lsoi	r6,r6,%lo(_barcounter1675)
	sw	(r6),r7
	lw	r6,32(r4)
	nop
	sw	-48(r4),r6
	addi	r6,r4,#-52
	addi	r8,r0,#0x42
	addi	r9,r0,#0x41
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#2
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r6,r0,%hi(_barcounter1675)
	lsoi	r6,r6,%lo(_barcounter1675)
	lw	r6,(r6)
	nop
	addi	r6,r6,#-1
	sw	-56(r4),r6
	jp	.L49
.L45:
	addi	r6,r0,#-1
	sw	-56(r4),r6
.L49:
	lw	r6,-56(r4)
	nop
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
;  Function 'g_setbar'; 8 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-48	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	lw	r6,8(r4)
	nop
	sw	-8(r4),r6
	lw	r6,12(r4)
	nop
	sw	-4(r4),r6
	addi	r6,r4,#-8
	addi	r8,r0,#0x42
	addi	r9,r0,#0x41
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#2
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
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
;  Function 'g_makeswitch'; 40 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-80	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	sw	16(r4),r10
	sw	20(r4),r11
	sw	24(r4),r12
	sw	28(r4),r13
	sw	32(r4),r14
	lw	r6,12(r4)
	nop
	sw	-40(r4),r6
	lw	r6,12(r4)
	nop
	arsi	r6,r6,#8
	sw	-36(r4),r6
	lw	r6,16(r4)
	nop
	sw	-32(r4),r6
	lw	r6,16(r4)
	nop
	arsi	r6,r6,#8
	sw	-28(r4),r6
	lw	r6,20(r4)
	nop
	sw	-24(r4),r6
	lw	r6,20(r4)
	nop
	arsi	r6,r6,#8
	sw	-20(r4),r6
	lw	r6,24(r4)
	nop
	sw	-16(r4),r6
	lw	r6,24(r4)
	nop
	arsi	r6,r6,#8
	sw	-12(r4),r6
	lw	r6,28(r4)
	nop
	sw	-8(r4),r6
	lw	r6,32(r4)
	nop
	sw	-4(r4),r6
	lw	r8,8(r4)
	nop
	jpl	_strlen
	addi	r7,r6,#1
	addi	r6,r4,#-40
	addi	r8,r0,#0x41
	addi	r9,r0,#0x4b
	add	r10,r0,r6
	lw	r11,8(r4)
	nop
	addi	r12,r0,#10
	add	r13,r0,r7
	addi	r14,r0,#222
	jpl	_sendcommand
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
;  Function 'g_makemenubutton'; 44 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-84	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	sw	16(r4),r10
	sw	20(r4),r11
	sw	24(r4),r12
	sw	28(r4),r13
	sw	32(r4),r14
	sw	36(r4),r15
	lw	r6,12(r4)
	nop
	sw	-44(r4),r6
	lw	r6,12(r4)
	nop
	arsi	r6,r6,#8
	sw	-40(r4),r6
	lw	r6,16(r4)
	nop
	sw	-36(r4),r6
	lw	r6,16(r4)
	nop
	arsi	r6,r6,#8
	sw	-32(r4),r6
	lw	r6,20(r4)
	nop
	sw	-28(r4),r6
	lw	r6,20(r4)
	nop
	arsi	r6,r6,#8
	sw	-24(r4),r6
	lw	r6,24(r4)
	nop
	sw	-20(r4),r6
	lw	r6,24(r4)
	nop
	arsi	r6,r6,#8
	sw	-16(r4),r6
	lw	r6,28(r4)
	nop
	sw	-12(r4),r6
	lw	r6,32(r4)
	nop
	sw	-8(r4),r6
	lw	r6,36(r4)
	nop
	sw	-4(r4),r6
	lw	r8,8(r4)
	nop
	jpl	_strlen
	addi	r7,r6,#1
	addi	r6,r4,#-44
	addi	r8,r0,#0x41
	addi	r9,r0,#0x4d
	add	r10,r0,r6
	lw	r11,8(r4)
	nop
	addi	r12,r0,#11
	add	r13,r0,r7
	addi	r14,r0,#222
	jpl	_sendcommand
	lw	r7,40(r4)
	nop
	addi	r6,r0,#0
	elt	r6,r6,r7
	brz	r6,.L56
	addi	r6,r4,#40
	addi	r8,r0,#0x4e
	addi	r9,r0,#0x59
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#1
	addi	r13,r0,#0
	addi	r14,r0,#111
	jpl	_sendcommand
.L56:
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
;  Function 'g_makeradiogroup'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	sw	8(r4),r8
	addi	r8,r0,#0x41
	addi	r9,r0,#0x52
	addi	r6,r4,#8
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#1
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_g_makeradiogroup, .-_g_makeradiogroup
	.align 2
	.globl	_t_print
	.type	_t_print, @function
_t_print:
;  Function 't_print'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	sw	8(r4),r8
	lw	r8,8(r4)
	nop
	jpl	_strlen
	addi	r8,r0,#0x5a
	addi	r9,r0,#0x54
	addi	r10,r0,#0
	lw	r11,8(r4)
	nop
	addi	r12,r0,#0
	add	r13,r0,r6
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r8,r0,#8000
	jpl	_wait
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_print, .-_t_print
	.align 2
	.globl	_t_printInt
	.type	_t_printInt, @function
_t_printInt:
;  Function 't_printInt'; 20 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-60	; alloc local storage
	sw	8(r4),r8
	addi	r6,r4,#-20
	lw	r8,8(r4)
	nop
	add	r9,r0,r6
	jpl	_intToStr
	addi	r6,r4,#-20
	add	r8,r0,r6
	jpl	_t_print
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_printInt, .-_t_printInt
	.section	.rodata
	.align 2
.LC0:
	.string	"0x"
.text
	.align 2
	.globl	_t_printHex
	.type	_t_printHex, @function
_t_printHex:
;  Function 't_printHex'; 12 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-52	; alloc local storage
	sw	8(r4),r8
	sw	12(r4),r9
	addi	r6,r4,#-10
	lw	r8,8(r4)
	nop
	add	r9,r0,r6
	lw	r10,12(r4)
	nop
	jpl	_intToHexStr
	addi	r8,r0,%hi(.LC0)
	lsoi	r8,r8,%lo(.LC0)
	jpl	_t_print
	addi	r6,r4,#-10
	add	r8,r0,r6
	jpl	_t_print
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_printHex, .-_t_printHex
	.align 2
	.globl	_t_cursor
	.type	_t_cursor, @function
_t_cursor:
;  Function 't_cursor'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	sw	8(r4),r8
	addi	r8,r0,#0x54
	addi	r9,r0,#0x43
	addi	r6,r4,#8
	add	r10,r0,r6
	addi	r11,r0,#0
	addi	r12,r0,#1
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
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
;  Function 't_enable'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	sw	8(r4),r8
	lw	r6,8(r4)
	nop
	addi	r7,r0,#0
	eeq	r6,r6,r7
	brnz	r6,.L70
	addi	r8,r0,#0x54
	addi	r9,r0,#0x45
	addi	r10,r0,#0
	addi	r11,r0,#0
	addi	r12,r0,#0
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	jp	.L72
.L70:
	addi	r8,r0,#0x54
	addi	r9,r0,#0x41
	addi	r10,r0,#0
	addi	r11,r0,#0
	addi	r12,r0,#0
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
.L72:
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_enable, .-_t_enable
	.align 2
	.globl	_t_saveCursorPosition
	.type	_t_saveCursorPosition, @function
_t_saveCursorPosition:
;  Function 't_saveCursorPosition'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	addi	r8,r0,#0x54
	addi	r9,r0,#0x53
	addi	r10,r0,#0
	addi	r11,r0,#0
	addi	r12,r0,#0
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_saveCursorPosition, .-_t_saveCursorPosition
	.align 2
	.globl	_t_restoreLastSavedCursorPosition
	.type	_t_restoreLastSavedCursorPosition, @function
_t_restoreLastSavedCursorPosition:
;  Function 't_restoreLastSavedCursorPosition'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	addi	r8,r0,#0x54
	addi	r9,r0,#0x52
	addi	r10,r0,#0
	addi	r11,r0,#0
	addi	r12,r0,#0
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_t_restoreLastSavedCursorPosition, .-_t_restoreLastSavedCursorPosition
	.align 2
	.globl	_d_clear
	.type	_d_clear, @function
_d_clear:
;  Function 'd_clear'; 0 bytes of locals, 0 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-40	; alloc local storage
	addi	r8,r0,#0x44
	addi	r9,r0,#0x4c
	addi	r10,r0,#0
	addi	r11,r0,#0
	addi	r12,r0,#0
	addi	r13,r0,#0
	addi	r14,r0,#222
	jpl	_sendcommand
	addi	r8,r0,#38
	lsoi	r8,r8,#9632
	jpl	_wait
	addi	r6,r0,#0
	nop
	lw	r3,4(r4)	; pop LinkRegister(r3)
	addi	r5,r4,#8	; StackPointer = FramePointer+8
	lw	r4,(r4)		; restore FramePointer
	jpr	r3		; return
	.size	_d_clear, .-_d_clear
	.ident	"GCC: (GNU) 4.2.2"
