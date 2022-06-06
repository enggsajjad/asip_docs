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
; -fsched-stalled-insns-dep -fschedule-insns -fschedule-insns2
; -fshow-column -fsplit-ivs-in-unroller -fstrict-aliasing -fstrict-overflow
; -fthread-jumps -ftoplevel-reorder -ftrapping-math -ftree-ccp -ftree-ch
; -ftree-copy-prop -ftree-copyrename -ftree-dce -ftree-dominator-opts
; -ftree-dse -ftree-fre -ftree-loop-im -ftree-loop-ivcanon
; -ftree-loop-optimize -ftree-lrs -ftree-pre -ftree-salias -ftree-sink
; -ftree-sra -ftree-store-ccp -ftree-store-copy-prop -ftree-ter
; -ftree-vect-loop-version -ftree-vrp -funit-at-a-time -funswitch-loops
; -fzero-initialized-in-bss -mquickcall
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
	add	r11,r0,r8
	addi	r8,r0,#0
	lb	r6,(r11)
	nop
	andi	r6,r6,#0x00ff
	eneq	r7,r6,r8
	brz	r7,.L9
	add	r9,r0,r8
	add	r10,r0,r8
.L5:
	addi	r9,r9,#1
	add	r6,r11,r9
	lb	r7,(r6)
	nop
	andi	r7,r7,#0x00ff
	eneq	r8,r7,r10
	brnz	r8,.L5
	jp	.L4
.L9:
	add	r9,r0,r8
.L4:
	add	r6,r0,r9
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
	lb	r7,(r8)
	nop
	andi	r7,r7,#0x00ff
	addi	r11,r0,#0
	lb	r10,(r9)
	nop
	andi	r10,r10,#0x00ff
	eeq	r6,r7,r11
	brnz	r6,.L11
	eeq	r6,r10,r11
	brnz	r6,.L13
	elt	r6,r7,r10
	brnz	r6,.L15
	elt	r6,r10,r7
	brnz	r6,.L13
	addi	r8,r8,#1
	addi	r9,r9,#1
	add	r12,r0,r11
	jp	.L18
.L25:
	eneq	r6,r10,r12
	brz	r6,.L13
	elt	r6,r7,r10
	brnz	r6,.L15
	brnz	r11,.L13
.L18:
	lb	r6,(r8)
	nop
	andi	r6,r6,#0x00ff
	lb	r10,(r9)
	nop
	andi	r10,r10,#0x00ff
	add	r7,r0,r6
	elt	r11,r10,r6
	addi	r9,r9,#1
	addi	r8,r8,#1
	eeq	r6,r6,r12
	brz	r6,.L25
.L11:
	addi	r7,r0,#0
	eneq	r6,r10,r7
	brnz	r6,.L15
	add	r6,r0,r7
	jp	.L23
.L13:
	addi	r6,r0,#1
	jp	.L23
.L15:
	addi	r6,r0,#-1
.L23:
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
	lb	r8,(r8)
	nop
	andi	r8,r8,#0x00ff
	addi	r11,r0,#0
	lb	r13,(r9)
	nop
	eeq	r6,r8,r11
	brz	r6,.L42
.L27:
	addi	r6,r0,#0
.L32:
	eeq	r9,r6,r10
	brnz	r9,.L37
	eeq	r6,r8,r9
	brz	r6,.L43
	andi	r6,r13,#0x00ff
	eeq	r7,r6,r9
	brz	r7,.L33
.L37:
	addi	r6,r0,#0
	jp	.L36
.L42:
	andi	r7,r13,#0x00ff
	eeq	r6,r7,r11
	brnz	r6,.L27
	addi	r12,r0,#1
	elt	r6,r12,r10
	brz	r6,.L44
	elt	r6,r8,r7
	brnz	r6,.L33
	elt	r6,r7,r8
	add	r7,r0,r11
	brz	r6,.L35
	add	r7,r0,r12
.L35:
	add	r6,r0,r7
	jp	.L36
.L43:
	addi	r6,r0,#1
	jp	.L36
.L33:
	addi	r6,r0,#-1
	jp	.L36
.L44:
	add	r6,r0,r12
	jp	.L32
.L36:
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
	add	r9,r0,r8
	addi	r6,r8,#-65
	addi	r7,r0,#25
	eltu	r8,r7,r6
	brnz	r8,.L46
	addi	r9,r9,#32
.L46:
	add	r6,r0,r9
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
	add	r9,r0,r8
	addi	r6,r8,#-97
	addi	r7,r0,#25
	eltu	r8,r7,r6
	brnz	r8,.L50
	addi	r9,r9,#-32
.L50:
	add	r6,r0,r9
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
	addi	r6,r8,#-48
	addi	r7,r0,#9
	eltu	r8,r7,r6
	addi	r6,r0,#0
	brnz	r8,.L54
	addi	r6,r0,#1
.L54:
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
	lb	r19,(r9)
	nop
	andi	r19,r19,#0x00ff
	addi	r6,r0,#0
	add	r20,r0,r8
	add	r18,r0,r10
	eeq	r7,r19,r6
	brnz	r7,.L57
	addi	r7,r0,#1
	elt	r6,r7,r10
	brz	r6,.L57
	add	r17,r0,r7
	add	r16,r0,r8
