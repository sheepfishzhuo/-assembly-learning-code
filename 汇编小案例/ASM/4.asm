;输入一个字符并显示输出
DATA SEGMENT
    CHARTER DB ?
    DILF DB 0AH
DATA ENDS
CODE SEGMENT
    ASSUME CS:CODE,DS:DATA
START:
    MOV AX,DATA
    MOV DS,AX
    MOV AH,01H
    INT 21H
    MOV CHARTER,AL
    MOV DL,DILF
    MOV AH,02H
    INT 21H
    MOV DL,CHARTER
    MOV AH,02H
    INT 21H
    MOV AH,4CH
    INT 21H
CODE ENDS
END START