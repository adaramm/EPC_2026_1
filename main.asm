%include "io.asm"
section .data
    numero db 0
    prompt db "Ingresa un número: ", 0
    len equ $-prompt

section .text
    global _start

_start:
    ; Mostrar prompt
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, len
    int 0x80

    call scan_int
    mov [numero], eax

    call print_int

    mov eax, 1   ; sys_exit
    xor ebx, ebx
    int 0x80