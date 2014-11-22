;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
[bits 16]

[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl

mov bp, 0x9000    ; Set up the stack in 16-bit real mode
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call load_kernel

call mode_set_32bit

jmp $           ; Jump to the current address

%include "print/string.asm"
%include "disk/load.asm"
%include "print/hex2.asm"
%include "gdt/gdt.asm"
%include "mode_set/32bit.asm"
%include "print/string_pm.asm"

[bits 16]

load_kernel:
	mov bx, MSG_LOAD_KERNEL 		; Print a message to say we are loading the kernel
	call print_string

	mov bx, KERNEL_OFFSET				; Setup parameters for our disk_load routine, so
	mov dh, 15									; that we load the first 15 sectors (excluding
	mov dl, [BOOT_DRIVE] 				; the boot sector) from the boot disk (i.e. our
	call disk_load	 						; kernel code) to address KERNEL_OFFSET

	ret

[bits 32]

BEGIN_PM:         ;This is where we land after entering protected mode
  mov ebx, MSG_PROT_MODE
  call print_string_pm

	call KERNEL_OFFSET

  jmp $

; Global Variables
BOOT_DRIVE: 			db 0
MSG_REAL_MODE: 		db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: 		db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL: 	db "Loading kernel into memory", 0
;
; Padding and boot
;

times 510-($-$$) db 0 ; Pad to 510

dw 0xaa55

