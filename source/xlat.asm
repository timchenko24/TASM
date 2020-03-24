.model small
.stack 100h
.data
str1 db 10,?,10 dup(?)
str2 db 10 dup(?)
_ascii db 256 dup(?)
p1 db "Enter string: ", 13,10,'$'
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
mov ah, 9
lea dx, p1
int 21h
mov ah, 0ah
lea dx, str1
int 21h
lea bx, str1[2]
xor cx,cx
mov cl, str1[1]
add bx,cx
inc bx
mov byte ptr [bx], '$'
mov _ascii + 'a', '1'
mov _ascii + 'b', '2'
mov cl, str1[1]
lea bx, _ascii
mov si,0
loop2: mov al, str1[si]
xlat
mov str2[si], al
inc si
loop loop2
lea bx, str1[2]
xor cx,cx
mov cl, str1[1]
add bx,cx
inc bx
mov byte ptr [bx], '$'
mov ah, 9
lea dx, str2
int 21h
mov ah,4ch
int 21h
end begin