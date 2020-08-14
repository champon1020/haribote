[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_load_gdtr
	EXTERN	_load_idtr
	EXTERN	_asm_inthandler21
	EXTERN	_asm_inthandler27
	EXTERN	_asm_inthandler2c
[FILE "dsctbl.c"]
[SECTION .text]
	ALIGN	2
	GLOBAL	_init_gdtidt
_init_gdtidt:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,24
	MOV	DWORD [-4+EBP],2555904
	MOV	DWORD [-8+EBP],2553856
	MOV	DWORD [-12+EBP],0
L2:
	CMP	DWORD [-12+EBP],8191
	JLE	L5
	JMP	L3
L5:
	PUSH	0
	PUSH	0
	PUSH	0
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,3
	ADD	EAX,DWORD [-4+EBP]
	PUSH	EAX
	CALL	_set_segmdesc
	ADD	ESP,16
	LEA	EAX,DWORD [-12+EBP]
	INC	DWORD [EAX]
	JMP	L2
L3:
	PUSH	16530
	PUSH	0
	PUSH	-1
	MOV	EAX,DWORD [-4+EBP]
	ADD	EAX,8
	PUSH	EAX
	CALL	_set_segmdesc
	ADD	ESP,16
	PUSH	16538
	PUSH	2621440
	PUSH	524287
	MOV	EAX,DWORD [-4+EBP]
	ADD	EAX,16
	PUSH	EAX
	CALL	_set_segmdesc
	ADD	ESP,16
	SUB	ESP,8
	PUSH	2555904
	PUSH	65535
	CALL	_load_gdtr
	ADD	ESP,16
	MOV	DWORD [-12+EBP],0
L6:
	CMP	DWORD [-12+EBP],255
	JLE	L9
	JMP	L7
L9:
	PUSH	0
	PUSH	0
	PUSH	0
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,3
	ADD	EAX,DWORD [-8+EBP]
	PUSH	EAX
	CALL	_set_gatedesc
	ADD	ESP,16
	LEA	EAX,DWORD [-12+EBP]
	INC	DWORD [EAX]
	JMP	L6
L7:
	SUB	ESP,8
	PUSH	2553856
	PUSH	2047
	CALL	_load_idtr
	ADD	ESP,16
	PUSH	142
	PUSH	16
	PUSH	_asm_inthandler21
	MOV	EAX,DWORD [-8+EBP]
	ADD	EAX,264
	PUSH	EAX
	CALL	_set_gatedesc
	ADD	ESP,16
	PUSH	142
	PUSH	16
	PUSH	_asm_inthandler27
	MOV	EAX,DWORD [-8+EBP]
	ADD	EAX,312
	PUSH	EAX
	CALL	_set_gatedesc
	ADD	ESP,16
	PUSH	142
	PUSH	16
	PUSH	_asm_inthandler2c
	MOV	EAX,DWORD [-8+EBP]
	ADD	EAX,352
	PUSH	EAX
	CALL	_set_gatedesc
	ADD	ESP,16
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_set_segmdesc
_set_segmdesc:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	CMP	DWORD [12+EBP],1048575
	JBE	L11
	LEA	EAX,DWORD [20+EBP]
	OR	DWORD [EAX],32768
	MOV	EAX,DWORD [12+EBP]
	SHR	EAX,12
	MOV	DWORD [12+EBP],EAX
L11:
	MOV	EDX,DWORD [8+EBP]
	MOV	EAX,DWORD [12+EBP]
	MOV	WORD [EDX],AX
	MOV	EDX,DWORD [8+EBP]
	MOV	EAX,-1
	AND	EAX,DWORD [16+EBP]
	MOV	WORD [2+EDX],AX
	MOV	ECX,DWORD [8+EBP]
	MOV	EAX,DWORD [16+EBP]
	MOV	EDX,EAX
	SAR	EDX,16
	MOV	AL,-1
	AND	EAX,EDX
	MOV	BYTE [4+ECX],AL
	MOV	EDX,DWORD [8+EBP]
	MOV	AL,-1
	AND	EAX,DWORD [20+EBP]
	MOV	BYTE [5+EDX],AL
	MOV	EBX,DWORD [8+EBP]
	MOV	EAX,DWORD [12+EBP]
	SHR	EAX,16
	MOV	CL,AL
	AND	ECX,15
	MOV	EAX,DWORD [20+EBP]
	MOV	EDX,EAX
	SAR	EDX,8
	MOV	AL,-16
	AND	EAX,EDX
	OR	EAX,ECX
	MOV	BYTE [6+EBX],AL
	MOV	ECX,DWORD [8+EBP]
	MOV	EAX,DWORD [16+EBP]
	MOV	EDX,EAX
	SAR	EDX,24
	MOV	AL,-1
	AND	EAX,EDX
	MOV	BYTE [7+ECX],AL
	POP	EBX
	POP	EBP
	RET
	ALIGN	2
	GLOBAL	_set_gatedesc
_set_gatedesc:
	PUSH	EBP
	MOV	EBP,ESP
	MOV	EDX,DWORD [8+EBP]
	MOV	EAX,-1
	AND	EAX,DWORD [12+EBP]
	MOV	WORD [EDX],AX
	MOV	EDX,DWORD [8+EBP]
	MOV	EAX,DWORD [16+EBP]
	MOV	WORD [2+EDX],AX
	MOV	ECX,DWORD [8+EBP]
	MOV	EAX,DWORD [20+EBP]
	MOV	EDX,EAX
	SAR	EDX,8
	MOV	AL,-1
	AND	EAX,EDX
	MOV	BYTE [4+ECX],AL
	MOV	EDX,DWORD [8+EBP]
	MOV	AL,-1
	AND	EAX,DWORD [20+EBP]
	MOV	BYTE [5+EDX],AL
	MOV	ECX,DWORD [8+EBP]
	MOV	EAX,DWORD [12+EBP]
	MOV	EDX,EAX
	SAR	EDX,16
	MOV	EAX,-1
	AND	EAX,EDX
	MOV	WORD [6+ECX],AX
	POP	EBP
	RET
