	.section	.text
	.addressing	Word

	; Number of samples: 1300

main:
	; r1 = unsigned char* indata
	lhi	%r1, $(_adpcmData / 65536)&0xffff
	nop
	nop
	nop
	addui	%r1, %r1, $(_adpcmData & 0xffff)
	nop	
	nop
	nop

	; r2 = int len
	addi %r2, %r0, $1300
	nop	
	nop
	nop

	; r3 = stepsizeTable
	lhi	%r3, $(_stepsizeTable / 65536)&0xffff
	nop
	nop
	nop
	addui	%r3, %r3, $(_stepsizeTable & 0xffff)
	nop	
	nop
	nop

	; r4 = indexTable
	lhi	%r4, $(_indexTable / 65536)&0xffff
	nop
	nop
	nop
	addui	%r4, %r4, $(_indexTable & 0xffff)
	nop	
	nop
	nop

	; r5 = int sign;
	; r6 = int delta;
	; r7 = int step;
	; r8 = int valpred = 0;
	; r9 = int vpdiff;
	; r10 = int index = 0;
	; r11 = int inputbuffer = 0;
	; r12 = int bufferstep = 0;

	addu	%r8, %r0, %r0
	nop
	nop
	nop
	addu	%r10, %r0, %r0
	nop
	nop
	nop
	addu	%r11, %r0, %r0
	nop
	nop
	nop
	addu	%r12, %r0, %r0
	nop
	nop
	nop

; Begin ADPCM decoding

    slli	%r13, %r10, $2		; step = stepsizeTable[index];
	nop
	nop
	nop
	addu	%r13, %r13, %r3
	nop
	nop
	nop
	lw	%r7, 0(%r13)
	nop
	nop
	nop
	
; Begin for loop
	
