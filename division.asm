section .data
    mensaje db "Resultado: ", 0

section .bss
    resultado resb 10

section .text
    global _start

_start:
    ; --- Cargar valores ---
    mov eax, 100         ; dividendo (parte baja)
    cdq                  ; extender signo de EAX a EDX para IDIV (EDX:EAX)
    mov ebx, 25          ; divisor

    idiv ebx             ; EAX = EAX / EBX, resultado queda en EAX

    ; --- Convertir resultado en cadena ---
    mov ecx, resultado + 9 ; apuntar al final del buffer
    mov byte [ecx], 0     ; terminador null

convertir:
    dec ecx
    xor edx, edx
    mov ebx, 10
    div ebx
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz convertir

    ; --- Imprimir mensaje ---
    mov eax, 4          ; syscall: write
    mov ebx, 1          ; STDOUT
    mov ecx, mensaje
    mov edx, 10
    int 0x80

    ; --- Imprimir resultado ---
    mov eax, 4
    mov ebx, 1
    mov edx, resultado + 9
    sub edx, ecx        ; longitud del número
    mov eax, 4
    mov ebx, 1
    mov edx, edx        ; longitud
    int 0x80

    ; --- Salir del programa ---
    mov eax, 1
    xor ebx, ebx
    int 0x80
