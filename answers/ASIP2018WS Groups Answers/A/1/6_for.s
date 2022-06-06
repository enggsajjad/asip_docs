_main:

	ADDI	R21, R0,  $(_A / 0x10000)
	LSOI	R21, R21, $(_A % 0x10000)

	ADDI	R22, R0,  $(_B / 0x10000)
	LSOI	R22, R22, $(_B % 0x10000)

	ADDI	R23, R0,  $(_C / 0x10000)
	LSOI	R23, R23, $(_C % 0x10000)

	LW	R24, 0(R23) 	; load C

	ADDI	R25, R0, $(10) 	; i = 10

	ADDI	R26, R24, $(5) 	; R26 = C+5

_loop:	
	LW R27, 0(R22) 		; load B
	ADDI R22, R22, $(4) 	; increment B address
	ADD R28, R27, R26 	; add B+(C+5)

	SW 0(R21), R28 		; store in A
	ADDI R21, R21, $(4) 	; increment A address

	SUBI R25, R25, $(1)	; decrement i
	BRNZ R25, _loop		; branch while i != 0
	NOP			; prevent trap #0

	trap #0


_A:	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	.data.32 0
	

_B:	.data.32 10
	.data.32 20
	.data.32 30
	.data.32 40
	.data.32 50
	.data.32 60
	.data.32 70
	.data.32 80
	.data.32 90
	.data.32 100

_C:	.data.32 5



