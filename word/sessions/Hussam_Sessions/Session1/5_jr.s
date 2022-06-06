
_main:	addi	r1, r0, 5
	addi	r2, r0, 9
	addi	r3, r0, 2	; 0 <= r3 <= 5

	lhi	r4, (_label1 >> 16)
	ori	r4, r4, (_label1 & 0xFFFF)
	slli	r3, r3, 3
	add	r4, r4, r3
	jr	r4
	nop


_label1:j	_mark0
	nop
	j	_mark1
	nop
	j	_mark2
	nop
	j	_mark3
	nop
	j	_mark4
	nop
	j	_mark5
	nop

_mark0:	and	r5, r1, r2
	j	_label2
	nop
	
_mark1:	or	r5, r1, r2
	j	_label2
	nop
	
_mark2:	xor	r5, r1, r2
	j	_label2
	nop
	
_mark3:	add	r5, r1, r2
	j	_label2
	nop
	
_mark4:	sub	r5, r1, r2
	j	_label2
	nop
	
_mark5:	slt	r5, r1, r2
	j	_label2
	nop

_label2:trap	#0
