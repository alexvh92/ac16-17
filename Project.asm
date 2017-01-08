;EasyCodeName=Module1,1
.Const

.Data

opcion	DD	0
array	DD	5, 2, 1, 7, 4, 6
tam		DD	5
numA	DD	0
numB	DD	0
resto	DD	0
coc		DD  0


.Code

start:
	Xor Eax, Eax
	Xor Ebx, Ebx
	Xor Edi, Edi
	Xor Edx, Edx
	Xor Esi, Esi
	 
	Invoke puts, "--CUESTION 2: x86--", "/n"
	Invoke puts, "1. Bubblesort", "/n"
	Invoke puts, "2. Quicksort", "/n"
	Invoke puts, "3. Algoritmo de Euclides", "/n"
	Invoke puts, "4. Factorial de un numero", "/n"
	Invoke puts, "5. Salir", "/n"
	Invoke puts, "Introduzca la opcion: "
	Invoke scanf, "%d", Addr opcion
	
	mov Edi, [opcion]
	cmp Edi, 1
	je > bubble_sort
	jl > error_menu
	cmp Edi, 2
	je > quick_sort
	cmp Edi, 3
	je > euclides
	cmp Edi, 4
	je > factorial
	cmp Edi, 5
	je > exit
	jg > error_menu

bubble_sort:
	mov Edi, [array+Ebx]
	mov Esi, [array+Ebx+4]
	;Invoke printf, "%d", Ebx
	;Invoke puts, " ", "/n"
	;Invoke printf, "%d", Edi
	;Invoke puts, " ", "/n"
	;Invoke printf, "%d", Esi
	;Invoke puts, " ", "/n"
	;Invoke system, "pause"
	Cmp Edi, Esi
	jg > bs_cambio
	Add Ebx,4
	Cmp Ebx, 20
	jl < bubble_sort
	Xor Ebx, Ebx 
	jmp > bs_comprobar

bs_cambio:
	;Invoke puts, "CAMBIO", "/n"
	;Invoke system, "pause"
	xchg [array+Ebx],Esi
	xchg [array+Ebx+4],Edi
	Add Ebx, 4
	Cmp Ebx, 20
	jl < bubble_sort
	Xor Ebx, Ebx
	jmp > bs_comprobar

bs_comprobar:
	mov Edi, [array+Ebx]
	mov Esi, [array+Ebx+4]
	Cmp Edi, Esi
	jg < bubble_sort
	Add Ebx, 4
	Cmp Ebx, 20
	jl < bs_comprobar
	Xor Edi, Edi
	Xor Ebx, Ebx
	Invoke puts, "Array ordenado: "
	jmp > bs_mostrar

bs_mostrar:
	mov Edi, [array+Ebx]
	Invoke printf, "%d ", Edi
	Add Ebx,4
	cmp Ebx,24
	jl < bs_mostrar
	Invoke puts, " ", "/n"
	jmp < start

quick_sort:
	jmp < start
	
euclides:
	Invoke puts, "Introduzca un numero entero (a)"
	Invoke scanf, "%d", Addr numA
	Invoke puts, "Introduce un numero entero (b)"
	Invoke scanf, "%d", Addr numB

	mov Eax, [numA]
	mov Ebx, [numB]

	cmp Eax, Ebx
	jl > euc_cambiar
	jmp > euc_alg

euc_cambiar:
	mov Ecx, Eax
	mov Eax, Ebx
	mov Ebx, Ecx

euc_alg:
	Xor Ecx, Ecx

euc_bucle:
	Sub Eax, Ebx
	Cmp Eax, Ebx
	Jge < euc_bucle
	Mov Ecx, Eax
	Mov Eax, Ebx
	Mov Ebx, Ecx

	Cmp Ebx, 0
	Jg < euc_bucle
	Jmp > euc_mostrar

euc_mostrar:
	Invoke printf, "El MCD es: %d", Eax
	Invoke puts, " ", "/n"
	jmp < start

factorial:
	Invoke puts, "Introduzca un numero entero"
	Invoke scanf, "%d", Addr numA

	mov Eax, [numA]
	mov Ebx, Eax

fact_bucle:
	dec Ebx
	Cmp Ebx, 0
	Je > fact_mostrar
	mul Ebx
	jmp < fact_bucle

fact_mostrar:
	Invoke printf, "El valor del factorial es: %d", Eax
	Invoke puts, " ", "/n"
	jmp < start

error_menu:
	Invoke puts, "Error: seleccione una opcion correcta", "/n"
	jmp < start

exit:
	Invoke system, "pause"
	xor Eax, Eax
	Invoke ExitProcess, Eax
