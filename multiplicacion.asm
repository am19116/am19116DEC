section .data
    mensaje db "Resultado: ", 0
    saltoLinea db 10, 0

section .bss
    resultado resb 4  ; Para almacenar el número como texto (hasta 3 dígitos + null)

section .text
    global _start

_start:
    ; Cargar valores en AL y BL
    mov al, 5       ; Primer número
    mov bl, 7       ; Segundo número

    ; Multiplicar AL * BL → Resultado en AX
    mul bl

    ; Convertir AX a cadena (AX = resultado)
    movzx eax, ax           ; EAX = AX (extensión con ceros)
    call int_to_ascii

    ; Mostrar mensaje "Resultado: "
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, mensaje
    mov edx, 10
    int 0x80

    ; Mostrar el número convertido
    mov eax, 4
    mov ebx, 1
    mov ecx, resultado
    mov edx, 4              ; máximo 3 dígitos y null
    int 0x80

    ; Salto de línea
    mov eax, 4
    mov ebx, 1
    mov ecx, saltoLinea
    mov edx, 1
    int 0x80

    ; Salir del programa
    mov eax, 1              ; sys_exit
    xor ebx, ebx
    int 0x80

; -----------------------------------------
; Subrutina: int_to_ascii (EAX contiene el número)
; Convierte entero a cadena ASCII (almacena en [resultado])
int_to_ascii:
    mov ecx, resultado + 3  ; puntero al final del buffer
    mov byte [ecx], 0       ; null terminator

.convert_loop:
    dec ecx
    xor edx, edx
    mov ebx, 10
    div ebx                 ; EAX ÷ 10, cociente en EAX, residuo en EDX
    add dl, '0'
    mov [ecx], dl
    test eax, eax
    jnz .convert_loop

    ; Copiar el número al inicio del buffer
    mov esi, ecx
    mov edi, resultado
.copy_loop:
    lodsb
    stosb
    test al, al
    jnz .copy_loop

    ret

