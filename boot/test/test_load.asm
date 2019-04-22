; Read some sectors from the boot disk using our disk_read function
[org 0x7c00]

xor ax, ax
mov es, ax
mov ds, ax
mov ss, ax

mov bx, MSG
call print_string

mov [BOOT_DRIVE] , dl ; BIOS stores our boot drive in DL, so it ’s
                      ; best to remember this for later.

mov bp , 0x8000       ; Here we set our stack safely out of the
mov sp , bp           ; way, at 0x8000

mov ax, 0x1000
mov es, ax

mov bx , 0x0       ; Load 2 sectors to 0x0000 (ES): 0x9000 (BX)
mov dh , 2            ; from the boot disk.
; mov dl , [BOOT_DRIVE]
call disk_load

mov dx , [es:0x0]     ; Print out the first loaded word, which
call print_hex        ; we expect to be 0xdada, stored
                      ; at address 0x9000
mov bx, NEWLINE
call print_string

mov dx , [es:0x0+512]   ; Also, print the first word from the
call print_hex          ; 2nd loaded sector: should be 0xface

mov bx, NEWLINE
call print_string

jmp $

%include "../disk_load.asm"    ; Include our new disk_load function
%include "../print/print_string.asm" ; Re - use our print_string function
%include "../print/print_hex.asm"    ; Re - use our print_hex function

; Global variables
BOOT_DRIVE db 0
MSG        db 'test 6', 0xa, 0xd, 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only the first 512-byte sector from the disk,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers, we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdead
times 256 dw 0xface
