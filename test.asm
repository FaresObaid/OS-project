[org 0x7c00]

mov bx, MSG1
call print_string

mov bx, MSG2
call print_string
jmp end

print_string:
pusha	;keep all register in stack
start_loop:
	mov al, [bx]	;print the content of bx
	mov ah, 0x0e
	int 0x10

	cmp al, 0	;the condition of the loop
	je end_loop

	add bx, 0x01	;increase the value of bx with 1 byte
					;to move to next character
	jmp start_loop
end_loop:
popa	;return the values from stack to register
ret

end:

jmp $ ;Hang

;Data
MSG1:
	db 'OS Project, Phase1...', 0xA,0xD, 0
MSG2:
	db 'Fares Obaid & Mohammad Shakhatreh', 0xA,0xD, 0

;Padding and magic number
times 510 -( $ - $$ ) db 0
dw 0xaa55