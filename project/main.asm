INCLUDE Irvine32.inc

.data

;ComputerOcean byte 100 dup('0')
RSize dword 5      ; num = 0
BSize dword 4      ; num = 1
USize dword 3      ; num = 2
SSize dword 3      ; num = 3
DSize dword 2      ; num = 4
Count dword 0
PSize dword 0
GeneralSize dword 0
Character byte ?

RowIndex dword 0
ColumnIndex dword 0
Row dword 0
XTurn dword ?
YTurn dword ?

;r byte ?
;col byte ?
missSTR byte "MISS",0
hitSTR byte "HIT",0
sunk byte "THE SHIP SUNK",0
ComputersShips byte 27 dup (0) 
PlayersShips byte 27 dup (0)
index dword ?

.code
GetIndex proto ,r :byte ,col :byte
SetShips Proc
mov esi,offset ComputersShips
mov edi,offset PlayersShips
mov eax ,0
mov ebx,0
mov al,'B'
sub al,'A'
mov bl,4
add esi,eax
add edi,eax
mov [esi],bl
mov [edi],bl
mov eax ,0
mov ebx,0
mov al,'R'
sub al,'A'
mov bl,5
mov esi,offset ComputersShips
mov edi,offset PlayersShips
add esi,eax
add edi,eax
mov [esi],bl
mov [edi],bl
mov eax ,0
mov ebx,0
mov al,'S'
sub al,'A'
mov bl,3
mov esi,offset ComputersShips
mov edi,offset PlayersShips
add esi,eax
add edi,eax
mov [esi],bl
mov [edi],bl
mov eax ,0
mov ebx,0
mov al,'U'
sub al,'A'
mov esi,offset ComputersShips
mov edi,offset PlayersShips
add esi,eax
add edi,eax
mov [esi],bl
mov [edi],bl
mov eax ,0
mov ebx,0
mov al,'D'
sub al,'A'
mov bl,2
mov esi,offset ComputersShips
mov edi,offset PlayersShips
add esi,eax
add edi,eax
mov [esi],bl
mov [edi],bl
ret
SetShips endp

GetIndex proc  ,r:byte ,col:byte 

mov eax,0
mov ebx,0
mov ecx,0
mov eax,10
mul r
mov ebx,eax
movzx ecx,col
add ecx,ebx
mov index,ecx
mov eax,ecx

call writedec
call crlf
ret
GetIndex endp

PlayersTurn PROC   ,PlayersOcean : ptr byte ,ComputersTarget :ptr byte,r: byte ,col: byte 
invoke GetIndex , r  , col

mov ecx,0                      ;ana safrt ecx
mov edx, PlayersOcean
mov esi,offset PlayersShips
add edx,index
mov cl,[edx]
cmp cl,'0'
jne HIT
mov eax,0
mov edx,ComputersTarget
add edx,ecx
mov bl,'x'
mov [edx],bl
mov edx,offset missSTR
call writestring 
call crlf
jmp done
HIT:
mov bl,'*'
mov [edx],bl
mov eax,1
mov edx,ComputersTarget
add edx,ecx
mov bl,'o'
mov [edx],bl
mov edx,offset hitSTR
call writestring
call crlf 
sub cl,'A'
mov bl,[esi+ecx]
dec bl
mov [esi+ecx],bl
cmp bl,0
jne done
mov eax,2
mov edx,offset sunk
call writestring
call crlf 
done:

ret
PlayersTurn endp

ComputersTurn PROC, ComputerOcean: ptr byte, PlayersTarget : ptr byte , r:byte , col:byte
call Random 
mov r , dl

call Random 
mov col , dl

invoke GetIndex , r byte  , col byte                 ;hena hatwadilo l r w col ya zahraaa
;mov edi, ComputerOcean

