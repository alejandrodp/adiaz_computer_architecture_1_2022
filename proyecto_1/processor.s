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

.section .rodata
in_file: .asciz "input.img"
out_file: .asciz "output.img"
