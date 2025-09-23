%include "io.asm"

section .data
    numero db 0
    prompt db "Ingresa un número: ", 0
    len equ $-prompt
    prompt2 db "El factorial de n es: ",0
    len2 equ $-prompt2

section .text
    global _start

factorial:
    push ebp
    mov ebp, esp

    mov ecx, 1          ; res = 1
    mov eax, [ebp+8]    ; eax = n
_while:
    cmp eax, 1
    jbe fin_while

    imul ecx, eax
    dec  eax
    jmp _while

fin_while:
    mov eax, ecx
    mov esp, ebp
    pop ebp
    ret


_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, len
    int 0x80
    call scan_int
    push eax
    call factorial
    push eax
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt2
    mov edx, len2
    int 0x80
    pop eax
    call print_int
    pop eax
    mov eax, 1
    xor ebx, ebx
    int 0x80