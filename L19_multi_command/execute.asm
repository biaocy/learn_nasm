; Execute
; make ARGS="echo ls echo sleep echo" run

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

timeval:
	tv_sec		dd		0h
	tv_nsec		dd		0h

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
	mov		eax, 2
	int		80h

	cmp		eax, 0
	jnz		nextArg			; Return to nextArg, if it's parent process

	mov		edx, environment
	mov		ecx, arguments_echo
	mov		ebx, command_echo
	mov		eax, 11
	int		80h

	call	quit			; Quit from child process

.ls:
	mov		eax, 2
	int		80h

	cmp		eax, 0
	jnz		nextArg

	mov		edx, environment
	mov		ecx, arguments_ls
	mov		ebx, command_ls
	mov		eax, 11
	int		80h

	call	quit			; Quit from child process

.sleep:
	push	ecx
	push	ebx
	push	eax

	; sys_nanosleep, sleep for 5 seconds
	mov		dword [tv_sec], 5h
	mov		dword [tv_nsec], 0h
	mov		eax, 0xa2
	mov		ebx, timeval
	mov		ecx, 0
	int		80h

	pop		eax
	pop		ebx
	pop		ecx

	jmp		nextArg

noMoreArgs:
	call	quit
