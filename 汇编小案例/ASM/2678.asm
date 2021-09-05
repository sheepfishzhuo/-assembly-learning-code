;将bx中的有符号数以十进制的形式输出,即输出范围为-32768到32767，思路很简单
;0-32767的输出方式沿用上面输出无符号数的代码，-32768到-1的代码输出时加个负号再减就okk
;而负数段='-'+(65536-被操作数)
;而汇编中提供了NEG指令来处理【65536-被操作数】这个操作，所以处理负数之前只要将被操作数neg一下就好了

DATAS SEGMENT
    A DW  79D
    COUNT DW 0    
DATAS ENDS

STACKS SEGMENT
    DB 100 DUP(?)
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
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
    MOV AH,2
    INT 21H
    JNE L5
   
    MOV AH,4CH
    INT 21H
    
CODES ENDS
    END START
