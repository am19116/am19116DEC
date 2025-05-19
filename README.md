# Ejercicios de Lenguaje Ensamblador

## Objetivo
Aplicar los conocimientos obtenidos sobre los fundamentos del lenguaje ensamblador en sistemas GNU/Linux para elaborar programas en ensamblador que realicen operaciones básicas.

## Ejercicios realizados

### 1. Resta de tres enteros
Programa que resta tres números enteros utilizando registros de 16 bits.  
Archivo: `resta3.asm`

### 2. Multiplicación
Programa que multiplica dos números enteros utilizando registros de 8 bits.  
Archivo: `multiplicacioncledy.asm`

### 3. División
Programa que divide dos números enteros utilizando registros de 32 bits.  
Archivo: `division.asm`

## Uso
Para compilar cada programa, usa los siguientes comandos (ejemplo para `resta3.asm`):

```bash
nasm -f elf32 resta3.asm -o resta3.o
ld -m elf_i386 resta3.o -o resta3
./resta3
