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
	brz	r6,.L4
	add	r9,r0,r7
.L5:
	addi	r7,r7,#1
	add	r6,r8,r7
	lb	r6,(r6)
	nop
	andi	r6,r6,#0x00ff
	eneq	r6,r6,r9
	brnz	r6,.L5
.L4:
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
	brnz	r6,.L10
	eeq	r6,r10,r11
	brnz	r6,.L12
	elt	r6,r7,r10
	brnz	r6,.L14
	elt	r6,r10,r7
	brnz	r6,.L12
	addi	r8,r8,#1
	addi	r9,r9,#1
	jp	.L17
.L24:
	eneq	r6,r10,r11
	brz	r6,.L12
	elt	r6,r7,r10
	brnz	r6,.L14
	elt	r6,r10,r7
	brnz	r6,.L12
.L17:
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
	brz	r6,.L24
.L10:
	addi	r7,r0,#0
	eneq	r6,r10,r7
	brnz	r6,.L14
	add	r6,r0,r7
	jp	.L22
.L12:
	addi	r6,r0,#1
	jp	.L22
.L14:
	addi	r6,r0,#-1
.L22:
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
	brz	r6,.L41
.L26:
	addi	r6,r0,#0
.L31:
	eeq	r9,r6,r10
	brnz	r9,.L36
	eeq	r6,r8,r9
	brz	r6,.L42
	andi	r6,r13,#0x00ff
	eeq	r6,r6,r9
	brz	r6,.L32
.L36:
	addi	r6,r0,#0
	jp	.L35
.L41:
	andi	r7,r13,#0x00ff
	eeq	r6,r7,r11
	brnz	r6,.L26
	addi	r12,r0,#1
	elt	r6,r12,r10
	brz	r6,.L43
	elt	r6,r8,r7
	brnz	r6,.L32
	add	r9,r0,r11
	elt	r6,r7,r8
	brz	r6,.L34
	add	r9,r0,r12
.L34:
	add	r6,r0,r9
	jp	.L35
.L42:
	addi	r6,r0,#1
	jp	.L35
.L32:
	addi	r6,r0,#-1
	jp	.L35
.L43:
	add	r6,r0,r12
	jp	.L31
.L35:
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
	brnz	r6,.L45
	addi	r8,r8,#32
.L45:
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
	brnz	r6,.L49
	addi	r8,r8,#-32
.L49:
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
	brnz	r6,.L53
	addi	r9,r0,#1
.L53:
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
	brnz	r6,.L56
	addi	r7,r0,#1
	elt	r6,r7,r10
	brz	r6,.L56
	add	r16,r0,r7
	jp	.L59
.L63:
	add	r8,r0,r17
.L59:
	addi	r17,r8,#1
	add	r9,r0,r18
	jpl	_storeByte
	addi	r16,r16,#1
	eeq	r6,r16,r19
	brz	r6,.L63
	add	r6,r20,r19
	addi	r20,r6,#-1
.L56:
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
	brnz	r6,.L65
.L68:
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
	jp	.L68
.L65:
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
	brnz	r6,.L70
.L79:
	lb	r6,(r16)
	nop
	andi	r6,r6,#0x00ff
	addi	r16,r16,#1
	eneq	r6,r6,r7
	brnz	r6,.L79
.L70:
	lb	r19,(r9)
	nop
	andi	r19,r19,#0x00ff
	addi	r6,r0,#0
	eeq	r6,r19,r6
	brnz	r6,.L72
	addi	r7,r0,#1
	elt	r6,r7,r20
	brz	r6,.L72
	add	r8,r0,r16
	add	r17,r0,r7
	jp	.L75
.L81:
	add	r8,r0,r18
.L75:
	addi	r18,r8,#1
	add	r9,r0,r19
	jpl	_storeByte
	addi	r17,r17,#1
	eeq	r6,r17,r20
	brz	r6,.L81
	add	r6,r16,r20
	addi	r16,r6,#-1
.L72:
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
	brnz	r6,.L83
.L88:
	lb	r6,(r8)
	nop
	andi	r6,r6,#0x00ff
	addi	r8,r8,#1
	eneq	r6,r6,r7
	brnz	r6,.L88
.L83:
	lb	r17,(r9)
	nop
	andi	r17,r17,#0x00ff
	addi	r9,r0,#0
	eeq	r6,r17,r9
	brnz	r6,.L85
.L90:
	addi	r16,r8,#1
	add	r9,r0,r17
	jpl	_storeByte
	add	r8,r0,r16
	addi	r16,r8,#1
	add	r9,r0,r17
	jpl	_storeByte
	add	r8,r0,r16
	jp	.L90
.L85:
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
	brz	r6,.L190
	eneq	r6,r10,r7
	brz	r6,.L167
	elt	r6,r7,r10
	brz	r6,.L167
	addi	r9,r0,#48
.L95:
	addi	r18,r4,#-10
	add	r8,r0,r18
	jpl	_storeByte
.L96:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L191
	eneq	r6,r17,r7
	brz	r6,.L192
	addi	r7,r0,#1
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L106:
	addi	r8,r4,#-9
	jpl	_storeByte
.L107:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L193
	eneq	r6,r17,r7
	brz	r6,.L194
	addi	r7,r0,#2
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L116:
	addi	r8,r4,#-8
	jpl	_storeByte
