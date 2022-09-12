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

    # a
    xor eax, eax
    mov al, cl
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, ch
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 1], al

    # b
    xor eax, eax
    mov al, cl
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, ch
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 2], al

    # c
    xor eax, eax
    mov al, cl
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, bl
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 289], al
    mov r11, rax

    # g
    xor eax, eax
    mov al, cl
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, bl
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 578], al
    mov r12, rax

    # k
    xor eax, eax
    mov al, bl
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, bh
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 868], al

    # l
    xor eax, eax
    mov al, bl
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, bh
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 869], al

    # f
    xor eax, eax
    mov al, ch
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, bh
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 292], al
    mov r13, rax

    # j
    xor eax, eax
    mov al, ch
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, bh
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 581], al
    mov r14, rax

    # d
    xor eax, eax
    mov al, r11b
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, r13b
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 290], al


    # e
    xor eax, eax
    mov al, r11b
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, r13b
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 291], al


    # h
    xor eax, eax
    mov al, r12b
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, r14b
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 579], al


    # i
    xor eax, eax
    mov al, r12b
    mov edx, 1
    mul edx
    mov r9, 3
    div r9
    mov r10, rax
    xor eax, eax
    mov al, r14b
    mov edx, 2
    mul edx
    mov r9, 3
    div r9
    add rax, r10
    mov [rsi + 580], al

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

    # Open file
    mov eax, 2
    lea rdi, [rip + out_file]
    mov esi, 1 | 0100
    mov rdx, 0666
    syscall

    # Setup write output file
    mov rdi, rax # File descriptor
    mov rsi, rsp # Buffer
    mov rdx, 83521 # buffer size

.write_loop:
    mov eax, 1   # Operation
    syscall
    add rsi, rax
    sub rdx, rax
    jnz .write_loop

    # Close file
    mov eax, 3
    syscall

    # Exit program
    mov eax, 60
    xor edi, edi
    syscall

.section .rodata
in_file: .asciz "input.img"
out_file: .asciz "output.img"
