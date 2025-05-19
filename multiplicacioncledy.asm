section .data
    msg_result db 'Resultado: ', 0
    newline db 10, 0

section .bss
    res resb 1

section .text
    global _start

_start:
    mov al, 5
    mov bl, 10

    mul bl

    mov [res], al

    movzx eax, byte [res]
    call print_number

    mov eax, 1
    xor ebx, ebx
    int 0x80

print_number:
    mov ecx, 10
    xor edx, edx

    mov esi, buffer + 3
    mov byte [esi], 0
    dec esi

print_loop:
    xor edx, edx
    div ecx
    add dl, '0'
    mov [esi], dl
    dec esi
    cmp eax, 0
    jne print_loop

    inc esi

    mov edx, buffer + 4
    sub edx, esi
    mov ecx, esi
    mov ebx, 1
    mov eax, 4
    int 0x80

    ret

section .bss
buffer resb 4
