; This file represents an older, flawed hex printing function,
; which would go through and print everything it found until
; it would hit a null terminator, and then stop.

print_hex:
  pusha
print_hex_loop:
  mov ax, [bx]
  mov ah, 0x00
  cmp al, 0
  je print_hex_exit
  push bx
  mov bx, hex_lead
  call print_string
  pop bx

  and ax, 0x00FF
  shr al, 0x04

  push bx
  mov bx, ax
  call print_hex_inner
  pop bx

  mov ax, [bx]

  and al, 0x0F

  push bx
  mov bx, ax
  call print_hex_inner
  pop bx

  inc bx
  jmp print_hex_loop
print_hex_exit:
  popa
  ret

print_hex_inner:
  pusha
  mov ax, bx
  add al, "0"
  cmp al, "9"
  jle print_hex_print
  sub al, "0"
  add al, "A"
print_hex_print:
  push bx
  mov [HEX_OUT], al
  mov bx, HEX_OUT
  call print_string
  pop bx
  popa
  ret

hex_lead: db " 0x",0
HEX_OUT: db 0x0, 0x0
