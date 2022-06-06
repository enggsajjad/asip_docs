
_main:	lhi	r1, (_data >> 16)
	ori	r1, r1, (_data & 0xFFFF)

	lw	r2, 0(r1)
	lw	r3, 4(r1)

	add	r4, r2, r3

	lhi	r5, (_result >> 16)
	ori	r5, r5, (_result & 0xFFFF)

	sw	0(r5), r4
	
	trap #0


_data:	.data.32	42
	.data.32	23
_result:.data.32	0
