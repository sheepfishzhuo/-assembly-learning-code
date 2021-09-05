DATAS SEGMENT
S1 db 'INPUT NUMBERS:  $'
S2 db 'SORT RESULTS:   $'
N db ?   
ARRAY db 10 dup(?) 
DATAS ENDS
CODES SEGMENT
main proc far
	ASSUME DS:DATAS,CS:CODES
	push DS 
	xor AX,AX
	push AX
	mov AX,DATAS
	mov DS,AX
	lea DX ,S1
	mov AH,09h
	int 21h
	call input  
	call sortfun
	lea DX ,S2
	mov AH,09h
	int 21h   
	call output   
	ret   
main endp

input proc near
	mov DI,0
first:
	call start  
	mov ARRAY[DI],BL   
	inc DI  
	cmp DI,10   
	jl first
	ret
input endp

output proc near
	mov DI,0
mo:
	mov BL,ARRAY[DI]   
	call sort 
	call crlf   
	inc DI   
	cmp DI,10  
	jl mo
	ret
output endp

sortfun proc near
	push AX   
	push BX
	push CX
	mov CX,10    
	dec CX   
loop1:   
	mov DI,CX   
	mov BX,0
loop2:     
	mov AL,ARRAY[BX] 
	cmp AL,ARRAY[BX+1]  
	jle continue    
	xchg AL,ARRAY[BX+1]   
	mov ARRAY[BX],AL
continue:
	inc BX   
	loop loop2   
	mov CX,DI
	loop loop1  
	pop CX   
	pop BX
	pop AX
	ret
sortfun endp

crlf proc near
	push AX 
	push DX

	mov DL,32
	mov AH,2
	int 21h
	pop DX  
	pop AX
	ret
	crlf endp

start proc near
	push AX   
	push CX
	mov N,1
	mov BL,0   
new:    
	mov AH,1
	int 21h  
	cmp AL,2dh  
	je fu   
	sub AL,30h  
	jl exit    
	cmp AL,32 
	jl get   
	jmp exit  
get:       
	mov BH,BL   
	mov CL,3  
	shl BL,CL
	mov CL,1   
	shl BH,CL
	add BL,BH  
	add BL,AL  
	jmp new  
fu:   
	mov N,-1
	jmp new
exit:
	cmp N,0  
	jg next
	neg BL
next:
	pop CX
	pop AX
	ret
start endp


sort proc near
	push AX    
	push CX
	push DX
	cmp BL,0   
	jge sign1
	mov DL,2dh   
	mov AH,2
	int 21h
	neg BL
sign1:	
	mov AX,-1
	push AX	
sign2:   
	mov AL,BL
	mov AH,0
	mov BH,10
	DIv BH
	mov BL,AL
	mov CL,AH
	mov ch,0
	push CX
	cmp BL,0
	jg sign2
sign3:   
	pop AX
	cmp AX,0   
	jl step  
	mov AH,2  
	mov DL,AL
	add DL,30h
	int 21h
	jmp sign3
step:
	pop DX   
	pop CX
	pop AX
	ret	
sort endp
CODES ENDS
end main