model small
.data
file1 db 'fileq.txt',0
writ db 'Recording started' ,10,13,'$'
tr db 'File created' ,10,13,'$'
fal db 'File not created' ,10,13,'$'
string1 db 10,?,11 dup(' ')
newLine db 10,13,'$'
deskr dw ?

.code
begin:
mov ax,@data
mov ds,ax
xor cx,cx
mov ah,3ch
mov dx,offset file1
int 21h
jc err1
mov deskr,ax
mov ah,9
lea dx,tr
int 21h

mov ah,3dh
mov al,2
mov dx,offset file1
int 21h               
jc err1

mov ah,9
mov dx,offset writ
int 21h               

mov ah,0ah
mov dx,offset string1
int 21h

mov ah,9
mov dx,offset newLine
int 21h 

mov bx,5                    
mov ah,40h
mov cx,10
mov dx,offset string1+2      
int 21h

jnc end1

err1: mov ah,9
mov dx,offset fal
int 21h
jmp end2             

end1: mov ah,9
mov dx,offset tr
int 21h

end2: mov ah,4ch
int 21h
end begin