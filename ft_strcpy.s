global ft_strcpy

section .text
ft_strcpy:
    mov     rax, rdi          ; rax = return value
.loop:
    mov     dl, [rsi]       ; load byte from src
    mov     [rdi], dl       ; load character in dest
    inc     rdi             ; else, move to next character in dest
    inc     rsi             ; else, move to next character in src
    test    dl, dl          ; check difference
    jz      .done           ; if null, go to done
    jmp     .loop           ; repeat
.done:
    ret