; Hello World Program (Calculating string length)
; Compile with: nasm -f elf helloworld-len.asm
; Link with (64 bit systems require elf_i386 option): ld -m elf_i386 helloworld-len.o -o helloworld-len.elf
; Run with: ./helloworld-len.eff

SECTION .data
msg		db		'Hello, brave new world!', 0Ah ;

SECTION .text
global	_start

_start:

	mov		ebx, msg
	mov		eax, ebx

nextchar:
	cmp		byte [eax], 0
	jz		finished
	inc		eax
	jmp		nextchar

finished:
	sub		eax, ebx
	mov		edx, eax
	mov		ecx, msg
	mov		ebx, 1
	mov		eax, 4
	int		80h

	mov		ebx, 0
	mov		eax, 1
	int		80h 
