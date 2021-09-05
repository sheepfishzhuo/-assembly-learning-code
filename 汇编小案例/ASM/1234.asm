STACKS SEGMENT
    DB 100 DUP(?)
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,SS:STACKS
START:

    push bx
    push cx
    push dx
    xor bx,bx   ;BX保存结果
    xor cx,cx   ;CX为正负标志，0为正，－1为负
    mov ah,1
    int 21h
    cmp al,'+'
    jz rsiw1
    cmp al,'-'
    jnz rsiw2
    mov cx,-1
rsiw1: mov ah,1
    int 21h
rsiw2:    cmp al,'0'
    jb rsiw3
    cmp al,'9'
    ja rsiw3
    sub al,30h
    xor ah,ah
    shl bx,1
    mov dx,bx
    shl bx,1
    shl bx,1
    add bx,dx
    add bx,ax
    jmp rsiw1
rsiw3:cmp cx,0
    jz rsiw4
    neg bx
rsiw4:mov ax,bx
    pop dx
    pop cx
    pop bx

CODES ENDS
END START
