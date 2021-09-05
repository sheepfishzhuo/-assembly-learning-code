data segment
    numStr       db    4 dup(?),0ah,0dh,'$'
    msgOne       db    'Please input four hexadecima:','$'
    msgTwo       db    'The corresponding binary is :','$'
    msgThree     db    0ah,0dh,'Input Error,Please this number again:','$'
    msgFour      db    0ah,0dh,'The four hexadecima is:','$'
    c16          dw    16;
    result       dw    0;     
data ends
myStack segment stack
    db    100 dup(?)
mystack ends
code segment
    assume DS:data,CS:code
start:
    mov ax,data;
    mov DS,ax;
    lea dx,msgOne;          输出msgOne
    mov ah,09h;
    int 21h;
    mov cx,4;
    mov bx,0;
inputNum: 
    mov ah,01h;             从键盘输入一个字符,其ASCII存放在al中
    int 21h;
    cmp al,'9'             
    jbe  inputRight
;furtherJudge:
    cmp al,'a'
    jae inputRight;
    jmp inputError;  
inputRight:;              输入正确是的处理
    mov numStr[bx],al;
    inc bx;
    jmp continue;
inputError:;              输入错误时的处理
    lea dx,msgThree;
    mov ah,09h;
    int 21h;
    inc cx; 
continue: 
    loop inputNum
    lea dx,msgFour;         输出msgFour
    mov ah,09h; 
    int 21h;
    lea dx,numStr;          输出numStr
    mov ah,09h;
    int 21h; 
    ;mov cx,4;
    ;mov bx,0;
    ;mov ax,0;
    ;mov result,0;
; tranToBinary:
;     call changeTwo;
;     shl result,1;
;     shl result,1;
;     shl result,1;
;     shl result,1;
;     mov al,numStr[bx];
;     add result,ax;
;     inc bx;
;     loop tranToBinary
  
; outTranToBinary:
;     lea dx,msgTwo;
;     mov ah,09h;
;     int 21h;
;     mov cx,16;
;printResult:
    ;shl result,1;
    ;jae printZero;
    ;mov dl,'1'
    ;jmp nextPrint;
;printZero:
    ;mov dl,'0'
;nextPrint:
    ;mov ah,02h;
    ;int 21h;
    ;loop printResult
  
  
  
    mov ah,4ch;             程序结束
    int 21h;

; change proc;              将小写字符转换为大写字符,若不是小写字母，则不做处理
;                           ;al中为要转换的小写字母,al返回相应的大写字母
;     cmp al,'A';
;     jb then;
;     cmp al,'Z';
;     ja then;
;     add al,20h;
; then:
;     ret;

; changeTwo proc;              将十六进制字符转换为十六进制
;                           ;numStr[bx]中保存要转换的十六进制字符
;     cmp numStr[bx],'0';
;     jb next
;     cmp numStr[bx],'9'
;     ja further
;     and numStr[bx],0fh;
;     jmp next;

; further:
;     cmp numStr[bx],'a'
;     jb next;
;     cmp numStr[bx],'f'
;     ja next;
  
;     sub numStr[bx],87; 
; next:
;     ret

code ends
end start