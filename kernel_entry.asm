; Ensures that we jump straight into the kernel's entry function
[bits 32] 			; We're in protected mode by now, so use 32-bit instructions.
[extern main] 	; Declare that we will be referencing the external symbol 'main',
								; so the linker can substiture the final address.
call main 			; Invoke main() in our C kernel

jmp $ 					; Hang forever when we return form the kernel
