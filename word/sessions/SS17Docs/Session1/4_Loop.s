
_main:	addi	r1, r0, 5
	addi	r2, r0, 9
	add	r3, r0, r0

_loop:	andi	r4, r1, 1
	beqz	r4, _skipAdd
	nop
	add	r3, r3, r2

_skipAdd:srai	r1, r1, 1
	slli	r2, r2, 1
	bnez	r1, _loop
	nop
	
	trap #0