.L60:
	add	r8,r0,r16
	add	r9,r0,r19
	jpl	_storeByte
	addi	r17,r17,#1
	addi	r16,r16,#1
	eeq	r6,r17,r18
	brz	r6,.L60
	add	r6,r20,r18
	addi	r20,r6,#-1
.L57:
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
;  Function 'strcpy'; 0 bytes of locals, 2 regs to save, 32 byte of out. args. size.
	sw	-4(r5),r3	; push LinkRegister(r3)
	sw	-8(r5),r4	; push FrameRegister(r4)
	addi	r4, r5,#-8	; FramePtr = StackPtr-8
	addi	r5,r5,#-48	; alloc local storage
	sw	32(r5),r16	; save r(r16)
	sw	36(r5),r17	; save r(r17)
	lb	r17,(r9)
	nop
	andi	r17,r17,#0x00ff
	add	r16,r0,r8
	addi	r9,r0,#0
	eeq	r6,r17,r9
	brnz	r6,.L65
.L68:
	addi	r6,r16,#1
	add	r8,r0,r16
	add	r9,r0,r17
	add	r16,r0,r6
	jpl	_storeByte
	addi	r6,r16,#1
	add	r8,r0,r16
	add	r9,r0,r17
	add	r16,r0,r6
	jpl	_storeByte
	jp	.L68
.L65:
	jpl	_storeByte
	add	r6,r0,r16
	lw	r16,32(r5)	; restore r(r16).
	lw	r17,36(r5)	; restore r(r17).
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
	lb	r7,(r8)
	nop
	andi	r7,r7,#0x00ff
	add	r20,r0,r10
	addi	r17,r8,#1
	addi	r10,r0,#0
	eeq	r6,r7,r10
	brnz	r6,.L70
.L79:
	lb	r6,(r17)
	nop
	andi	r6,r6,#0x00ff
	addi	r17,r17,#1
	eneq	r8,r6,r10
	brnz	r8,.L79
.L70:
	lb	r19,(r9)
	nop
	andi	r19,r19,#0x00ff
	addi	r6,r0,#0
	eeq	r7,r19,r6
	brnz	r7,.L72
	addi	r7,r0,#1
	elt	r6,r7,r20
	brz	r6,.L72
	add	r18,r0,r7
	add	r16,r0,r17
.L75:
	add	r8,r0,r16
	add	r9,r0,r19
	jpl	_storeByte
	addi	r18,r18,#1
	addi	r16,r16,#1
	eeq	r6,r18,r20
	brz	r6,.L75
	add	r6,r17,r20
	addi	r17,r6,#-1
.L72:
	add	r8,r0,r17
	addi	r9,r0,#0
	jpl	_storeByte
	add	r6,r0,r17
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
	lb	r7,(r8)
	nop
	andi	r7,r7,#0x00ff
	addi	r10,r0,#0
	addi	r16,r6,#1
	eeq	r8,r7,r10
	brnz	r8,.L82
.L87:
	lb	r6,(r16)
	nop
	andi	r6,r6,#0x00ff
	addi	r16,r16,#1
	eneq	r8,r6,r10
	brnz	r8,.L87
.L82:
	lb	r17,(r9)
	nop
	andi	r17,r17,#0x00ff
	addi	r9,r0,#0
	eeq	r6,r17,r9
	brnz	r6,.L84
.L89:
	add	r8,r0,r16
	add	r9,r0,r17
	jpl	_storeByte
	addi	r16,r16,#1
	add	r9,r0,r17
	add	r8,r0,r16
	addi	r16,r16,#1
	jpl	_storeByte
	jp	.L89
.L84:
	add	r8,r0,r16
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
	addi	r7,r0,#0
	add	r16,r0,r8
	add	r20,r0,r9
	add	r17,r0,r10
	eeq	r6,r8,r7
	brz	r6,.L197
	eneq	r6,r10,r7
	brz	r6,.L166
	elt	r6,r7,r10
	brz	r6,.L166
	addi	r9,r0,#48
.L188:
	addi	r18,r4,#-10
	add	r8,r0,r18
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L198
.L102:
	eneq	r6,r17,r7
	brz	r6,.L199
	addi	r7,r0,#1
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L189:
	addi	r8,r4,#-9
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L200
.L112:
	eneq	r6,r17,r7
	brz	r6,.L201
	addi	r7,r0,#2
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L190:
	addi	r8,r4,#-8
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L202
.L122:
	eneq	r6,r17,r7
	brz	r6,.L203
	addi	r7,r0,#3
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L191:
	addi	r8,r4,#-7
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L204
.L132:
	eneq	r6,r17,r7
	brz	r6,.L205
	addi	r7,r0,#4
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L192:
	addi	r8,r4,#-6
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L206
.L142:
	eneq	r6,r17,r7
	brz	r6,.L207
	addi	r7,r0,#5
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L193:
	addi	r8,r4,#-5
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L208
.L152:
	eneq	r6,r17,r7
	brz	r6,.L209
	addi	r7,r0,#6
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L194:
	addi	r8,r4,#-4
	jpl	_storeByte
	arsi	r8,r16,#4
	addi	r7,r0,#0
	eneq	r6,r8,r7
	brnz	r6,.L162
