SECTION .data
	n DD 48
	ergebnis_h DD 0
	ergebnis_l DD 0
	message DB "Fibonacci(%i) = <high>%i <low>%i", 10, 0

SECTION .text
	global main
	global fibo
	extern printf

main:
	mov eax, [n];index in eax speichern	
	call fibo ;fibonacci Zahl berrechnen
	mov [ergebnis_l], eax; berrechnetes Egebnis in ergebnis speichern (low)
	mov [ergebnis_h], ebx ; (high)
	push eax
	push ebx
	mov eax, [n]
	push eax
	push message
	call printf
	mov ebx, 0
	mov eax, 1
	int 0x80	

fibo:
	cmp eax, 2 ;Abbruchbedingung fib(2)=fib(1)=1
	jbe break; zu break springen
	dec eax ;n-1
	push eax; n-1 auf dem stack speichern
	call fibo ; fib(n-1) ist in eax (low) und ebx (high)

	xchg eax, [esp] ;  fib(n-1) low auf dem stack speichern and n-1 in eax zurückholen
	push ebx; fib(n-1) high auf dem Stack speichern
	dec eax ; n-2
	call fibo;fib(n-2) ist in eax (low) und ebx (high) 
	pop edx ; fib(n-1) vom stack zurückholen (high)
	pop ecx; fib(n-1) vom Stack zurückholen (low)
	add eax, ecx ;beide addieren(low), ergebnis ist in eax, carrier ist vielleicht gesetzt
	adc ebx, edx; beide addieren (high) eventuell carrier zuaddieren
	jc error; wenn selbst 64bit zu klein waren zu error springen
	ret
break:
	mov eax, 1 ;ergebnis ist 1
	mov ebx, 0	
	ret

error:
	mov eax, 0
	mov ebx, 0
	ret
