
_main:	addi	r1, r0, 5
	addi	r2, r0, 9

	sgt	r3, r1, r2
	bnez	r3, _label1
	nop
	add	r4, r0, r2
	j	_label2
	nop

_label1:add	r4, r0, r1

_label2:nop	; ... compute anything with the result in r4 ...
	trap #0

