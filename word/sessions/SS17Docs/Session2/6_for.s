	.section	.text
	.addressing	Word

main:	lw	%r7, C(%r0)
	addi	%r1, %r0, $10
	nop
	nop
	addi	%r7, %r7, $5

loop:	lw	%r6, B(%r4)
	subi	%r1, %r1, $1
	nop
	nop
	add	%r6, %r6, %r7
	nop
	nop
	nop
	sw	A(%r4), %r6
	addi	%r4, %r4, $4
	bnez	%r1, loop
	nop
	nop

	.section	.data
	.addressing	Word

A:	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0
	.data.32	0

B:	.data.32	1
	.data.32	2
	.data.32	3
	.data.32	4
	.data.32	5
	.data.32	6
	.data.32	7
	.data.32	8
	.data.32	9
	.data.32	10

C:	.data.32	42

