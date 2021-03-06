DATA SEGMENT
    X DW -40
    Y DW 50
    SUM DW 0
    NUM DW 0
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV AX,X
    CMP AX,0
    JNL L1
    NEG AX
L1:
    MOV BX,AX
    MOV AX,Y
    CMP AX,0
    JNL L2
    NEG AX
L2:
    ADD BX,AX
    MOV SUM,BX

    MOV AX,SUM

L3:
    XOR DX,DX
    MOV CX,10
    IDIV CX
    PUSH DX
    INC NUM
    CMP AX,0
    JNE L3
L4:
    POP DX
    ADD DX,30H
    DEC NUM
    CMP NUM,0
    MOV AH,02H
    INT 21H
    JNE L4
    MOV AH,4CH
    INT 21H
CODE ENDS
END START