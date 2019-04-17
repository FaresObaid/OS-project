[bits 32]
; Defines some constants
VEDIO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
LGREEN_ON_BLACK equ 0x0a

; print a null-terminated string pointed to by EDX
print_string_pm:
	pusha
	mov edx, VEDIO_MEMORY 	; set edx to the start of vid mem.

print_string_pm_loop:
	mov al, [ebx] 			    ; Store the char at EBX in AL
	mov ah, WHITE_ON_BLACK 	; Store the attributes in AH

	cmp al, 0 	; if (al == 0) , at end of string , so
	je print_string_pm_done 	; jump to done


	mov [edx] , ax  ; Store char and attributes at current
									; character cell.
	add ebx, 1 			; Increment EBX to the next char in string.
	add edx, 2 			; Move to next character cell in vid mem.

	jmp print_string_pm_loop ; loop around to print the next char.

print_string_pm_done:
	popa
	ret ; Return from the function
