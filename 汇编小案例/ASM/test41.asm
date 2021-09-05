EXTRAS SEGMENT
    
    assign macro num                            ;定义宏assign：给变量S5-S10赋0值
    s&num dw 0
    endm

    string macro num,text                       ;定义宏string：定义字符串变量msg1-msg6
    msg&num db 's&text = $'
    endm

    subgroup macro num,transfer,label           ;定义宏subgroup：成绩比较并跳转到各组求和部分
    cmp ax,num
    j&transfer label
    endm

    plus macro num                              ;定义宏plus：统计各组人数并跳转到输出部分
    inc s&num
    jmp addrr
    endm

    display macro num,text                      ;定义宏display：输出各组统计结果
    mov dx, offset msg&num
    mov ah,9
    int 21h
    mov ax,s&text
    add ax,30h
    mov dl,al
    mov ah,2
    int 21h
    mov dl,10
    mov ah,2
    int 21h
    endm

EXTRAS ENDS

DATAS SEGMENT  
    
    grade dw  76,69,84,90,53,88,99,63,100,80    ;此处存储成绩数据
    
    assign 5                                    ;assign宏调用
    assign 6
    assign 7
    assign 8
    assign 9
    assign 10

    string 1,5                                  ;string宏调用
    string 2,6
    string 3,7
    string 4,8
    string 5,9
    string 6,10

DATAS ENDS

CODES SEGMENT
    
    ASSUME CS:CODES,DS:DATAS,ES:EXTRAS

START:
    MOV ax,DATAS
    MOV DS,ax
    mov cx,10
    ;mov ax,y
    mov bx,offset grade
compare:
    mov ax,[bx]
    
    subgroup 60,l,five                          ;subgroup宏调用
    subgroup 70,l,six
    subgroup 80,l,seven
    subgroup 90,l,eight
    ;subgroup 95,ne,seven
    subgroup 100,ne,nine
    
    plus 10                                     ;plus宏调用
nine:
    plus 9
eight:
    plus 8
    ;plus 8
seven:
    plus 7
six:
    plus 6
five:
    plus 5
addrr:
    add bx,2
    loop compare

    display 1,5                                 ;display宏调用
    display 2,6
    display 3,7
    display 4,8
    display 5,9
    display 6,10

    MOV AH,4CH
    INT 21H

CODES ENDS
    END START