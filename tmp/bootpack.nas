[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_io_hlt
[FILE "bootpack.c"]
[SECTION .text]
	ALIGN	2
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	MOV	DWORD [-4+EBP],655360
L2:
	CMP	DWORD [-4+EBP],720895
	JLE	L5
	JMP	L3
L5:
	MOV	EAX,DWORD [-4+EBP]
	MOV	DWORD [-8+EBP],EAX
	MOV	EDX,DWORD [-8+EBP]
	MOV	AL,BYTE [-4+EBP]
	AND	EAX,15
	MOV	BYTE [EDX],AL
	LEA	EAX,DWORD [-4+EBP]
	INC	DWORD [EAX]
	JMP	L2
L3:
	CALL	_io_hlt
	LEAVE
	RET
