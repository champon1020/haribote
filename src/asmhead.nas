; haribote-os
; TAB=4

[INSTRSET "i486p"]

VBMODE  EQU     0x105
; Display mode list
;	0x100 :  640 x  400 x 8bit
;	0x101 :  640 x  480 x 8bit
;	0x103 :  800 x  600 x 8bit
;	0x105 : 1024 x  768 x 8bit
;	0x107 : 1280 x 1024 x 8bit    
    
BOTPAK  EQU     0x00280000  ; load destination of bootpack
DSKCAC  EQU     0x00100000  ; disc cache
DSKCAC0 EQU     0x00008000  ; disc cache (real mode)

CYLS    EQU     0x0ff0      ; boot sector
LEDS    EQU     0x0ff1
VMODE   EQU     0x0ff2      ; number of colors
SCRNX   EQU     0x0ff4      ; resolution x
SCRNY   EQU     0x0ff6      ; resolution y
VRAM    EQU     0x0ff8      ; start address of graphic buffer

        ORG     0xc200      ; address of this program

;;  VBE validation

    MOV     AX,0x9000
    MOV     ES,AX
    MOV     DI,0
    MOV     AX,0x4f00
    INT     0x10
    CMP     AX,0x004f
    JNE     scrn320

;; VBE version check

    MOV     AX,[ES:DI+4]
    CMP     AX,0x0200
    JB      scrn320

;; Get information of display mode

    MOV     CX,VBEMODE
    MOV     AX,0x4f01
    INT     0x10
    CMP     AX,0x004f
    JNE     scrn320

;; Confirmation of display mode

    CMP     BYTE [ES:DI+0x19],8
    JNE     scrn320
    CMP     BYTE [ES:DI+0x1b],4
    JNE     scrn320
    MOV     AX,[ES:DI+0x00]
    AND     AX,0x0080
    JZ      scrn320

;; Swith display mode

    MOV     BX,VBEMODE+0x4000
    MOV     AX,0x4f02  
    INT     0x10
    MOV     BYTE [VMODE],8
    MOV     AX,[ES:DI+0x12]
    MOV     [SCRNX],AX
    MOV     AX,[ES:DI+0x14]    
    MOV     [SCRNY],AX
    MOV     EAX,[ES:DI+0x28]
    MOV     [VRAM],EAX
    JMP     keystatus

scrn320:
    MOV     AL,0x13
    MOV     AH,0x00
    INT     0x10
    MOV     BYTE [VMODE],8
    MOV     WORD [SCRNX],320
    MOV     WORD [SCRNY],200
    MOV     DWORD [VRAM],0x000a0000

; LED state of keyboard

keystatus:
    MOV     AH,0x02
    INT     0x16
    MOV     [LEDS],AL

; I don't know about following codes...

        MOV     AL,0xff
        OUT     0x21,AL
        NOP
        OUT     0xa1,AL

        CLI

        CALL    waitkbdout
        MOV     AL,0xd1
        OUT     0x64,AL
        CALL    waitkbdout
        MOV     AL,0xdf
        OUT     0x60,AL
        CALL    waitkbdout

[INSTRSET "i486p"]

        LGDT    [GDTR0]
        MOV     EAX,CR0
        AND     EAX,0x7fffffff
        OR      EAX,0x00000001
        MOV     CR0,EAX
        JMP     pipelineflush
pipelineflush:
        MOV     AX,1*8
        MOV     DS,AX
        MOV     ES,AX
        MOV     FS,AX
        MOV     GS,AX
        MOV     SS,AX

; transport bootpack

        MOV     ESI,bootpack
        MOV     EDI,BOTPAK
        MOV     ECX,512*1024/4
        CALL    memcpy

        MOV     ESI,0x7c00
        MOV     EDI,DSKCAC
        MOV     ECX,512/4
        CALL    memcpy

        MOV     ESI,DSKCAC0+512
        MOV     EDI,DSKCAC+512
        MOV     ECX,0
        MOV     CL,BYTE [CYLS]
        IMUL    ECX,512*18*2/4
        SUB     ECX,512/4
        CALL    memcpy

; start bootpack

        MOV     EBX,BOTPAK
        MOV     ECX,[EBX+16]
        ADD     ECX,3
        SHR     ECX,2
        JZ      skip
        MOV     ESI,[EBX+20]
        ADD     ESI,EBX
        MOV     EDI,[EBX+12]
        CALL    memcpy
skip:
        MOV     ESP,[EBX+12]
        JMP     DWORD 2*8:0x0000001b

waitkbdout:
        IN      AL,0x64
        AND     AL,0x02
        JNZ     waitkbdout
        RET

memcpy:
        MOV     EAX,[ESI]
        ADD     ESI,4
        MOV     [EDI],EAX
        ADD     EDI,4
        SUB     ECX,1
        JNZ     memcpy
        RET

        ALIGNB  16

GDT0:
        RESB    8
        DW      0xffff,0x0000,0x9200,0x00cf
        DW      0xffff,0x0000,0x9a28,0x0047

        DW      0
GDTR0:
        DW      8*3-1
        DD      GDT0

        ALIGNB  16

bootpack:
