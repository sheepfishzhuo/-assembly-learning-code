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
    xor BX,BX   ;BX保存结果，所以使用前给它清零
    xor CX,CX   ;CX存正负标志，所以使用前给它清零（正数为0，负数为-1）
;—————————————————————————第一步：存入数据——————————————————————————————
    mov AH,1    ;输入符号（调用1号功能:键盘输入，返回参数：AL）
    int 21H
    cmp AL,'+'  ;（此处解决输入正数时没有省略加号的情况）
    jz S1       ;若输入的是正数就跳转到S1
    cmp AL,'-'
    jnz S2      ;若输入的不是负数（没有带负号的数）就跳转到S2（此处解决输入正数时省略加号的情况）
    mov CX,-1   ;若输入的是负数，CX中置-1

S1: mov AH,1    ;输入数据
    int 21h

S2: cmp AL,0dh  
    jz S3       ;判断输入的是否为回车，若为回车就跳转到S3
    sub AL,30h  ;算出输入的真实数据（？-30h）并存入AX的低8位
    xor AH,AH   ;AX的高8位置0
    shl BX,1    ;假设第一次输入的数据为x，第二次输入的数据为y
    mov DX,BX   ;                   .
    shl BX,1    ;                   .
    shl BX,1    ;                   .
    add BX,DX   ;                   .
    add BX,AX   ;那么经过上面这几步计算最终存入BX的数据格式为10x+y
    jmp S1      ;循环输入直至输入回车中止循环

S3: cmp CX,0
    jz S4       ;判断输入完整数据后该数据的正负情况，若为正数就跳转到S4
    neg BX      ;若为负数要先对其求补，再执行S4

S4: mov A,BX    ;将BX中的数据存入A变量
;—————————————————————————第二步：显示数据——————————————————————————————
    mov AX,A    ;将A变量中的数据存入AX
    mov CX,10   ;CX存储进制数
    cmp AX,0    ;判断该带符号数是正数还是负数
    jl L2       ;若该带符号数为负数跳转到L2处

    
L1: xor DX,DX   ;将DX初始化，DX置0
    idiv CX     ;(AX)<-(DX,AX)/(10)的商,(DX)<-(DX,AX)/(10)的余数
    push DX    	;余数入栈（该带符号数从低位向高位依次入栈）
    inc COUNT	;记录栈中数据个数+1
    cmp AX,0    ;判断商是否大于零
    jne L1		;若商大于零就循环执行入栈操作,把该带符号数全部逆序入栈
    jmp L5		;该带符号数循环入栈后无条件跳转到L5处
    
L2: neg AX      ;判断为负数，则先求补，再进行和正数一样进行处理

L3: xor DX,DX   ;将DX初始化
    idiv CX	    ;(AX)<-(DX,AX)/(10)的商,(DX)<-(DX,AX)/(10)的余数       
    push DX     ;余数入栈（该带符号数从低位向高位依次入栈）    
    inc COUNT	;记录栈中数据个数+1
    cmp AX,0	;判断商是否大于零
    jne L3		;若商大于零就循环执行入栈操作,把该带符号数全部逆序入栈
    jmp L4		;该带符号数循环入栈后无条件跳转到L4处


L4: mov DL,'-'  ;如果判断为负数，输出数字前先输出一个负号
    mov AH,2	;2号功能:显示输出DL中的内容
    int 21H
	
L5: pop DX		;余数出栈（该带符号数从高位向低位依次出栈）
    add DX,30H	;将各位数转换为所对应的ASCII码
    
    dec COUNT	;记录栈中数据个数-1
    cmp COUNT,0 ;确保数据全部出栈
    mov AH,2	;循环输出该带符号数的绝对值
    int 21H
    jne L5      ;循环执行出栈操作
   
    mov AH,4CH	;程序返回dos
    int 21H
    
CODE ENDS
END START