INCLUDE Irvine32.inc

.DATA

; intial 2darray
PlayerOcean byte 100 dup (0)
arrayCount byte 27 dup (0)
RowE byte 0
RowS byte 0
CountS dword 0
Row byte 0
Col byte 0 
Counter byte 0
numR byte 10
;Input byte 10 dup (?),0
Error byte "INVALID",0
Ship byte "Ship Not Found",0
Sizee byte "Size Not Found",0
GenralSize byte 0
PlayersShips byte 27 dup (0)
temp byte "D B0 D1",0
ShowS byte ?
hamadaa byte 0
tmp dword ?
valv byte 0
.code

UserPlacment PROC, Input:PTR BYTE, PlayerO:PTR Byte
;			mov edi,offset PlayerOcean
mov ebx,offset arrayCount
mov eax,0
			mov edi,PlayerO
			mov edx,Input
			mov al,[edx]
			mov hamadaa,al
			add edx,2
			mov al,[edx]
			mov ah,[edx+3]					
			cmp ah,al
			je ver
			call Vertical
			jmp bye
			ver:
			mov bl,[edx+1]
			mov Col,bl
			mov bh,[edx+4]
			mov ah,[edx]
			sub ah,'A'
			mov Row,ah
			cmp bl,bh
			jg Invalid

			sub bh,bl
			inc bh
			cmp bh,GenralSize
			jne Invalid
			mov [esi],bh
			inc esi

			mov al,Row
			mul numR

			sub Col,'0'
			add al,Col
			movzx eax,al
			add edi,eax
			movzx ecx,GenralSize
			L:
				mov bl,[edi]
				cmp bl,0
				jne Invalid
				add edi,1 
			loop L
			mov ebx,offset arrayCount
			sub hamadaa,'A'
			movzx ecx,hamadaa
			add ebx,ecx
			mov cl,[ebx]
			cmp cl,0
			jne Invalid
			inc cl 
			mov [ebx],cl
			inc Valv


lol:
			mov edi,PlayerO
			add edi,eax

			movzx ecx,GenralSize
			L1:
					mov bl,ShowS
					mov [edi],bl
					inc edi
			Loop L1

			call Display
			jmp bye

Invalid:
	

mov eax,-1

bye:
ret
UserPlacment ENDP


ShipInput PROC, Input:PTR BYTE ,PlayerO:PTR BYTE

;mov edi,offset PlayerOcean
mov esi,offset PlayersShips	

            ;mov edi,offset PlayerOcean
			mov edi,PlayerO
			mov edx, Input
			mov al,[edx]
		
			cmp al,'B'
			jne R
			mov GenralSize,4
			mov ShowS,al
			Invoke UserPlacment	, Input	,PlayerO

			jmp bye
			R:
			cmp al,'R'
			jne U
			mov GenralSize,5
			mov ShowS,al
			Invoke UserPlacment ,Input,PlayerO
			jmp bye
			U:
			cmp al,'U'
			jne S
			mov GenralSize,3
			mov ShowS,al
			Invoke UserPlacment ,Input,PlayerO
			jmp bye
			S:
			cmp al,'S'
			jne D
			mov GenralSize,3
			mov ShowS,al
			Invoke UserPlacment ,Input,PlayerO
			jmp bye
			D:
			mov GenralSize,2
			mov ShowS,al
			Invoke UserPlacment , Input,PlayerO
			jmp bye
			Invalid:
					mov eax,-1

		

bye:


comment @
mov ecx,25
mov esi,offset PlayersShips
l2:
	mov al,[esi]
	inc esi
	call writedec
	mov al,' '
loop l2
@
ret
ShipInput ENDP





Vertical PROC

mov bl,[edx+1]
mov bh,[edx+4]
cmp bh,bl

jne Invalid


sub al,'A'
mov RowS,al

sub ah,'A'
mov RowE,ah

cmp RowS,ah
jg Invalid

sub ah,al
inc ah
cmp ah,GenralSize
jne Invalid
mov [esi],ah
inc esi
			mov eax,0

			mov al,RowS
			mul numR
			 
			mov Col,bl
			sub Col,'0'
			add al,Col

			movzx eax,al	
			add edi,eax

			movzx ecx,GenralSize
			L:
				mov bl,[edi]
				cmp bl,0
				jne Invalid
				add edi,10 
			loop L

				mov ebx,offset arrayCount
			sub hamadaa,'A'
			movzx ecx,hamadaa
			add ebx,ecx
			mov cl,[ebx]
			cmp cl,0
			jne Invalid
			inc cl 
			mov [ebx],cl
			inc Valv


			mov edi,offset PlayerOcean
			add edi,eax
			movzx ecx,GenralSize
			L1:
					mov bl,ShowS
					mov [edi],bl
					add edi,10
			Loop L1
			call Display
			jmp byebye



Invalid:

mov eax,-1


byebye:
ret
Vertical ENDP





Display PROC

mov ecx,10
mov edi,offset PlayerOcean
Output:
mov ebx,ecx
mov ecx , 10
l1:
		mov al,[edi]
		call writechar
		mov al,' '
		call writechar
		inc edi
Loop l1
mov ecx , ebx
call crlf
loop Output


ret
Display ENDP

main PROC

	;mov ecx,5
	Inp:
	cmp valv ,5
	je yala
    push ecx
	mov edx,offset temp
	mov ecx,10
	call readstring 
	Invoke ShipInput, offset temp , offset PlayerOcean
	pop ecx
	loop Inp
	yala:
	exit
main ENDP


END main
