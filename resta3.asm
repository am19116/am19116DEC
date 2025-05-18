section .data
    texto     db "Resultado: ", 0
    numstr    db "     ", 10, 0

section .text
    global _start

_start:
    mov ax, 100
    mov bx, 30
    sub ax, bx
    mov cx, 20
    sub ax, cx

    movzx rsi, ax
    lea rdi, [numstr + 4]

    mov rcx, 0

.convert_loop:
    xor rdx, rdx
    mov rax, rsi
    mov rbx, 10
    div rbx
    add dl, '0'
    mov [rdi], dl
    dec rdi
    inc rcx
    mov rsi, rax
    test rsi, rsi
    jnz .convert_loop

    inc rdi

    mov r12, rdi         ; guardar puntero al inicio número

    mov rax, 1
    mov rdi, 1
    mov rsi, texto
    mov rdx, 10
    syscall

    mov rax, 1
    mov rdi, 1
    mov rsi, r12         ; puntero a número convertido
    mov rdx, rcx         ; cantidad de dígitos
    syscall

    mov rax, 60
    xor rdi, rdi
    syscall


