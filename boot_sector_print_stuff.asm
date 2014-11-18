;
; A simple boot sector program that prints a message to the screen using a BIOS routine.
;
[org 0x7c00]

mov [BOOT_DRIVE], dl

mov bp, 0x8000
mov sp, bp

mov bx, foobar
call print_hex

mov bx, 0x9000
mov dh, 5
mov dl, [BOOT_DRIVE]
call disk_load

mov bx, 0x9000
call print_hex

mov bx, 0x9000 + 512
call print_hex

jmp $           ; Jump to the current address

%include "print/string.asm"
%include "print/hex2.asm"
%include "disk/load.asm"

; Global Variables
foobar: db "aaaa",0
BOOT_DRIVE: db 0
;
; Padding and boot
;

times 510-($-$$) db 0 ; Pad to 510

dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface

