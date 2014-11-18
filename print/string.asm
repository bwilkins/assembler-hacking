
print_string:     ;
  pusha
  mov ah, 0x0e    ; int 10/ah = 0eh -> scrolling teletype BIOS routine
print_loop:
  mov cx, [bx]    ; Loading the value pointed at by bx into cx
  cmp cl, 0x00    ; Check that cx/cl isn't null
  je print_exit   ; Exit the function if cx was null
  mov al, cl      ; Put the char to print into al
  int 0x10        ; Print
  inc bx          ; Increment the pointer at bx
  jmp print_loop  ; Go back to the start of the print loop
print_exit:
  popa
  ret

