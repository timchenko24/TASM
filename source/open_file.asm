.Model SMALL
Stack 100h

.Data
strPath DB  80 DUP (?)
;strPath DB  'G:\Text.txt', 0

strPath1 DB 80, ?, 80 DUP (?)
stroca DB 100 DUP (?)
Inp DB 'Input name of file!', 10, 13, '$'
FileOpen DB 'File open! ', 13, 10, '$'
OpeningError DB 'File not found!' ,13, 10, '$'
handle DW ?
handle1 DW ?

.Code
START: 
	mov AX, @Data
    mov ds, ax
	lea dx, Inp
	
	mov AH, 09h
	INT 21h
	Lea dx, strPath
	mov AH, 0Ah
	INT 21h
	
	mov al, strPath+1
	mov ah, 0
	mov SI, ax
	mov strPath[SI+2], 0
	Lea dx, strPath+2
	mov CX, 0
	mov AH, 3Dh
	mov al, 2
	INT 21h
	jc met1
	mov handle, ax
	Lea dx, FileOpen
	mov AH, 09h
	INT 21h
	jmp Finish

	met1: Lea dx, OpeningError
	mov ah, 09h
	INT 21h
	

	Finish: mov AH, 4Ch
	INT 21h
	End START 