.L117:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L195
	eneq	r6,r17,r7
	brz	r6,.L196
	addi	r7,r0,#3
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L126:
	addi	r8,r4,#-7
	jpl	_storeByte
.L127:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L197
	eneq	r6,r17,r7
	brz	r6,.L198
	addi	r7,r0,#4
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L136:
	addi	r8,r4,#-6
	jpl	_storeByte
.L137:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L199
	eneq	r6,r17,r7
	brz	r6,.L200
	addi	r7,r0,#5
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L146:
	addi	r8,r4,#-5
	jpl	_storeByte
.L147:
	arsi	r16,r16,#4
	addi	r7,r0,#0
	eeq	r6,r16,r7
	brz	r6,.L201
	eneq	r6,r17,r7
	brz	r6,.L202
	addi	r7,r0,#6
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L156:
	addi	r8,r4,#-4
	jpl	_storeByte
.L157:
	arsi	r8,r16,#4
	addi	r7,r0,#0
	eneq	r6,r8,r7
	brnz	r6,.L163
	eneq	r6,r17,r7
	brz	r6,.L203
	addi	r7,r0,#7
	elt	r6,r7,r17
	brz	r6,.L167
	addi	r9,r0,#48
.L169:
	addi	r8,r4,#-3
	jpl	_storeByte
.L172:
	addi	r19,r0,#8
	addi	r8,r0,#7
.L173:
	add	r16,r18,r8
	add	r17,r0,r20
	addi	r18,r4,#-11
.L176:
	add	r8,r0,r17
	lb	r9,(r16)
	nop
	andi	r9,r9,#0x00ff
	jpl	_storeByte
	addi	r16,r16,#-1
	addi	r17,r17,#1
	eneq	r6,r16,r18
	brnz	r6,.L176
	add	r6,r0,r19
	jp	.L175
.L190:
	andi	r9,r8,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L97
	addi	r9,r9,#48
	jp	.L95
.L191:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L108
	addi	r9,r9,#48
	jp	.L106
.L193:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L118
	addi	r9,r9,#48
	jp	.L116
.L195:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L128
	addi	r9,r9,#48
	jp	.L126
.L197:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L138
	addi	r9,r9,#48
	jp	.L136
.L199:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L148
	addi	r9,r9,#48
	jp	.L146
.L201:
	andi	r9,r16,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L158
	addi	r9,r9,#48
	jp	.L156
.L163:
	andi	r9,r8,#15
	addi	r6,r0,#9
	elt	r6,r6,r9
	brnz	r6,.L170
	addi	r9,r9,#48
	jp	.L169
.L97:
	addi	r18,r4,#-10
	add	r8,r0,r18
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L96
.L167:
	add	r19,r0,r7
.L101:
	addi	r8,r19,#-1
	addi	r7,r0,#0
	elt	r6,r8,r7
	brnz	r6,.L204
	addi	r18,r4,#-10
	jp	.L173
.L108:
	addi	r8,r4,#-9
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L107
.L118:
	addi	r8,r4,#-8
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L117
.L128:
	addi	r8,r4,#-7
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L127
.L138:
	addi	r8,r4,#-6
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L137
.L148:
	addi	r8,r4,#-5
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L147
.L158:
	addi	r8,r4,#-4
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L157
.L170:
	addi	r8,r4,#-3
	addi	r9,r9,#55
	jpl	_storeByte
	jp	.L172
.L204:
	add	r6,r0,r7
	jp	.L175
.L194:
	addi	r19,r0,#2
	jp	.L101
.L192:
	addi	r19,r0,#1
	jp	.L101
.L198:
	addi	r19,r0,#4
	jp	.L101
.L196:
	addi	r19,r0,#3
	jp	.L101
.L202:
	addi	r19,r0,#6
	jp	.L101
.L200:
	addi	r19,r0,#5
	jp	.L101
.L203:
	addi	r19,r0,#7
	jp	.L101
.L175:
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
	brnz	r6,.L221
	eeq	r6,r8,r7
	brnz	r6,.L209
	add	r21,r0,r7
.L208:
	addi	r17,r0,#0
	addi	r20,r4,#-32
	addi	r18,r0,#10
	add	r19,r0,r17
.L211:
	mod	r6,r16,r18
	add	r8,r20,r17
	addi	r9,r6,#48
	jpl	_storeByte
	div	r16,r16,r18
	addi	r17,r17,#1
	eneq	r6,r16,r19
	brnz	r6,.L211
	addi	r19,r17,#-1
	add	r16,r20,r19
	add	r17,r22,r21
	addi	r18,r4,#-33
.L214:
	add	r8,r0,r17
	lb	r9,(r16)
	nop
	andi	r9,r9,#0x00ff
	jpl	_storeByte
	addi	r16,r16,#-1
	addi	r17,r17,#1
	eneq	r6,r16,r18
	brnz	r6,.L214
	addi	r6,r21,#1
	add	r6,r6,r19
	jp	.L212
.L209:
	add	r8,r0,r9
	addi	r9,r0,#48
	jpl	_storeByte
	addi	r6,r0,#1
	jp	.L212
.L221:
	sub	r16,r0,r8
	add	r8,r0,r9
	addi	r9,r0,#45
	jpl	_storeByte
	addi	r21,r0,#1
	jp	.L208
.L212:
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
