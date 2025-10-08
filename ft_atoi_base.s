global ft_atoi_base

section .text
ft_atoi_base:
    mov     rax, 0          ; rax = return value, buffer
    mov     rcx, 0          ; rcx = src counter
    mov     rdx, 0          ; rdx = base counter
    mov     r8, 0           ; r8 = number
    mov     r9, 0           ; r9 = sign
    mov     r10, 0          ; r10 = base
    mov     r11, 0          ; r11 = digit