global ft_strcpy

section .text
ft_strcpy:
    mov     rax, rdi        ; rax = return value, rdi = dest
.while:
    mov     dl, [rsi]       ; load byte from src
    mov     [rdi], dl       ; load character in dest
    test    dl, dl          ; check if it's null 
    jz      .done           ; if null, finish
    inc     rdi             ; advance dest pointer
    inc     rsi             ; advance src pointer
    jmp     .while          ; repeat
.done:
    ret