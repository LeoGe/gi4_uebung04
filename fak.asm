SECTION .data
	n DD 8
	ergebnis DD 1
	message DB "Ergebnis = %i", 10, 0

SECTION .text
	global main
	extern printf


main:
	mov eax, [ergebnis]
	mov ecx, [n]
	cmp ecx, 0
	je end
loop:
	imul ecx
	dec ecx
	jnz loop

end:
	mov [ergebnis], eax
	
	push eax
	push message
	
	call printf
	add esp, 8
	ret
