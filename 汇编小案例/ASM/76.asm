DATA SEGMENT
    X DW 2
    Y DW 5
    SUM DW 0,0,0,0
    NUM DW 0
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    JISUAN MACRO A,B,C
    PUSH AX
    MOV AX,A
    IMUL B
    MOV C,AX
    POP AX
    ENDM
    MOV BX,1
    JISUAN X,Y,SUM[BX]
    MOV AX,SUM[BX]
L1:
    XOR DX,DX
    MOV CX,10
    IDIV CX
    PUSH DX
    INC NUM
    CMP AX,0
    JNE L1
L2:
    POP DX
    ADD DX,30H
    DEC NUM
    CMP NUM,0
    MOV AH,02H
    INT 21H
    JNE L2
    MOV AH,4CH
    INT 21H
CODE ENDS
END START