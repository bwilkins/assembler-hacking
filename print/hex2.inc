

print_hex:
  pusha
  mov ax, hex_word              ; ax contains the byte index into hex_word that we
                                ; want to modify.

  add ax, 0x01                  ; inc ax by one, now it points to the 'x' in hex_word

  mov cx, 0x10                  ; cx represents the amount we want to shift our input
                                ; word, in order to get the correct nibble.

print_hex_loop:                 ; Inside the loop

  mov dx, [bx]                  ; dx contains the word data that we want to
                                ; print


  sub cx, 0x4                   ; we want to shift our input data right by 4 (1 nibble)
  inc ax                        ; Increment our position within hex_word

  shr dx, cl
  and dx, 0x000F
  add dx, 0x30                  ; Add 0x30 to cx ("0")

  cmp dx, 0x39                  ; If cx is <= 0x39 ("9")
  jle print_hex_store_nibble    ; goto store nibble

  add dx, 0x7                  ; add 0x11 to cx ("A" - "0" - 10)

print_hex_store_nibble          ; Store nibble

  push bx                       ; Push the current value of bx onto the stack
  mov bx, ax                    ; Move our index into hex_word into bx for writing
  mov [bx], dx                  ; Move our data-to-write into the location described
                                ; by bx, as only bx can be used for indexing ([])
  pop bx                        ; Pop the previous value of bx off the stack

  cmp cx, 0                     ; If dx == 0
  je print_hex_exit             ; Then exit

  jmp print_hex_loop            ; Next loop iteration
print_hex_exit:
  push bx                       ; Store the value of bx for later
  mov bx, hex_word              ; Move the location of out word-to-print to bx
  call print_string             ; Print that string
  pop bx                        ; Pop back out bx
  popa
  ret


hex_word: db "0x0000",0
