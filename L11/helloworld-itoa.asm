; Hello World Program (count to 10 itoa)
; make run

%include		'functions.asm'

SECTION	.text
global _start

_start:

	mov		ecx, 0

nextNumber:
	inc		ecx
	mov		eax, ecx
	call	iprintLF

	cmp		ecx, 10
	jne		nextNumber

	call	quit
