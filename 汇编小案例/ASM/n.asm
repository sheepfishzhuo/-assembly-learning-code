DATA SEGMENT
    A DW  0
    COUNT DW 0    
DATA ENDS

STACK SEGMENT
    DB 100 DUP(?)
STACK ENDS

CODE SEGMENT
    ASSUME CS:CODE,DS:DATA,SS:STACK
START:
	mov AX,DATA
    mov DS,AX
    push BX
    push CX
    push DX
    xor BX,BX   ;BX保存结果
    xor CX,CX   ;CX为正负标志，0为正，－1为负
    mov AH,1
    int 21H
    cmp AL,'+'
    jz S1
    cmp AL,'-'
    jnz S2
    mov CX,-1
S1: mov AH,1
    int 21h
S2: cmp AL,'0'
    jb S3
    cmp AL,'9'
    ja S3
    sub AL,30h
    xor AH,AH
    shl BX,1
    mov DX,DX
    shl BX,1
    shl BX,1
    add BX,DX
    add BX,AX
    jmp S1
S3: cmp CX,0
    jz S4
    neg BX
S4: mov AX,BX
    pop DX
    pop CX
    pop BX
	mov A,AX

    
    MOV AX,A    
    MOV CX,10   ;CX存储进制数
    CMP AX,0    ;判断该带符号数是正数还是负数
    JL L2       ;若该带符号数为负数跳转到L2处

    
L1: XOR DX,DX   ;将DX初始化
    IDIV CX     ;(AX)<-(DX,AX)/(10)的商,(DX)<-(DX,AX)/(10)的余数
    PUSH DX    	;余数入栈（该带符号数从低位向高位依次入栈）
    INC COUNT	;记录栈中数据个数
    CMP AX,0    ;判断商是否大于零
    JNE L1		;若商大于零就循环执行入栈操作,把该带符号数全部逆序入栈
    JMP L5		;该带符号数循环入栈后无条件跳转到L5处
    
L2: NEG AX      ;判断为负数，则先求补，再进行和正数一样进行处理

L3: XOR DX,DX   ;将DX初始化
    IDIV CX	    ;(AX)<-(DX,AX)/(10)的商,(DX)<-(DX,AX)/(10)的余数       
    PUSH DX     ;余数入栈（该带符号数从低位向高位依次入栈）    
    INC COUNT	;记录栈中数据个数+1
    CMP AX,0	;判断商是否大于零
    JNE L3		;若商大于零就循环执行入栈操作,把该带符号数全部逆序入栈
    JMP L4		;该带符号数循环入栈后无条件跳转到L4处


L4: MOV DL,'-'  ;如果判断为负数，输出数字前先输出一个负号
    MOV AH,2	;2号功能:显示输出DL中的内容
    INT 21H
	
L5: POP DX		;余数出栈（该带符号数从高位向低位依次出栈）
    ADD DX,30H	;将各位数转换为所对应的ASCII码
    
    DEC COUNT	;记录栈中数据个数-1
    CMP COUNT,0
    MOV AH,2	;循环输出该带符号数的绝对值
    INT 21H
    JNE L5
   
    MOV AH,4CH	;程序返回dos
    INT 21H
    
CODE ENDS
END START