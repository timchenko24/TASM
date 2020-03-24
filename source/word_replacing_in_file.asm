.model small
.stack 100h
input macro var1
	push ax
	push dx
	mov ah, 0ah
	lea dx, var1
	int 21h
	pop dx
	pop ax
endm

output macro var1
	push ax
	push dx
	mov ah, 9
	lea dx, var1
	int 21h
	pop dx
	pop ax
endm

pathZero macro path
	push bx
	push si
	mov bl, path[1]
	mov bh,0
	mov si,bx
	mov path[si+2], 0
	pop si
	pop bx
endm

.data
	p1 db "Enter file path: ",13,10,'$'
	p2 db 13,10,"Enter new file path: ",13,10,'$'
	p3 db 13,10,"File has been created!",13,10,'$'
	p4 db 13,10,"Error",13,10,'$'
	p5 db 13,10,"Failed to open file",13,10,'$'
	p6 db 13,10,"Failed to create file",13,10,'$'
	p7 db 13,10,"Failed to read from file",13,10,'$'
	p8 db 13,10,"Failed to write in file",13,10,'$'
	path1 db 20,?,20 dup(?)
	path2 db 20,?,20 dup(?)
	fNum1 dw ?
	fNum2 dw ?
	buffer1 db 100 dup(?)
	buffer2 db 100 dup(?)
	wi db ?
	word1 db "yarrow"
	word2 db "medicinal plant"
.code
begin:
	mov ax, @data
	mov ds, ax
	mov es, ax

	output p1
	input path1
	pathZero path1
	output p2
	input path2
	pathZero path2

	mov ah, 3dh
	lea dx, path1[2]
	mov al, 0
	int 21h
	jc OpenFileError
	mov fNum1, ax

	mov cx, 0
	mov ah, 3ch
	lea dx, path2[2]
	int 21h
	jc CreateFileError
	mov fNum2, ax
	output p3

	xor ax, ax
	mov ah, 3fh
	mov bx, fNum1
	mov cx, 100
	lea dx, buffer1
	int 21h
	jc ReadFileError

	mov cx, 0
	mov si, 0
	mov di, 0
	mov bp, 0
	mov wi, 0
	jmp BufferScan

OpenFileError:
	output p5
	jmp Exit

CreateFileError:
	output p6
	jmp Exit

ReadFileError:
	output p7
	jmp Exit

WriteFileError:
	output p8
	jmp Exit

BufferScan:
	pop si
	cmp cx, 100
	je EndOfBuffer
	mov al, buffer1[si]
	cmp al, word1[bp]
	jne SkipWord
	inc si
	inc bp
	cmp bp, 6
	je Change
	jmp BufferScan

SkipWord:
	mov al, buffer1[si]
	cmp al, ' '
	je Space
	mov buffer2[di], al
	inc cx
	inc si
	inc di
	jmp SkipWord

Space:
	mov bp, 0
	inc si
	jmp BufferScan

Change:
	push si
	mov si, 0
ChangeLoop:
	inc di
	mov al, word2[si]
	mov buffer2[di], al
	inc cx
	cmp si, 14
	je BufferScan
	inc si
	inc di
	jmp ChangeLoop

EndOfBuffer:
	mov ah, 40h
	mov bx, fNum2
	mov cx, 100
	lea dx, buffer2
	int 21h
	jc WriteFileError
	jmp Exit

Exit:
	mov ah, 4ch
	int 21h
end begin