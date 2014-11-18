;
; A simple boot sector that loops forever
;

loop1:                    ; Create a label called loop that we can jump to
  jmp loop1               ; Jump to the loop label, forever

times 510-($-$$) db 0     ; Pad the rest of the file with zeroes until we reach the 510th byte

dw 0xaa55                 ; Weite our magical number to identify the sector as a boot sector
