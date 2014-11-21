[bits 32]

; Some constants
VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

; print a null-terminated string pointed to by EDX
print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY     ; Set edx to the start of video memory

print_string_pm_loop:
  mov al, [ebx]             ; Store the char at EBS in AL
  mov ah, WHITE_ON_BLACK    ; Store the attributesin AH

  cmp al, 0                 ; If al == 0, we've reached the end of our string,
  je print_string_pm_exit   ; so exit

  mov [edx], ax             ; Store char and attributes at current character cell

  add ebx, 1                ; Increment EBX to the next char in string
  add edx, 2                ; Move to the next character cell in video memory

  jmp print_string_pm_loop  ; Let's do the time warp agaiiiin

print_string_pm_exit:
  popa
  ret                       ; Return from the function
