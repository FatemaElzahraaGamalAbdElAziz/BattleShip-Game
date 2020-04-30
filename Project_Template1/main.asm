include irvine32.inc
.data
RowSize = 10
ComputersO      byte   'U','0','0','0','0','0','0','0','0','0'
                byte   '0','0','0','0','0','0','0','0','0','0'
				byte   '0','0','0','0','0','0','0','0','B','0'
				byte   'D','0','0','0','S','S','S','0','B','0'
			    byte   'D','0','0','0','0','0','0','0','B','0'
				byte   '0','0','0','U','U','U','0','0','B','0'
			    byte   '0','0','0','0','0','0','0','0','0','0'
			    byte   '0','0','0','R','R','R','R','R','0','0'
			    byte   '0','0','0','0','0','0','0','0','0','0'
			    byte   '0','0','0','0','0','0','0','0','0','0'
PlayersT byte 100 dup ('0')
PlayersShips byte 20 Dup(0),1,1,0
missSTR byte "MISS",0
hitSTR byte "HIT",0
sunk byte "THE SHIP SUNK",0
ComputersShips byte 27 dup (0) 
index dword ?
ce byte ?
re byte ?
.code
GetIndex proc  ,r:byte ,cols:byte 

mov eax,0
mov ebx,0
mov ecx,0
mov eax,10
mul r
mov ebx,eax
movzx ecx,cols
add ecx,ebx
mov index,ecx
mov eax,ecx

;call writedec
;call crlf
ret
GetIndex endp
Random PROC                             ; Generate Random value

rdtsc
mov ebx , RowSize
mov edx , 0
div ebx

RET
Random ENDP

ComputersTurn PROC,PlayersOcean : ptr byte ,ComputersTarget :ptr byte,Cr: byte ,Ccols: byte 
;call Random 
;mov Cr , dl

;call Random 
;mov Ccols , dl
;invoke GetIndex , Cr  , Ccols
mov eax,index
;call writedec
;call crlf
mov eax,0
mov ecx,0
mov ebx,0
mov edx, PlayersOcean
add edx, index
mov cl,[edx]
mov esi, ComputersTarget
add esi,index
cmp cl,'*'
je NOTVALID
cmp cl,'#'
je NOTVALID
cmp cl, '0'
jne HIT
mov bl,'x'
mov [esi],bl
mov bl,'#'
mov [edx],bl
mov eax,0 
jmp done
HIT:
mov bl ,'o'
mov [esi],bl
mov bl,'*'
mov [edx],bl
sub cl,'A'
mov edx,offset ComputersShips
add edx,ecx
mov bl,[edx]
dec bl
mov [edx],bl
mov eax,1
cmp bl,0
jne done
mov eax,2
jmp done
NOTVALID:
mov eax,4
done:
call writedec
call crlf
ret
ComputersTurn endp

main proc
mov re,0
mov ce,1
invoke ComputersTurn ,offset ComputersO,offset PlayersT ,re,ce
mov dl,0
mov re,dl
mov ce,dl
mov ecx,100
mov index,0
L2:
mov edx,offset ComputersO
add edx,index
inc index
mov al,[edx]
call writechar
mov al,' '
call writechar
Loop L2
call crlf
call crlf
call crlf
mov dl,0
mov re,dl
mov ce,dl
mov ecx,100
mov index,0
L1:
mov edx,offset PlayersT
add edx,index
inc index
mov al,[edx]
call writechar
mov al,' '
call writechar
Loop L1
call crlf

 

exit
main endp
End main 
