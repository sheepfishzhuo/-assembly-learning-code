DATA SEGMENT
    MAX_SIZE DB 13
    REAL_SIZE DB ?
    STRING DB 13 DUP(?)
    DILF DB 0AH,0DH,'$'
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    LEA DX,MAX_SIZE
    MOV AH,0AH
    INT 21H
    LEA BX,STRING
    ADD BL,REAL_SIZE
    ADC BH,0
    MOV BYTE PTR [BX],20H
    LEA DX,DILF
    MOV AH,09H
    INT 21H
    LEA DX,STRING
    MOV AH,09H
    INT 21H
    MOV AH,4CH
    INT 21H
CODE ENDS
END START