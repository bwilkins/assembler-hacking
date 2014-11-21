
[bits 16]

DISK_ERROR_MSG: db "Disk read error!",0

disk_load:
  push dx         ; Push dx to stack so that we cal later recall
                  ; how many sectors were requested to be read
  mov ah, 0x02    ; BIOS read sector function
  mov al, dh      ; Read number of sectors as stored in dx
  mov ch, 0x00    ; Select cylinder 0
  mov dh, 0x00    ; Select head 0
  mov cl, 0x02    ; Start reading from the second sector (ie after the boot sector

  int 0x13        ; Issue BIOS interrupt to perform the read
  jc disk_error   ; Jump to disk_error if carry-flag was set

  pop dx
  cmp dh, al      ; al has the number of sectors read from disk.
  jne disk_error  ; If the number of sectors read was not as expected, error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  xor bx, bx
  mov bl, ah
  call print_hex
  ret
