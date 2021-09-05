;INCLUDE Irvine32.inc

 

ARRAY_SIZE = 20

str_SIZE = 8

;数据段

.data    

str1 BYTE "Please enter the number of data to be read: ", 0

str2 BYTE "Sort from smallest to biggest: ", 0                         

str3 BYTE "Please enter the data you are looking for:", 0

str4 BYTE "Find the index of the element:", 0                         

str5 BYTE "Find the failure, Without the data.", 0      

str6 BYTE "Please enter data:", 0                      

array DWORD ARRAY_SIZE DUP(?)

str_data BYTE str_SIZE DUP(?)

;代码段

.code

main PROC

       call Clrscr

       call ArrayLength

       mov  esi, OFFSET array

       mov  ecx, eax                  

       push eax

       call Read_data

       pop  eax

       mov  ecx, eax

       push ecx

       call Sort_data

       pop  ecx

       mov  eax, ecx

       push eax

       call show_data

       call Crlf

       pop  ecx

       call serch_data

       call Crlf

       exit

main ENDP

 

ArrayLength:

       mov  edx, OFFSET str1

       call WriteString

       call ReadInt           ; read array length into eax

       ret

;ArrayLength end

;读取数据

Read_data:

       mov  edx, OFFSET str6 ; "Please enter data:?

L1: call WriteString

       call ReadInt

       Call Crlf

       mov [esi], eax          ; store data in array

       add  esi, TYPE DWORD

       loop L1

       ret

;Read_data end

;排序

Sort_data:

       mov  esi, OFFSET array

;      mov  eax, OFFSET array                  

;      mov  ds,  eax

       dec  ecx

OUTER:

       mov  eax, [esi]

       push ecx

       mov  edi,  esi

INNER:

       add  edi, TYPE DWORD

       mov  edx, [edi]

       cmp  eax, edx

       jle  CONT

       xchg eax, edx                     ; SWAP (BUF[SI], BUF[DI])

       mov  [esi], eax

       mov  [edi], edx

CONT:

       loop INNER

       pop  ecx

       add  esi, TYPE DWORD

       loop OUTER

       ret

;Sort_data end

;显示排序之后的结果

show_data:

       mov  edx, OFFSET str2   ; "sort from smallest to biggest"

       call WriteString

       mov  esi, OFFSET array

L3:  call Crlf

       mov  eax, [esi]

       mov  edx, eax

       call WriteInt

       add  esi, TYPE DWORD

       loop L3

       ret

;查询指定的数据

serch_data:

       mov  edx, OFFSET str3   ;"Please enter the data you are looking for:"

       call WriteString

       call ReadInt           ; read data  into eax

       mov  esi, OFFSET array

       mov  ebx, ecx

       push ebx

L4:  mov  ebx, [esi]

       cmp  eax, ebx

       jz   find_data

       add  esi, TYPE DWORD

       loop L4

       mov  edx,  OFFSET str5    ; "Find the failure, Without the data."

       call WriteString

       call Crlf

       exit

      

find_data:

       mov  edx, OFFSET str4    ;"Find the index of the element:"

       call WriteString

       mov  esi, OFFSET str_data

 

       pop  eax

       sub  eax, ecx

       mov  edx, eax

       call WriteInt

       call Crlf

       mov  ecx, 8d

L5: shl  al,  1

       jc   bin_Fuc

       mov  byte ptr [esi], '0'

       inc  esi

       loop L5

       jmp  final

bin_Fuc:

       mov  byte ptr [esi], '1'

       inc  esi

       dec  ecx

       cmp  ecx, 0

       jnz  L5

final:

       mov  edx, OFFSET str_data

       call WriteString

       call Crlf

       exit

END main
————————————————
版权声明：本文为CSDN博主「FLy_鹏程万里」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/Fly_hps/article/details/84761311