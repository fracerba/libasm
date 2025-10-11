global ft_strlen

section .text
ft_strlen:
    mov     rax, 0          ; rax = counter, return value
.while:
    mov     dl, [rdi + rax] ; load byte at s + rax
    test    dl, dl          ; check if it's null
    jz      .done           ; if null, end
    inc     rax             ; else, increment counter
    jmp     .while          ; repeat
.done:
    ret