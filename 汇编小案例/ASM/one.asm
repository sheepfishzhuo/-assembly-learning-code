assume cs:code
code segment
    mov ax,0123H
    mov bx,0456H
    add ax,bx
    add ax,ax
    mov ax,4c00H
    INT 21H
code ends
end