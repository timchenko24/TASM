model small
.data
_hint db "what's your name?",13,10,'$'
_input db 15, 15 dup(0)
hello db 13,10,"Hello, ", 15 dup(0), 13,10,'$'
kolvo db 13,10,"Kolvo sym: $"
num db 2 dup(0),'$'
ten dw 10
.code
begin:
mov ax, @data
mov ds, ax
mov bl, 0
lea dx, _hint
mov ah, 9
int 21h
lea dx, _input
mov ah, 0ah
int 21h
lea si, _input
mov cl, si[1]
mov ch, 0
lea di, hello
loop1: mov ah, si[2]
mov di[9], ah
inc si
inc di
inc bl
loop loop1
mov ax, 2421h
mov [di+09], ax
lea dx, hello
mov ah, 9
int 21h
mov ah, 9
lea dx, kolvo
int 21h

xor ax,ax
mov ax, bx
mov si,1
l1: cmp ax, ten
jl l2
mov dx,0
div ten
add dl, 30h
mov num[si],dl
dec si
jmp l1
l2: add al,30h
mov num[si],al
mov ah, 9
lea dx,num
int 21h

mov ah, 4ch
int 21h
end begin