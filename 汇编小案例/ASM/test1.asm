;求X与Y两字节数据的绝对值的和，将结果送入Z并用debug调试结果

;数据段定义
DATA    SEGMENT
    x   DW  -40     ;定义x为两字节数据，其值为-40
    y   DW  50      ;定义y为两字节数据，其值为50
    z   DW  0       ;定义z为两字节数据，用于存储X与Y两字节数据的绝对值的和
DATA    ENDS
;栈段定义
; STACK   SEGMENT
;     DB 50  DUP(?) ;定义50个字节大小的空间，用‘？’填充（这个程序中可以不定义栈段）
; STACK   ENDS
;代码段定义
CODE    SEGMENT
    ASSUME CS:CODE,DS:DATA
START:  MOV AX,DATA
        MOV DS,AX   ;把数据段地址存放到数据段寄存器
    
        MOV AX,x    ;将x的值存放到AX寄存器
        CMP AX,0    ;比较指令,执行AX-0，此时标志寄存器中的标志位发生变化
        JGE DONE    ;若x>0，转移。大于或等于转移。当SF(符号标志位)和OF(溢出标志位)同号，或ZF＝1，则转移
        NEG AX      ;若x<0，对x取绝对值
    DONE: ADD z,AX  ;将AX寄存器中的值加到z中
    
        MOV BX,y    ;将y的值存放到BX寄存器
        CMP BX,0    ;比较指令,执行BX-0，此时标志寄存器中的标志位发生变化
        JGE DTWO    ;若y>0，转移。大于或等于转移。当SF(符号标志位)和OF(溢出标志位)同号，或ZF(零标志位)＝1，则转移
        NEG BX      ;若y<0，对y取绝对值
    DTWO: ADD z,BX  ;将BX寄存器中的值加到z中,从而实现x+y的过程，并将结果赋给z
    
        MOV AX,4C00H  ;返回dos,程序结束
        INT 21H
CODE ENDS
    END START