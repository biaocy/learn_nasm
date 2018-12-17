; Execute
; make ARGS="echo" run
; make ARGS="ls" run
; make ARGS="sleep" run

%include		'functions.asm'

SECTION	.data
str_echo		db		'echo', 0h
command_echo	db		'/bin/echo', 0h
arg_echo		db		'Hello World!', 0h
arguments_echo	dd		command_echo
				dd		arg_echo
				dd		0h

str_ls			db		'ls', 0h
command_ls		db		'/bin/ls', 0h
arg_ls			db		'-l', 0h
arguments_ls	dd		command_ls
				dd		arg_ls
				dd		0h

str_sleep		db		'sleep', 0h
command_sleep	db		'/bin/sleep', 0h
arg_sleep		db		'5', 0h
arguments_sleep	dd		command_sleep
				dd		arg_sleep
				dd		0h

environment		dd		0h

SECTION	.text
global	_start

_start:

	pop		ecx

nextArg:
	cmp		ecx, 0h
	jz		noMoreArgs
	dec		ecx
	pop		eax
	mov		eax, [eax]		; move content to eax
	cmp		eax, [str_echo]	; compare content not address
	je		.echo
	cmp		ax, [str_ls]	; just compare lower 16 bit
	je		.ls
	cmp		eax, [str_sleep]
	je		.sleep

	jmp		nextArg			; Simply ignore other args

.echo:
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov		edx, environment
	mov		ecx, arguments_echo
	mov		ebx, command_echo
	mov		eax, 11
	int		80h

; Actually, following code will never be executed...

	pop		eax
	pop		ebx
	pop		ecx
	pop		edx

	ret

.ls:
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov		edx, environment
	mov		ecx, arguments_ls
	mov		ebx, command_ls
	mov		eax, 11
	int		80h

	pop		eax
	pop		ebx
	pop		ecx
	pop		edx

	ret

.sleep:
	push	edx
	push	ecx
	push	ebx
	push	eax

	mov		edx, environment
	mov		ecx, arguments_sleep
	mov		ebx, command_sleep
	mov		eax, 11
	int		80h

	pop		eax
	pop		ebx
	pop		ecx
	pop		edx

	ret

noMoreArgs:
	call	quit