.L211:
	eneq	r6,r17,r7
	brz	r6,.L210
	addi	r7,r0,#7
	elt	r6,r7,r17
	brz	r6,.L166
	addi	r9,r0,#48
.L195:
	addi	r8,r4,#-3
	jpl	_storeByte
	addi	r19,r0,#8
	addi	r8,r0,#7
.L172:
	add	r16,r18,r8
	add	r17,r0,r20
	addi	r18,r4,#-11
.L175:
	add	r8,r0,r17
	lb	r9,(r16)
	nop
	andi	r9,r9,#0x00ff
	jpl	_storeByte
	addi	r16,r16,#-1
	addi	r17,r17,#1
	eneq	r6,r16,r18
	brnz	r6,.L175
	add	r6,r0,r19
	jp	.L174
.L197:
	andi	r9,r8,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L96
	addi	r9,r9,#48
	addi	r18,r4,#-10
	add	r8,r0,r18
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brnz	r6,.L102
.L198:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L107
	addi	r9,r9,#48
	addi	r8,r4,#-9
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brnz	r6,.L112
.L200:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L117
	addi	r9,r9,#48
	addi	r8,r4,#-8
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brnz	r6,.L122
.L202:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L127
	addi	r9,r9,#48
	addi	r8,r4,#-7
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brnz	r6,.L132
.L204:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L137
	addi	r9,r9,#48
	addi	r8,r4,#-6
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brnz	r6,.L142
.L206:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L147
	addi	r9,r9,#48
	addi	r8,r4,#-5
	jpl	_storeByte
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brnz	r6,.L152
.L208:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r7,r6,r9
	brnz	r7,.L157
	addi	r8,r4,#-4
	addi	r9,r9,#48
	jpl	_storeByte
	arsi	r8,r16,#4
	addi	r7,r0,#0
	eneq	r6,r8,r7
	brz	r6,.L211
.L162:
	andi	r8,r8,#15
	addi	r6,r0,#9
	elt	r7,r6,r8
	brnz	r7,.L169
	addi	r9,r8,#48
	jp	.L195
.L96:
	addi	r9,r9,#55
	jp	.L188
.L166:
	add	r19,r0,r7
.L100:
	addi	r8,r19,#-1
	addi	r7,r0,#0
	elt	r6,r8,r7
	brnz	r6,.L212
	addi	r18,r4,#-10
	jp	.L172
.L107:
	addi	r9,r9,#55
	jp	.L189
.L117:
	addi	r9,r9,#55
	jp	.L190
.L127:
	addi	r9,r9,#55
	jp	.L191
.L137:
	addi	r9,r9,#55
	jp	.L192
.L147:
	addi	r9,r9,#55
	jp	.L193
.L157:
	addi	r9,r9,#55
	jp	.L194
.L169:
	addi	r9,r8,#55
	jp	.L195
.L212:
	add	r6,r0,r7
	jp	.L174
.L201:
	addi	r19,r0,#2
	jp	.L100
.L199:
	addi	r19,r0,#1
	jp	.L100
.L205:
	addi	r19,r0,#4
	jp	.L100
.L203:
	addi	r19,r0,#3
	jp	.L100
.L209:
	addi	r19,r0,#6
	jp	.L100
.L207:
	addi	r19,r0,#5
	jp	.L100
.L210:
	addi	r19,r0,#7
	jp	.L100
.L174:
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
	addi	r7,r0,#0
	add	r16,r0,r8
	add	r22,r0,r9
	elt	r6,r8,r7
	brnz	r6,.L229
	eeq	r6,r8,r7
	brnz	r6,.L217
	add	r21,r0,r7
.L216:
	addi	r17,r0,#0
	addi	r20,r4,#-32
	addi	r18,r0,#10
	add	r19,r0,r17
.L219:
	mod	r6,r16,r18
	add	r8,r20,r17
	addi	r9,r6,#48
	jpl	_storeByte
	div	r16,r16,r18
	addi	r17,r17,#1
	eneq	r6,r16,r19
	brnz	r6,.L219
	addi	r19,r17,#-1
	addi	r18,r4,#-33
	add	r16,r20,r19
	add	r17,r22,r21
.L222:
	add	r8,r0,r17
	lb	r9,(r16)
	nop
	andi	r9,r9,#0x00ff
	jpl	_storeByte
	addi	r16,r16,#-1
	addi	r17,r17,#1
	eneq	r6,r16,r18
	brnz	r6,.L222
	addi	r6,r21,#1
	add	r6,r6,r19
	jp	.L220
.L217:
	add	r8,r0,r9
	addi	r9,r0,#48
	jpl	_storeByte
	addi	r6,r0,#1
	jp	.L220
.L229:
	sub	r16,r0,r8
	addi	r21,r0,#1
	add	r8,r0,r9
	addi	r9,r0,#45
	jpl	_storeByte
	jp	.L216
.L220:
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
