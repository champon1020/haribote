[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_io_out8
	EXTERN	_io_in8
	EXTERN	_sprintf
	EXTERN	_boxfill8
	EXTERN	_putfonts8_asc
	EXTERN	_io_hlt
[FILE "int.c"]
[SECTION .text]
	ALIGN	2
	GLOBAL	_init_pic
_init_pic:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	SUB	ESP,8
	PUSH	255
	PUSH	33
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	255
	PUSH	161
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	17
	PUSH	32
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	32
	PUSH	33
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	4
	PUSH	33
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	1
	PUSH	33
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	17
	PUSH	160
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	40
	PUSH	161
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	2
	PUSH	161
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	1
	PUSH	161
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	251
	PUSH	33
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	PUSH	255
	PUSH	161
	CALL	_io_out8
	ADD	ESP,16
	LEAVE
	RET
[SECTION .data]
LC0:
	DB	"%02X",0x00
[SECTION .text]
	ALIGN	2
	GLOBAL	_inthandler21
_inthandler21:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,24
	MOV	DWORD [-4+EBP],4080
	SUB	ESP,8
	PUSH	97
	PUSH	32
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,12
	PUSH	96
	CALL	_io_in8
	ADD	ESP,16
	MOV	BYTE [-5+EBP],AL
	SUB	ESP,4
	MOV	EAX,0
	MOV	AL,BYTE [-5+EBP]
	PUSH	EAX
	PUSH	LC0
	LEA	EAX,DWORD [-12+EBP]
	PUSH	EAX
	CALL	_sprintf
	ADD	ESP,16
	SUB	ESP,4
	PUSH	31
	PUSH	15
	PUSH	16
	PUSH	0
	PUSH	14
	MOV	EAX,DWORD [-4+EBP]
	MOVSX	EAX,WORD [4+EAX]
	PUSH	EAX
	MOV	EAX,DWORD [-4+EBP]
	PUSH	DWORD [8+EAX]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,8
	LEA	EAX,DWORD [-12+EBP]
	PUSH	EAX
	PUSH	7
	PUSH	16
	PUSH	0
	MOV	EAX,DWORD [-4+EBP]
	MOVSX	EAX,WORD [4+EAX]
	PUSH	EAX
	MOV	EAX,DWORD [-4+EBP]
	PUSH	DWORD [8+EAX]
	CALL	_putfonts8_asc
	ADD	ESP,32
	LEAVE
	RET
[SECTION .data]
LC1:
	DB	"INT 2c (TRQ-12) : PS/2 mouse",0x00
[SECTION .text]
	ALIGN	2
	GLOBAL	_inthandler2c
_inthandler2c:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	MOV	DWORD [-4+EBP],4080
	SUB	ESP,4
	PUSH	15
	PUSH	255
	PUSH	0
	PUSH	0
	PUSH	0
	MOV	EAX,DWORD [-4+EBP]
	MOVSX	EAX,WORD [4+EAX]
	PUSH	EAX
	MOV	EAX,DWORD [-4+EBP]
	PUSH	DWORD [8+EAX]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,8
	PUSH	LC1
	PUSH	7
	PUSH	0
	PUSH	0
	MOV	EAX,DWORD [-4+EBP]
	MOVSX	EAX,WORD [4+EAX]
	PUSH	EAX
	MOV	EAX,DWORD [-4+EBP]
	PUSH	DWORD [8+EAX]
	CALL	_putfonts8_asc
	ADD	ESP,32
	CALL	_io_hlt
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_inthandler27
_inthandler27:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	SUB	ESP,8
	PUSH	103
	PUSH	32
	CALL	_io_out8
	ADD	ESP,16
	LEAVE
	RET
