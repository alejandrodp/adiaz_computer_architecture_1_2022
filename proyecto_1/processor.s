.intel_syntax noprefix

.text
.global _start


_start:
    sub rsp, 9416 # 97^2 = 9409 alineado a 8 bytes

    # Open input file
    mov eax, 2
    lea rdi, [rip + in_file]
    xor esi, esi
    syscall

    # Setup read input file
    mov rdi, rax # File descriptor
    mov rsi, rsp # Buffer
    mov rdx, 9409   # buffer size

.read_loop:
    xor eax, eax   # Operation
    syscall
    add rsi, rax
    sub rdx, rax
    jnz .read_loop

    # Close input file
    mov eax, 3
    syscall

    mov rbp, rsp
    sub rsp, 83528 # (96*3+1)^2=83521 alineado a 8 bytes
    mov rsi, rsp # Guardar rsp

    mov r8, 9311 # 9409-97-1 El último pixel que conforma bloque
    #mov r8, 98 # 9409-97-1 El último pixel que conforma bloque
    mov edi, 96   # Cantidad de bloques

.main_loop:
    xor ebx, ebx
    xor ecx, ecx
    # Cargar esquinas originales
    mov cl, [rbp] # esquina izq sup
    mov ch, [rbp + 1] # esquina der sup
    mov bl, [rbp + 97] # esquina izq inf
    mov bh, [rbp + 98] # esquina der inf
    # Guarda esquinas originales
    mov [rsi], cl
    mov [rsi + 3], ch
    mov [rsi + 867], bl
    mov [rsi + 870], bh

    inc rbp
    add rsi, 3
    dec edi
    jnz .cambia_bloque

    inc rbp
    add rsi, 579
    mov edi, 96

.cambia_bloque:
    dec r8
    jnz .main_loop

.section .rodata
in_file: .asciz "input.img"
out_file: .asciz "output.img"
