global ft_atoi_base

section .text
ft_atoi_base:
    mov     rax, 0          ; rax = return value
    mov     rcx, 0          ; rcx = sign 
    mov     rdx, 0          ; rdx = base value
    mov     r8, 0           ; r8 = str counter
    mov     r9, 0           ; r9 = base counter