mov ecx,0                      ;ana safrt ecx
mov edx, ComputerOcean
mov esi,offset ComputersShips
add edx,index
mov cl,[edx]
cmp cl,'0'
jne HIT
mov eax,0
mov edx,PlayersTarget
add edx,ecx
mov bl,'x'
mov [edx],bl
mov edx,offset missSTR
call writestring 
call crlf
jmp done
HIT:
mov bl,'*'
mov [edx],bl
mov eax,1
mov edx,PlayersTarget
add edx,ecx
mov bl,'o'
mov [edx],bl
mov edx,offset hitSTR
call writestring
call crlf 
sub cl,'A'
mov bl,[esi+ecx]
dec bl
mov [esi+ecx],bl
cmp bl,0
jne done
mov eax,2
mov edx,offset sunk
call writestring
call crlf 
done:
RET
ComputersTurn ENDP

main PROC
call SetShips
call CheckShip
call display
call crlf
call ComputersTurn
exit
main ENDP

Random PROC

rdtsc
mov ebx , 10 
mov edx , 0
div ebx

RET
Random ENDP

CheckShip PROC

mov ecx , 5
mov edx , 0

Ship :
cmp ecx , 0
je K
mov GeneralSize , ecx
mov Count , edx 
cmp edx , 0
je RShip
cmp edx , 1
je BShip
cmp edx , 2
je UShip
cmp edx , 3
je SShip
cmp edx , 4
je DShip

RShip:
mov edx , RSize
mov PSize , edx
mov Character , 'R'
call CheckIndexRandom
jmp Done

BShip:
mov edx , BSize
mov PSize , edx
mov Character , 'B'
call CheckIndexRandom
jmp Done

UShip:
mov edx , USize
mov PSize , edx
mov Character , 'U'
call CheckIndexRandom
jmp Done

SShip:
mov edx , SSize
mov PSize , edx
mov Character , 'S'
call CheckIndexRandom
jmp Done

DShip:
mov edx , DSize
mov PSize , edx
mov Character , 'D'
call CheckIndexRandom

Done:
mov ecx ,GeneralSize
dec ecx
mov edx , Count
inc edx

jmp Ship
k:
RET
CheckShip ENDP



CheckIndexRandom PROC

Check:

call Random 
mov ColumnIndex , edx

call Random 
mov RowIndex , edx

mov edx , ColumnIndex
add edx , PSize
cmp edx ,9
jnbe Vertical

mov ecx , PSize

mov esi ,  ComputerOcean
add esi , ColumnIndex
mov eax , 10
mul RowIndex
add esi , eax

L1:
mov dl , '0'
cmp [esi], dl
jne Vertical
inc esi
Loop L1

mov esi ,  ComputerOcean
add esi , ColumnIndex
mov eax , 10
mul RowIndex
add esi , eax
mov ecx ,PSize

L2:
mov dl , Character
mov [esi] , dl
inc esi
Loop L2
jmp OK

Vertical:

mov edx , RowIndex
add edx , PSize
cmp edx ,9
jnbe Check



mov ebx , RowIndex
mov Row , ebx
mov ecx ,PSize

L3:
mov esi ,  ComputerOcean
add esi , ColumnIndex
mov eax , 10
mul Row
add esi , eax
mov dl ,'0'
cmp [esi], dl
jne Check
inc Row
Loop L3

mov ebx , RowIndex
mov Row , ebx
mov ecx ,PSize

L4:
mov esi ,  ComputerOcean
add esi , ColumnIndex
mov eax , 10
mul Row
add esi , eax
mov dl , Character
mov [esi] , dl
inc Row
Loop L4

OK:

RET
CheckIndexRandom ENDP



Display PROC

mov esi ,  ComputerOcean

mov ecx , 10

L:
mov ebx , ecx
mov ecx , 10
L2:
mov al , [esi]
call writechar
mov al , ' '
call writechar
inc esi
Loop L2
mov ecx ,ebx
call crlf
Loop L

ret
Display ENDP

END main
