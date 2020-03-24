.model small
.stack 100h
.data
_ascii db 256 dup(?)
.code
begin: 
mov ax, @data
mov ds, ax
mov cx, 255
mov si, 0
mov _ascii[si], 0
loop1: mov al, _ascii[si]
add al, 1
inc si
mov _ascii[si], al
loop loop1
mov ah,02h
mov cx,256
mov si,0
mov di,0
n1: mov dl,_ascii[si]
int 21h
cmp di,31
je n2
inc di
inc si
jmp n3
n2: mov di,0
mov dl,0AH
int 21h
mov dl,0Dh
int 21h
n3: loop n1
mov ah, 4ch
int 21h
end begin