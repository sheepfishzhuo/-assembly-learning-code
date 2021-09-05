CODE SEGMENT
    ASSUME CS:CODE
MAIN PROC FAR
START:
    PUSH DS
    SUB AX,AX
    PUSH AX
REPEAT:
    CALL HEXIBIN
    ;CALL CRLF
    CALL BINIDEC
    ;CALL CRLF
    RET
MAIN ENDP
HEXIBIN PROC NEAR
    MOV BX,0
NEWCHAR:
    MOV AH,1
    INT 21H
    SUB AL,30H
    JL EXIT
    CMP AL,10
    JL ADD_TO
    SUB AL,07H
    CMP AL,0AH
    JL EXIT
    CMP AL,10H
    JGE EXIT
ADD_TO:
    MOV CL,4
    SHL BX,CL
    MOV AH,0
    ADD BX,AX
    JMP NEWCHAR
EXIT:
    RET
HEXIBIN ENDP
BINIDEC PROC NEAR
    MOV CX,10000D
    CALL DEC_DIV
    MOV CX,1000D
    CALL DEC_DIV
    MOV CX,100D
    CALL DEC_DIV
    MOV CX,10D
    CALL DEC_DIV
    MOV CX,1D
    CALL DEC_DIV
    RET
DEC_DIV PROC NEAR
    MOV AX,BX
    MOV DX,0
    DIV CX
    MOV BX,DX
    MOV DL,AL
    ADD DL,30H
    MOV AH,02H
    INT 21H
    RET
DEC_DIV ENDP
BINIDEC ENDP
CODE ENDS
END START