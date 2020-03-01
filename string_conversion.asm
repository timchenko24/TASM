.model small
.stack 100h
.data
	p1 db 13,10,"Initial string: $",13,10
	p2 db 13,10,"Transformed string: $",13,10
	p3 db "Enter string: ",13,10,'$'
	p4 db 13,10,"Nothing to change",13, 10,'$'
	p5 db 13,10,"Empty input",13,10,'$'
    cls db '$'
	temp dw 0
	count db 0
	str1 db 10,?,10 dup(0)
    str2 db 20 dup(' ')
.code
begin:
	mov ax, @data
	mov ds, ax
	mov es, ax
	
	mov ah, 9
	lea dx, p3
	int 21h
	
	mov ah, 0ah
	lea dx, str1
	int 21h
	
	cmp str1[1], 0
	jne next1
	mov ah, 9
	lea dx, p5
	int 21h
	jmp exit
	
next1:
	lea bx, str1[2]
	xor cx,cx
	mov cl, str1[1]
	add bx,cx
	inc bx
	mov byte ptr [bx], '$'
	
    mov ah, 9
	lea dx, p1
	int 21h
	
    lea dx, str1[2]
    int 21h
	
    mov cl, str1[1]
	mov si,2
loop1:
	cmp str1[si],'o'
	je for1
	mov al,str1[si]
	push si
	mov si, temp
	mov str2[si],al
	inc si
	mov temp,si
	pop si
	inc si
	dec cx
	jcxz output
	jmp loop1
for1:
	inc count
	mov al,'o'
	push si
	mov si,temp
	mov str2[si],al
	inc si
	mov str2[si],al
	mov al,'k'
	inc si
	mov str2[si],al
	inc si
	mov temp, si
	pop si
	inc si
	dec cx
	jcxz output
	jmp loop1
output:
	lea bx, str2
	xor cx,cx
	mov cl, str2
	add bx,cx
	inc bx
	mov byte ptr [bx], '$'
	cmp count,0
	jne next2
	mov ah, 9
	lea dx, p4
	int 21h
	jmp exit

next2:
    mov ah,9
    lea dx, p2
    int 21h
    mov ah,9
    lea dx, str2
    int 21h
    mov ah,10
    lea dx, str2
    int 21h
    
exit:
    mov ah,4ch
    int 21h
end begin
