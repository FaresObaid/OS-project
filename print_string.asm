; bx has the address of the string
print_string:
        push ax
        push bx

        mov ah, 0x0E

loop:   mov al, [bx]     ; move the character to al to be printed
        int 0x10
        inc bx           ; move to the next address holding the next character
        cmp byte [bx], 0 ; see if next character is null
        jne loop         ; if it's not null continue printing

        pop bx
        pop ax
        ret

NEWLINE: db 0xA, 0xD, 0
