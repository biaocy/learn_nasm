; Calculator (ATOI)
; make run

%include		'functions.asm'

SECTION	.text
global	_start

_start:

	pop		ecx
	mov		edx, 0

nextArg:
	cmp		ecx, 0h
	jz		noMoreArgs
	pop		eax
	call	atoi
	add		edx, eax
	dec		ecx
	jmp		nextArg

noMoreArgs:
	mov		eax, edx
	call	iprintLF
	call	quit
