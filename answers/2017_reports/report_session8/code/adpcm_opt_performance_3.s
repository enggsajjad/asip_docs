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

	; r3 = int delta_1/out_1;
	; r4 = int delta_2/out_2;
	; r5 = int index_in/index_out = 0;
	; r6 = int output_in/output_out = 0;

	addu	%r5, %r0, %r0
	nop
	nop
	nop
	addu	%r6, %r0, %r0
	nop
	nop
	nop

; Begin ADPCM decoding

; Begin for loop
	
for_begin:
	ble %r2, %r0, for_end		; for ( ; len > 0 ; len-- ) {
	nop
	nop
	nop

;	/* Load four samples into two registers */

	lhh %r3, %r4, %r1
	nop
	nop
	nop

;	/* Decode samples */

	pcm %r3, %r4, %r5, %r6
	nop
	nop
	nop

;	/* Output values */

output:

	; Only needed for FPGA project (also change output!)
	;addui %r14,%r3,$32768
	;nop
	;nop
	;nop	
	;addui %r15,%r4,$32768
	;nop
	;nop
	;nop

	lhi	%r17, $(40000004/0x10000)
	nop
	nop
	nop
	ori	%r17, %r17, $(40000004%0x10000)
	nop
	nop
	nop
	lhi	%r18, $(40000008/0x10000)
	nop
	nop
	nop
	ori	%r18, %r18, $(40000008%0x10000)
	nop
	nop
	nop
	srli %r20,%r3,$16
	nop
	nop
	nop
	sw	0(%r17), %r20
	nop
	nop
	nop
	andi %r20,%r3,$65535
	nop
	nop
	nop
	sw	0(%r18), %r20
	nop
	nop
	nop
	srli %r20,%r4,$16
	nop
	nop
	nop
	sw	0(%r17), %r20
	nop
	nop
	nop
	andi %r20,%r4,$65535
	nop
	nop
	nop
	sw	0(%r18), %r20
	nop
	nop
	nop
	
	subi %r2, %r2, $4
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