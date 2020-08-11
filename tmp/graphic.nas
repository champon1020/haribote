[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_hankaku
	EXTERN	_io_load_eflags
	EXTERN	_io_cli
	EXTERN	_io_out8
	EXTERN	_io_store_eflags
[FILE "graphic.c"]
[SECTION .text]
	ALIGN	2
	GLOBAL	_boxfill8
_boxfill8:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,12
	MOV	EAX,DWORD [16+EBP]
	MOV	BYTE [-1+EBP],AL
	MOV	EAX,DWORD [24+EBP]
	MOV	DWORD [-12+EBP],EAX
L2:
	MOV	EAX,DWORD [-12+EBP]
	CMP	EAX,DWORD [32+EBP]
	JLE	L5
	JMP	L1
L5:
	MOV	EAX,DWORD [20+EBP]
	MOV	DWORD [-8+EBP],EAX
L6:
	MOV	EAX,DWORD [-8+EBP]
	CMP	EAX,DWORD [28+EBP]
	JLE	L9
	JMP	L4
L9:
	MOV	EAX,DWORD [-12+EBP]
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,DWORD [-8+EBP]
	MOV	EDX,EAX
	ADD	EDX,DWORD [8+EBP]
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
	LEA	EAX,DWORD [-8+EBP]
	INC	DWORD [EAX]
	JMP	L6
L4:
	LEA	EAX,DWORD [-12+EBP]
	INC	DWORD [EAX]
	JMP	L2
L1:
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_putfont8
_putfont8:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,16
	MOV	EAX,DWORD [24+EBP]
	MOV	BYTE [-1+EBP],AL
	MOV	DWORD [-8+EBP],0
L11:
	CMP	DWORD [-8+EBP],15
	JLE	L14
	JMP	L10
L14:
	MOV	EAX,DWORD [-8+EBP]
	ADD	EAX,DWORD [20+EBP]
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,DWORD [8+EBP]
	ADD	EAX,DWORD [16+EBP]
	MOV	DWORD [-12+EBP],EAX
	MOV	EAX,DWORD [-8+EBP]
	ADD	EAX,DWORD [28+EBP]
	MOV	AL,BYTE [EAX]
	MOV	BYTE [-13+EBP],AL
	MOV	AL,-128
	AND	AL,BYTE [-13+EBP]
	TEST	AL,AL
	JE	L15
	MOV	EDX,DWORD [-12+EBP]
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L15:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,64
	TEST	AL,AL
	JE	L16
	MOV	EDX,DWORD [-12+EBP]
	INC	EDX
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L16:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,32
	TEST	AL,AL
	JE	L17
	MOV	EDX,DWORD [-12+EBP]
	ADD	EDX,2
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L17:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,16
	TEST	AL,AL
	JE	L18
	MOV	EDX,DWORD [-12+EBP]
	ADD	EDX,3
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L18:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,8
	TEST	AL,AL
	JE	L19
	MOV	EDX,DWORD [-12+EBP]
	ADD	EDX,4
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L19:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,4
	TEST	AL,AL
	JE	L20
	MOV	EDX,DWORD [-12+EBP]
	ADD	EDX,5
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L20:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,2
	TEST	AL,AL
	JE	L21
	MOV	EDX,DWORD [-12+EBP]
	ADD	EDX,6
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L21:
	MOV	AL,BYTE [-13+EBP]
	AND	EAX,1
	TEST	AL,AL
	JE	L13
	MOV	EDX,DWORD [-12+EBP]
	ADD	EDX,7
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L13:
	LEA	EAX,DWORD [-8+EBP]
	INC	DWORD [EAX]
	JMP	L11
L10:
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_putfonts8_asc
_putfonts8_asc:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	MOV	EAX,DWORD [24+EBP]
	MOV	BYTE [-1+EBP],AL
L24:
	MOV	EAX,DWORD [28+EBP]
	CMP	BYTE [EAX],0
	JNE	L27
	JMP	L23
L27:
	SUB	ESP,8
	MOV	EAX,DWORD [28+EBP]
	MOV	AL,BYTE [EAX]
	AND	EAX,255
	SAL	EAX,4
	ADD	EAX,_hankaku
	PUSH	EAX
	MOVSX	EAX,BYTE [-1+EBP]
	PUSH	EAX
	PUSH	DWORD [20+EBP]
	PUSH	DWORD [16+EBP]
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_putfont8
	ADD	ESP,32
	LEA	EAX,DWORD [16+EBP]
	ADD	DWORD [EAX],8
	LEA	EAX,DWORD [28+EBP]
	INC	DWORD [EAX]
	JMP	L24
L23:
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_putblock8_8
_putblock8_8:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	MOV	DWORD [-8+EBP],0
L29:
	MOV	EAX,DWORD [-8+EBP]
	CMP	EAX,DWORD [20+EBP]
	JL	L32
	JMP	L28
L32:
	MOV	DWORD [-4+EBP],0
L33:
	MOV	EAX,DWORD [-4+EBP]
	CMP	EAX,DWORD [16+EBP]
	JL	L36
	JMP	L31
L36:
	MOV	EAX,DWORD [-8+EBP]
	ADD	EAX,DWORD [28+EBP]
	IMUL	EAX,DWORD [12+EBP]
	ADD	EAX,DWORD [24+EBP]
	ADD	EAX,DWORD [-4+EBP]
	MOV	EDX,EAX
	ADD	EDX,DWORD [8+EBP]
	MOV	EAX,DWORD [-8+EBP]
	IMUL	EAX,DWORD [36+EBP]
	ADD	EAX,DWORD [-4+EBP]
	ADD	EAX,DWORD [32+EBP]
	MOV	AL,BYTE [EAX]
	MOV	BYTE [EDX],AL
	LEA	EAX,DWORD [-4+EBP]
	INC	DWORD [EAX]
	JMP	L33
L31:
	LEA	EAX,DWORD [-8+EBP]
	INC	DWORD [EAX]
	JMP	L29
L28:
	LEAVE
	RET
[SECTION .data]
_table_rgb.0:
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	0
	DB	0
	DB	-1
	DB	-1
	DB	0
	DB	-1
	DB	0
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-1
	DB	-58
	DB	-58
	DB	-58
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	0
	DB	0
	DB	0
	DB	100
	DB	-124
	DB	0
	DB	-124
	DB	0
	DB	-124
	DB	-124
	DB	-124
	DB	-124
	DB	-124
[SECTION .text]
	ALIGN	2
	GLOBAL	_init_palette
_init_palette:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	SUB	ESP,4
	PUSH	_table_rgb.0
	PUSH	15
	PUSH	0
	CALL	_set_palette
	ADD	ESP,16
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_set_palette
_set_palette:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	CALL	_io_load_eflags
	MOV	DWORD [-8+EBP],EAX
	CALL	_io_cli
	SUB	ESP,8
	PUSH	DWORD [8+EBP]
	PUSH	968
	CALL	_io_out8
	ADD	ESP,16
	MOV	EAX,DWORD [8+EBP]
	MOV	DWORD [-4+EBP],EAX
L39:
	MOV	EAX,DWORD [-4+EBP]
	CMP	EAX,DWORD [12+EBP]
	JLE	L42
	JMP	L40
L42:
	SUB	ESP,8
	MOV	EAX,DWORD [16+EBP]
	MOV	AL,BYTE [EAX]
	SHR	AL,2
	AND	EAX,255
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	MOV	EAX,DWORD [16+EBP]
	INC	EAX
	MOV	AL,BYTE [EAX]
	SHR	AL,2
	AND	EAX,255
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	ADD	ESP,16
	SUB	ESP,8
	MOV	EAX,DWORD [16+EBP]
	ADD	EAX,2
	MOV	AL,BYTE [EAX]
	SHR	AL,2
	AND	EAX,255
	PUSH	EAX
	PUSH	969
	CALL	_io_out8
	ADD	ESP,16
	LEA	EAX,DWORD [16+EBP]
	ADD	DWORD [EAX],3
	LEA	EAX,DWORD [-4+EBP]
	INC	DWORD [EAX]
	JMP	L39
L40:
	SUB	ESP,12
	PUSH	DWORD [-8+EBP]
	CALL	_io_store_eflags
	ADD	ESP,16
	LEAVE
	RET
	ALIGN	2
	GLOBAL	_init_screen
_init_screen:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,8
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,29
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	DEC	EAX
	PUSH	EAX
	PUSH	0
	PUSH	0
	PUSH	14
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,28
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	DEC	EAX
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,28
	PUSH	EAX
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,27
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	DEC	EAX
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,27
	PUSH	EAX
	PUSH	0
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	DEC	EAX
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	DEC	EAX
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,26
	PUSH	EAX
	PUSH	0
	PUSH	8
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	PUSH	59
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	PUSH	3
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	PUSH	2
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	PUSH	2
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	PUSH	59
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	PUSH	3
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,5
	PUSH	EAX
	PUSH	59
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,23
	PUSH	EAX
	PUSH	59
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,3
	PUSH	EAX
	PUSH	59
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,3
	PUSH	EAX
	PUSH	2
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,3
	PUSH	EAX
	PUSH	60
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	PUSH	60
	PUSH	0
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,4
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,47
	PUSH	EAX
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,4
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,47
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,23
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,47
	PUSH	EAX
	PUSH	15
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,3
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,4
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,3
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,47
	PUSH	EAX
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	SUB	ESP,4
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,3
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,3
	PUSH	EAX
	MOV	EAX,DWORD [16+EBP]
	SUB	EAX,24
	PUSH	EAX
	MOV	EAX,DWORD [12+EBP]
	SUB	EAX,3
	PUSH	EAX
	PUSH	7
	PUSH	DWORD [12+EBP]
	PUSH	DWORD [8+EBP]
	CALL	_boxfill8
	ADD	ESP,32
	LEAVE
	RET
[SECTION .data]
_cursor.1:
	DB	"**************.."
	DB	"*OOOOOOOOOOO*..."
	DB	"*OOOOOOOOOO*...."
	DB	"*OOOOOOOOO*....."
	DB	"*OOOOOOOO*......"
	DB	"*OOOOOOO*......."
	DB	"*OOOOOOO*......."
	DB	"*OOOOOOOO*......"
	DB	"*OOOO**OOO*....."
	DB	"*OOO*..*OOO*...."
	DB	"*OO*....*OOO*..."
	DB	"*O*......*OOO*.."
	DB	"**........*OOO*."
	DB	"*..........*OOO*"
	DB	"............*OO*"
	DB	".............***"
[SECTION .text]
	ALIGN	2
	GLOBAL	_init_mouse_cursor8
_init_mouse_cursor8:
	PUSH	EBP
	MOV	EBP,ESP
	SUB	ESP,12
	MOV	EAX,DWORD [12+EBP]
	MOV	BYTE [-1+EBP],AL
	MOV	DWORD [-12+EBP],0
L45:
	CMP	DWORD [-12+EBP],15
	JLE	L48
	JMP	L44
L48:
	MOV	DWORD [-8+EBP],0
L49:
	CMP	DWORD [-8+EBP],15
	JLE	L52
	JMP	L47
L52:
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,4
	ADD	EAX,DWORD [-8+EBP]
	ADD	EAX,_cursor.1
	CMP	BYTE [EAX],42
	JNE	L53
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,4
	ADD	EAX,DWORD [-8+EBP]
	ADD	EAX,DWORD [8+EBP]
	MOV	BYTE [EAX],0
L53:
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,4
	ADD	EAX,DWORD [-8+EBP]
	ADD	EAX,_cursor.1
	CMP	BYTE [EAX],79
	JNE	L54
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,4
	ADD	EAX,DWORD [-8+EBP]
	ADD	EAX,DWORD [8+EBP]
	MOV	BYTE [EAX],7
L54:
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,4
	ADD	EAX,DWORD [-8+EBP]
	ADD	EAX,_cursor.1
	CMP	BYTE [EAX],46
	JNE	L51
	MOV	EAX,DWORD [-12+EBP]
	SAL	EAX,4
	ADD	EAX,DWORD [-8+EBP]
	MOV	EDX,EAX
	ADD	EDX,DWORD [8+EBP]
	MOV	AL,BYTE [-1+EBP]
	MOV	BYTE [EDX],AL
L51:
	LEA	EAX,DWORD [-8+EBP]
	INC	DWORD [EAX]
	JMP	L49
L47:
	LEA	EAX,DWORD [-12+EBP]
	INC	DWORD [EAX]
	JMP	L45
L44:
	LEAVE
	RET