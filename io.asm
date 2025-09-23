section .bss
    buffer_out resb 16
    buffer_in  resb 16
    
section .data
    nl db 10    ;    '\n'
    
section .text

; Convierte un entero(EAX) en una cadena
; Retorna: ECX el puntero al buffer
;         y EDX la longitud de la cadena
int_to_str:
    push ebp
    mov ebp, esp
    ;push edi
    ;push ebx
    
    mov edi, buffer_out + 15    ; edi apunta al final del buffer
    mov byte [edi], 0           ; carácter nulo al final
    mov ebx, 10                 ; divisor = 10   
    xor ecx, ecx                ; contador = 0
    dec edi

    test eax, eax
    jnz convertir_loop

    ; Caso especial: número 0
    dec edi
    mov byte [edi], '0'    
    inc ecx
    jmp fin_conversion

convertir_loop:
    xor edx, edx
    div ebx         ; eax = eax / ebx
    add dl, '0'
    dec edi
    mov [edi],dl    
    inc ecx
    test eax, eax
    jnz convertir_loop

fin_conversion:
    mov edx, ecx            ; edx = a la longitud de la cadena
    mov ecx, edi            ; ecx = al inicio de la cadena
    ;pop ebx
    ;pop edi
    mov esp, ebp
    pop ebp
    ret

; Convierte una cadena (buffer_in) a un entero
; Retorna un entero (EAX)
str_to_int:
    push ebp
    mov ebp, esp    
    ;push esi
    ;push ebx

    mov esi, buffer_in
    xor eax, eax
    xor ebx, ebx
convertir_str_loop:
    mov bl, [esi]
    ; Verifica si es dígito    
    cmp bl, '0'
    jl fin_convertir_str_loop
    cmp bl, '9'
    jg fin_convertir_str_loop

    sub bl, '0'
    imul eax, 10
    add eax, ebx
    inc esi
    jmp convertir_str_loop
fin_convertir_str_loop:  
    ;pop ebx
    ;pop esi
    mov esp, ebp
    pop ebp
    ret

; Imprime un entero (EAX)
print_int:
    push ebp
    mov ebp, esp
    
    call int_to_str
    
    mov eax, 4
    mov ebx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, nl
    mov edx, 1
    int 0x80

    mov esp, ebp
    pop ebp
    ret

; Retorna un entero (EAX)
scan_int:
    push ebp
    mov ebp, esp

    ; Leer entrada
    mov eax, 3
    mov ebx, 0
    mov ecx, buffer_in
    mov edx, 16
    int 0x80

    call str_to_int

    mov esp, ebp
    pop ebp
    ret









