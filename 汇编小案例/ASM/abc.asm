;从键盘输入一个有符号数，判断其正负，
;若为负数，在屏幕上显示“-”号，
;若为正数，则在屏幕上显示“+”号；若为0，则显示“0”，
;若输入的数据不是一个完整的有符号数，则显示“input error”；
ASSUME CS:CODE, DS:DATA
DATA SEGMENT
    OPT DB 13, 10, 'Please input data: $'
    OPT1 DB 13, 10, 'The result is: $'
    MSD2 DB 13, 10, 'Input error. $'
    MAX DB 10 ;计划输入的字符个数(含回车符)
    NNN DB 0 ;存放实际输入的字符个数
    BUF DB 10 DUP(?)
    FUH DB '+'
DATA ENDS
CODE SEGMENT
START:
    MOV AX, DATA
    MOV DS, AX
    MOV AH, 09H ;显示提示信息PLEASE INPUT DATA:
    MOV DX, OFFSET OPT
    INT 21H
    MOV AH, 0AH ;从键盘输入数据
    MOV DX, OFFSET MAX
    INT 21H
    MOV CL, NNN
    CMP CL, 0
    JZ EXIT
    MOV CH, 0
    MOV BX, 0
    LEA SI, BUF
    MOV AL, [SI]
    CMP AL, '+'
    JZ FU_HAO   ;当AL中存储字符的ASCII码等于'+'的ASCII码时跳转到FU_HAO
    CMP AL, '-'
    JZ FU_HAO   ;当AL中存储字符的ASCII码等于'-'的ASCII码时跳转到FU_HAO
    CMP AL, '0'
    JZ NEXT ;当AL中存储字符的ASCII码等于'0'的ASCII码时跳转到NEXT
    INC BX
    JMP NEXT
SSS:
    MOV AL, [SI]
    CMP AL, '0'
    JZ NEXT ;当AL中存储字符的ASCII码等于'0'的ASCII码时跳转到NEXT
    INC BX
NEXT:
    INC SI
    LOOP SSS
    JMP DISP
FU_HAO:
    MOV FUH, AL
    JMP NEXT
DISP:
    CMP BX, 0
    JNZ ZH_FU
    MOV FUH, '0'
ZH_FU:
    MOV AH, 09H ;显示提示信息THE RESULT IS:
    MOV DX, OFFSET OPT1
    INT 21H
    MOV DL, FUH
    MOV AH, 02H
    INT 21H
    JMP EXIT
NO:
    MOV AH, 09H ;显示提示信息
    MOV DX, OFFSET MSD2
    INT 21H
EXIT:
    MOV AH, 4CH ;返回DOS状态，固定结构
    INT 21H
CODE ENDS
END START