	.section	.text
	.addressing	Word
	xor	r4, r4, r4
	xor	r5, r5, r5
	xor	r6, r6, r6
	addi	r4, r0, $(0x0017EFFC / 0x10000)
	addi	r5, r0, $(0x0017EFFC / 0x10000)

	lsoi	r4, r4, $(0x0017EFFC % 0x10000)
	lsoi	r5, r5, $(0x0017EFFC % 0x10000)

	sw	-4(r5), r4
	sw	-8(r5), r3
	addi	r5, r4, $(-8)

	jpl	_main	
	sw	0(r5), r21
	jpl	_exit



