;求X与Y两字节数据的绝对值的和，将结果送入Z并用debug调试结果
DATA    SEGMENT
    BUF DB 20
        DB ?
        DB 20 DUP(?)
    x   DW  0
    y   DW  0
    z   DW  0
DATA    ENDS
STACK   SEGMENT
    DB 50   DUP(?)
STACK   ENDS
CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:  
        

        MOV BX,DATA
        MOV DS,BX

        MOV AH,01
        INT 21H
        SUB AL,30H
        MOV DX,0
        MOV DL,AL
        MOV DH,0
        MOV x,DX
    
        MOV BX,x
        CMP BX,0    ;比较指令
        JGE DONE    ;X>0转移   
        NEG BX      ;求负数的绝对值
    DONE: ADD z,BX

        MOV AH,01
        INT 21H
        SUB AL,30H
        MOV DX,0
        MOV DL,AL
        MOV DH,0
        MOV y,DX


        MOV CX,y
        CMP CX,0
        JGE DTWO
        NEG CX
    DTWO: ADD z,CX
    
        MOV AH,4CH
        INT 21H
CODE ENDS
    END START