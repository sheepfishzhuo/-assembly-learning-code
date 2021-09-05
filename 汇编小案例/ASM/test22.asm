data segment
    numStr       db    4 dup(?),0ah,0dh,'$'
    msgOne       db    'Please input number:','$'
    msgFour      db    0ah,0dh,'The number is:','$'    
data ends
stack segment stack
    db    100 dup(?)
stack ends
code segment
    assume DS:data,CS:code,SS:stack
start:
    mov ax,data
    mov DS,ax
    lea dx,msgOne   ;输出msgOne
    mov ah,09h
    int 21h
    mov cx,4
    mov bx,0
inputNum: 
    mov ah,01h      ;从键盘输入一个字符,其ASCII存放在al中
    int 21h
    cmp al,'9'             
    jbe  inputRight
inputRight:         ;输入正确时的处理
    mov numStr[bx],al
    inc bx
    jmp continue
continue: 
    loop inputNum
    lea dx,msgFour  ;输出msgFour
    mov ah,09h
    int 21h;
    lea dx,numStr   ;输出numStr
    mov ah,09h
    int 21h 
    mov ah,4ch      ;程序结束
    int 21h
code ends
end start