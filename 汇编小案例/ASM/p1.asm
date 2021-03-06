DATA SEGMENT
    ARRY DW 1,2,3,4,5,6,7,8,9,10
    COUNT DW ($-ARRY)/2
    SUM DW ?
    NUM DW 0
DATA ENDS
CODE SEGMENT
MAIN PROC FAR
    ASSUME CS:CODE,DS:DATA
    MOV AX,DATA
    MOV DS,AX
    CALL ARRYADD
    CALL PUT
    MOV AH,4CH
    INT 21H
MAIN ENDP
ARRYADD PROC NEAR
    PUSH SI
    PUSH AX
    PUSH BX
    PUSH CX
    LEA SI,ARRY
    MOV CX,COUNT
    XOR AX,AX
NEXT:
    ADD AX,[SI]
    ADD SI,2
    LOOP NEXT
    MOV SUM,AX  
    POP CX
    POP BX
    POP AX
    POP SI
    RET
ARRYADD ENDP
PUT PROC NEAR
    PUSH AX
    PUSH BX
    PUSH CX
    MOV AX,SUM
L1:
    MOV DX,0
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
    POP CX
    POP BX
    POP AX
    RET
PUT ENDP
CODE ENDS
END MAIN