for_begin:
	sle %r13, %r2, %r0		; for ( ; len > 0 ; len-- ) {
	nop
	nop
	nop
	bnez %r13, for_end
	nop
	nop
	nop


;	/* Step 1 - get the delta value */

	beqz %r12, else		; if ( bufferstep ) {
	nop
	nop
	nop
	andi %r6, %r11, $0xf		; 	delta = inputbuffer & 0xf;
	nop
	nop
	nop

	addi %r12, %r0, $0		; bufferstep = !bufferstep;
	nop
	nop
	nop

	j end_if
	nop
	nop
	nop
else:					; } else {
	lb %r11, 0(%r1)			; 	inputbuffer = *indata++;
	nop
	nop
	nop
	addui %r1, %r1, $1
	nop
	nop
	nop
	srli %r6, %r11, $4		; 	delta = (inputbuffer >> 4) & 0xf;
	nop
	nop
	nop
	andi %r6, %r6, $0xf
	nop
	nop
	nop

	addi %r12, %r0, $1		; bufferstep = !bufferstep;
	nop
	nop
	nop
					; }
end_if:


;	/* Step 2 - Find new index value (for later) */

	slli	%r13, %r6, $2		; index += indexTable[delta];
	nop
	nop
	nop
	addu	%r13, %r13, %r4
	nop
	nop
	nop
	lw	%r14, 0(%r13)
	nop
	nop
	nop
	add	%r10, %r10, %r14
	nop
	nop
	nop

	slt %r13, %r10, %r0		; if ( index < 0 ) {
	nop
	nop
	nop
	beqz %r13, endif_1
	nop
	nop
	nop
	addu %r10, %r0, %r0		; 	index = 0;
	nop
	nop
	nop
endif_1:				; }
	sgti %r13, %r10, $88		; if ( index > 88 ) {
	nop
	nop
	nop
	beqz %r13, endif_2
	nop
	nop
	nop
	addui %r10, %r0, $88		; 	index = 88;
	nop
	nop
	nop
endif_2:				; }


;	/* Step 3 - Separate sign and magnitude */
	
	andi %r5, %r6, $8		; sign = delta & 8;
	nop
	nop
	nop
	andi %r6, %r6, $7		; delta = delta & 7;
	nop
	nop
	nop


;	/* Step 4 - Compute difference and new predicted value */

	srli %r9, %r7, $3		; vpdiff = step >> 3;
	nop
	nop
	nop
	andi %r13, %r6, $4		; if ( delta & 4 ) {
	nop
	nop
	nop
	beqz %r13, endif_3
	nop
	nop
	nop
	add %r9, %r9, %r7		; 	vpdiff += step;
	nop
	nop
	nop
endif_3:				; }
	andi %r13, %r6, $2		; if ( delta & 2 ) {
	nop
	nop
	nop
	beqz %r13, endif_4
	nop
	nop
	nop
	srli %r14, %r7, $1		; 	vpdiff += step>>1;
	nop
	nop
	nop
	add %r9, %r9, %r14
	nop
	nop
	nop
endif_4:				; }
	andi %r13, %r6, $1		; if ( delta & 1 ) {
	nop
	nop
	nop
	beqz %r13, endif_5
	nop
	nop
	nop
	srli %r14, %r7, $2		; 	vpdiff += step>>2;
	nop
	nop
	nop
	add %r9, %r9, %r14
	nop
	nop
	nop
endif_5:				; }


	beqz %r5, else_6		; if ( sign ) {
	nop
	nop
	nop
	sub %r8, %r8, %r9		; 	valpred -= vpdiff;
	nop
	nop
	nop
	j endif_6
	nop
	nop
	nop
else_6:					; } else {
	add %r8, %r8, %r9		; 	valpred += vpdiff;
	nop
	nop
	nop
endif_6:				; }


;	/* Step 5 - clamp output value */
	addui %r13, %r0, $32767
	nop
	nop
	nop
	sgt %r14, %r8, %r13		; if ( valpred > 32767 ) {
	nop
	nop
	nop
	beqz %r14, elseif_7
	nop
	nop
	nop
	addu %r8, %r0, %r13		; 	valpred = 32767;
	nop
	nop
	nop
	j endif_7
	nop
	nop
	nop
elseif_7:					; } else if(valpred < -32768) {
	subui %r13, %r0, $32768
	nop
	nop
	nop
	slt %r14, %r8, %r13
	nop
	nop
	nop
	beqz %r14, endif_7
	nop
	nop
	nop
	addu %r8, %r0, %r13		; 	valpred = -32768;
	nop
	nop
	nop
endif_7:


;	/* Step 6 - Update step value */

    slli	%r13, %r10, $2		; step = stepsizeTable[index];
	nop
	nop
	nop
	addu	%r13, %r13, %r3
	nop
	nop
	nop
	lw	%r7, 0(%r13)
	nop
	nop
	nop


;	/* Step 7 - Output value */

output:

	; Only needed for FPGA project (also change subsequent andi instruction!)
	;addui %r14,%r8,$32768
	;nop
	;nop
	;nop	

	andi %r14,%r8,$65535
	nop
	nop
	nop

	beqz %r12, output_else
	nop
	nop
	nop
	lhi	%r13, $(40000004/0x10000)
	nop
	nop
	nop
	ori	%r13, %r13, $(40000004%0x10000)
	nop
	nop
	nop
	sw	0(%r13), %r14
	nop
	nop
	nop
	j output_end
	nop
	nop
	nop
output_else:
	lhi	%r13, $(40000008/0x10000)
	nop
	nop
	nop
	ori	%r13, %r13, $(40000008%0x10000)
	nop
	nop
	nop
	sw	0(%r13), %r14
	nop
	nop
	nop
output_end:
	
	subi %r2, %r2, $1
	nop
	nop
	nop
	j for_begin
	nop
	nop
	nop
for_end:				; }

	nop

	.section	.data
	.align	4
_indexTable:
	.data.32	-1
	.data.32	-1
	.data.32	-1
	.data.32	-1
	.data.32	2
	.data.32	4
	.data.32	6
	.data.32	8
	.data.32	-1
	.data.32	-1
	.data.32	-1
	.data.32	-1
	.data.32	2
	.data.32	4
	.data.32	6
	.data.32	8
	.align	4
_stepsizeTable:
	.data.32	7
	.data.32	8
	.data.32	9
	.data.32	10
	.data.32	11
	.data.32	12
	.data.32	13
	.data.32	14
	.data.32	16
	.data.32	17
	.data.32	19
	.data.32	21
	.data.32	23
	.data.32	25
	.data.32	28
	.data.32	31
	.data.32	34
	.data.32	37
	.data.32	41
	.data.32	45
	.data.32	50
	.data.32	55
	.data.32	60
	.data.32	66
	.data.32	73
	.data.32	80
	.data.32	88
	.data.32	97
	.data.32	107
	.data.32	118
	.data.32	130
	.data.32	143
	.data.32	157
	.data.32	173
	.data.32	190
	.data.32	209
	.data.32	230
	.data.32	253
	.data.32	279
	.data.32	307
	.data.32	337
	.data.32	371
	.data.32	408
	.data.32	449
	.data.32	494
	.data.32	544
	.data.32	598
	.data.32	658
	.data.32	724
	.data.32	796
	.data.32	876
	.data.32	963
	.data.32	1060
	.data.32	1166
	.data.32	1282
	.data.32	1411
	.data.32	1552
	.data.32	1707
	.data.32	1878
	.data.32	2066
	.data.32	2272
	.data.32	2499
	.data.32	2749
	.data.32	3024
	.data.32	3327
	.data.32	3660
	.data.32	4026
	.data.32	4428
	.data.32	4871
	.data.32	5358
	.data.32	5894
	.data.32	6484
	.data.32	7132
	.data.32	7845
	.data.32	8630
	.data.32	9493
	.data.32	10442
	.data.32	11487
	.data.32	12635
	.data.32	13899
	.data.32	15289
	.data.32	16818
	.data.32	18500
	.data.32	20350
	.data.32	22385
	.data.32	24623
	.data.32	27086
	.data.32	29794
	.data.32	32767
	;.global	_adpcmData
_adpcmData:
	.data.8	59
	.data.8	9
	.data.8	8
	.data.8	89
	.data.8	74
	.data.8	27
	.data.8	138
	.data.8	24
	.data.8	40
	.data.8	10
	.data.8	63
	.data.8	77
	.data.8	75
	.data.8	58
	.data.8	17
	.data.8	147
	.data.8	161
	.data.8	140
	.data.8	63
	.data.8	59
	.data.8	59
	.data.8	44
	.data.8	42
	.data.8	33
	.data.8	4
	.data.8	145
	.data.8	153
	.data.8	146
	.data.8	162
	.data.8	63
	.data.8	79
	.data.8	42
	.data.8	25
	.data.8	26
	.data.8	58
	.data.8	33
	.data.8	182
	.data.8	168
	.data.8	29
	.data.8	75
	.data.8	32
	.data.8	147
	.data.8	178
	.data.8	154
	.data.8	78
	.data.8	75
	.data.8	57
	.space	1
	.data.8	161
	.data.8	9
	.data.8	73
	.data.8	25
	.data.8	139
	.data.8	29
	.data.8	91
	.data.8	90
	.data.8	60
	.data.8	43
	.data.8	16
	.data.8	8
	.data.8	44
	.data.8	59
	.data.8	2
	.data.8	164
	.data.8	168
	.data.8	12
	.data.8	42
	.data.8	74
	.data.8	123
	.data.8	75
	.data.8	130
	.data.8	195
	.data.8	144
	.data.8	75
	.data.8	76
	.data.8	26
	.data.8	8
	.data.8	17
	.data.8	145
	.data.8	154
	.data.8	61
	.data.8	73
	.data.8	1
	.data.8	177
	.data.8	10
	.data.8	122
	.data.8	91
	.data.8	43
	.data.8	24
	.data.8	129
	.data.8	168
	.data.8	141
	.data.8	122
	.data.8	89
	.data.8	43
	.data.8	45
	.space	1
	.data.8	148
	.data.8	179
	.data.8	144
	.data.8	9
	.data.8	41
	.data.8	43
	.data.8	76
	.data.8	32
	.data.8	146
	.data.8	202
	.data.8	47
	.data.8	75
	.data.8	72
	.space	1
	.data.8	152
	.data.8	10
	.data.8	40
	.data.8	1
	.data.8	144
	.data.8	9
	.data.8	11
	.data.8	12
	.data.8	41
	.data.8	65
	.data.8	16
	.data.8	172
	.data.8	11
	.data.8	121
	.data.8	74
	.data.8	45
	.data.8	27
	.data.8	57
	.data.8	56
	.data.8	130
	.data.8	211
	.data.8	144
	.data.8	93
	.data.8	77
	.data.8	42
	.data.8	8
	.space	1
	.data.8	41
	.data.8	59
	.data.8	75
	.data.8	61
	.data.8	61
	.data.8	59
	.data.8	73
	.space	1
	.data.8	144
	.data.8	161
	.data.8	180
	.data.8	164
	.data.8	136
	.data.8	46
	.data.8	44
	.data.8	42
	.data.8	18
	.data.8	3
	.data.8	12
	.data.8	47
	.data.8	9
	.data.8	131
	.data.8	130
	.data.8	62
	.data.8	44
	.data.8	26
	.data.8	24
	.data.8	59
	.data.8	91
	.data.8	42
	.data.8	24
	.data.8	41
	.data.8	91
	.data.8	76
	.data.8	25
	.data.8	8
	.data.8	10
	.data.8	63
	.data.8	60
	.data.8	73
	.data.8	32
	.data.8	145
	.data.8	193
	.data.8	144
	.data.8	10
	.data.8	44
	.data.8	75
	.data.8	73
	.data.8	58
	.data.8	44
	.data.8	27
	.data.8	62
	.data.8	74
	.data.8	57
	.data.8	129
	.data.8	177
	.data.8	140
	.data.8	123
	.data.8	74
	.data.8	24
	.data.8	136
	.data.8	136
	.data.8	16
	.data.8	32
	.data.8	27
	.data.8	63
	.data.8	43
	.data.8	33
	.data.8	165
	.data.8	178
	.data.8	177
	.data.8	152
	.data.8	25
	.data.8	1
	.data.8	146
	.data.8	29
	.data.8	93
	.data.8	42
	.data.8	24
	.data.8	28
	.data.8	77
	.data.8	41
	.data.8	131
	.data.8	164
	.data.8	137
	.data.8	62
	.data.8	43
	.data.8	42
	.data.8	42
	.data.8	48
	.data.8	145
	.data.8	155
	.data.8	44
	.data.8	82
	.data.8	149
	.data.8	170
	.data.8	63
	.data.8	62
	.data.8	58
	.data.8	59
	.data.8	59
	.data.8	17
	.data.8	197
	.data.8	194
	.data.8	138
	.data.8	74
	.data.8	40
	.data.8	129
	.data.8	160
	.data.8	9
	.data.8	58
	.data.8	42
	.data.8	27
	.data.8	60
	.data.8	106
	.data.8	43
	.data.8	45
	.data.8	42
	.data.8	25
	.data.8	75
	.data.8	107
	.data.8	74
	.space	1
	.data.8	161
	.data.8	129
	.data.8	24
	.data.8	26
	.data.8	29
	.data.8	92
	.data.8	58
	.data.8	24
	.data.8	144
	.data.8	58
	.data.8	90
	.data.8	138
	.data.8	172
	.data.8	74
	.data.8	80
	.data.8	147
	.data.8	240
	.data.8	144
	.data.8	57
	.data.8	57
	.data.8	140
	.data.8	11
	.data.8	64
	.data.8	3
	.data.8	168
	.data.8	30
	.data.8	91
	.data.8	59
	.data.8	25
	.data.8	164
	.data.8	165
	.data.8	137
	.data.8	45
	.data.8	25
	.data.8	17
	.data.8	137
	.data.8	63
	.data.8	74
	.data.8	32
	.data.8	8
	.data.8	154
	.data.8	12
	.data.8	58
	.data.8	59
	.data.8	59
	.data.8	35
	.data.8	199
	.data.8	144
	.data.8	28
	.data.8	61
	.data.8	24
	.data.8	146
	.data.8	128
	.data.8	92
	.data.8	75
	.data.8	26
	.space	1
	.data.8	8
	.data.8	43
	.data.8	76
	.data.8	41
	.data.8	24
	.data.8	26
	.data.8	46
	.data.8	58
	.data.8	34
	.data.8	147
	.data.8	154
	.data.8	47
	.data.8	29
	.data.8	42
	.data.8	57
	.data.8	40
	.data.8	128
	.data.8	137
	.data.8	92
	.data.8	59
	.data.8	24
	.data.8	8
	.data.8	90
	.data.8	89
	.data.8	11
	.data.8	31
	.data.8	61
	.data.8	57
	.data.8	24
	.data.8	9
	.data.8	27
	.data.8	41
	.data.8	18
	.data.8	24
	.data.8	77
	.data.8	60
	.data.8	26
	.data.8	137
	.data.8	42
	.data.8	123
	.data.8	75
	.data.8	8
	.data.8	162
	.data.8	146
	.data.8	57
	.data.8	74
	.data.8	45
	.data.8	63
	.data.8	77
	.data.8	58
	.data.8	16
	.data.8	129
	.data.8	152
	.data.8	29
	.data.8	26
	.data.8	17
	.data.8	132
	.data.8	136
	.data.8	63
	.data.8	42
	.data.8	16
	.data.8	145
	.data.8	154
	.data.8	46
	.data.8	75
	.data.8	57
	.data.8	41
	.data.8	42
	.data.8	41
	.space	1
	.data.8	137
	.data.8	77
	.data.8	61
	.data.8	41
	.data.8	129
	.data.8	128
	.data.8	44
	.data.8	59
	.data.8	58
	.data.8	58
	.data.8	10
	.data.8	27
	.data.8	122
	.data.8	90
	.data.8	26
	.data.8	45
	.data.8	75
	.data.8	57
	.data.8	130
	.data.8	162
	.data.8	155
	.data.8	30
	.data.8	91
	.data.8	105
	.data.8	1
	.data.8	194
	.data.8	169
	.data.8	75
	.data.8	64
	.data.8	165
	.data.8	194
	.data.8	169
	.data.8	43
	.data.8	106
	.data.8	58
	.data.8	8
	.data.8	144
	.data.8	8
	.data.8	40
	.data.8	8
	.data.8	170
	.data.8	63
	.data.8	74
	.data.8	16
	.data.8	9
	.data.8	63
	.data.8	59
	.data.8	1
	.data.8	146
	.data.8	10
	.data.8	109
	.data.8	60
	.data.8	59
	.data.8	40
	.data.8	147
	.data.8	160
	.data.8	60
	.data.8	75
	.space	1
	.data.8	146
	.data.8	1
	.space	1
	.data.8	185
	.data.8	63
	.data.8	77
	.data.8	58
	.data.8	8
	.data.8	8
	.data.8	2
	.data.8	147
	.data.8	29
	.data.8	93
	.data.8	24
	.data.8	129
	.data.8	10
	.data.8	77
	.data.8	24
	.data.8	147
	.data.8	152
	.data.8	27
	.data.8	18
	.data.8	167
	.data.8	144
	.data.8	30
	.data.8	42
	.data.8	40
	.space	1
	.data.8	137
	.data.8	9
	.data.8	59
	.data.8	75
	.data.8	61
	.data.8	76
	.data.8	75
	.data.8	42
	.data.8	24
	.space	1
	.data.8	152
	.data.8	168
	.data.8	17
	.data.8	120
	.data.8	44
	.data.8	45
	.data.8	42
	.data.8	32
	.data.8	130
	.data.8	137
	.data.8	46
	.data.8	44
	.data.8	25
	.data.8	58
	.data.8	74
	.data.8	26
	.data.8	30
	.data.8	59
	.data.8	48
	.data.8	130
	.data.8	11
	.data.8	122
	.data.8	40
	.data.8	177
	.data.8	200
	.data.8	58
	.data.8	121
	.data.8	26
	.data.8	10
	.data.8	43
	.data.8	122
	.data.8	43
	.data.8	26
	.space	1
	.data.8	74
	.data.8	58
	.data.8	147
	.data.8	196
	.data.8	9
	.data.8	63
	.data.8	28
	.data.8	59
	.data.8	57
	.space	1
	.data.8	128
	.data.8	108
	.data.8	91
	.data.8	25
	.data.8	144
	.data.8	128
	.data.8	40
	.data.8	56
	.data.8	9
	.data.8	169
	.data.8	178
	.data.8	24
	.data.8	124
	.data.8	107
	.data.8	25
	.space	1
	.data.8	44
	.data.8	61
	.data.8	24
	.data.8	24
	.data.8	59
	.data.8	60
	.data.8	61
	.data.8	75
	.data.8	58
	.space	1
	.data.8	8
	.data.8	62
	.data.8	44
	.data.8	43
	.data.8	75
	.data.8	90
	.data.8	24
	.data.8	147
	.data.8	195
	.data.8	177
	.data.8	29
	.data.8	108
	.data.8	58
	.data.8	24
	.data.8	146
	.data.8	136
	.data.8	44
	.data.8	42
	.space	1
	.data.8	8
	.data.8	44
	.data.8	26
	.data.8	24
	.data.8	41
	.data.8	91
	.data.8	41
	.data.8	166
	.data.8	196
	.data.8	161
	.data.8	27
	.data.8	77
	.data.8	42
	.data.8	146
	.data.8	180
	.data.8	145
	.data.8	41
	.data.8	58
	.data.8	30
	.data.8	63
	.data.8	59
	.data.8	58
	.data.8	41
	.data.8	9
	.data.8	16
	.data.8	148
	.data.8	161
	.data.8	138
	.data.8	41
	.data.8	2
	.data.8	137
	.data.8	59
	.data.8	73
	.data.8	26
	.data.8	31
	.data.8	31
	.data.8	43
	.data.8	91
	.data.8	91
	.data.8	58
	.data.8	24
	.data.8	128
	.data.8	9
	.data.8	43
	.data.8	1
	.data.8	146
	.data.8	91
	.data.8	123
	.data.8	24
	.data.8	178
	.data.8	200
	.data.8	62
	.data.8	72
	.data.8	3
	.data.8	178
	.data.8	141
	.data.8	61
	.data.8	40
	.data.8	128
	.data.8	144
	.data.8	128
	.data.8	17
	.data.8	27
	.data.8	94
	.data.8	74
	.data.8	40
	.data.8	144
	.data.8	169
	.data.8	24
	.data.8	35
	.data.8	161
	.data.8	143
	.data.8	94
	.data.8	57
	.data.8	1
	.data.8	179