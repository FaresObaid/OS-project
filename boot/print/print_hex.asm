; dx has the hex to print
print_hex:

    pusha
    mov bx, HEX_OUT + 5

loop_digits:

    mov cl, dl
    and cl, 0x0f            ; has the digit as number
    call hexdigit_to_ascii
    mov [bx], cl            ; move it to the address
    shr dx, 4               ; shift to get the next digit in lower 8bit dx

    dec bx                  ; go to next address to but next charactar in
    cmp dx, 0               ; if dx is zero then we are done
    jne loop_digits

    mov bx, HEX_OUT         ; move to the begining of hex string dec will work too
    call print_string

    popa
    ret

; cl has hex digit to convert
; result is ascii char in cl
hexdigit_to_ascii:

    cmp cl, 0x9  ; test if the digit <= 9
    jle then
    sub cl, 0xA  ; make it index in the alpha (A=10 -> 0 = 'A')
    add cl, 0x61 ; it's a letter so add 'a' to it to make it ascii letter
    jmp end
then:
    add cl, 0x30 ; it's a digit so make it a digit
end:
    ret

; global var
HEX_OUT: db '0x0000', 0
