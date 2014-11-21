;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
[bits 16]

[org 0x7c00]

;mov [BOOT_DRIVE], dl

mov bp, 0x9000    ; Set up the stack in 16-bit real mode
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call mode_set_32bit

jmp $           ; Jump to the current address

%include "print/string.asm"
;%include "print/hex2.asm"
%include "gdt/gdt.asm"
%include "mode_set/32bit.asm"
%include "print/string_pm.asm"

[bits 32]

BEGIN_PM:         ;This is where we land after entering protected mode
  mov ebx, MSG_PROT_MODE
  call print_string_pm

  jmp $

; Global Variables
MSG_REAL_MODE: db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE: db "Successfully landed in 32-bit Protected Mode", 0
SEG_PRINT: dw 0x0000
;
; Padding and boot
;

times 510-($-$$) db 0 ; Pad to 510

dw 0xaa55

