global ft_strcpy

section .text
ft_strcpy:
    mov     rax, rdi        ; rax = return value, rdi = dest
.while:
    mov     dl, [rsi]       ; load byte from src
    mov     [rdi], dl       ; load character in dest
    test    dl, dl          ; check if it's null 
    jz      .done           ; if null, go to done
    inc     rdi             ; else, move to next character in dest
    inc     rsi             ; move to next character in src
    jmp     .while          ; repeat
.done:
    ret