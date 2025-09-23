global ft_strlen

section .text
ft_strlen:
    mov     rax, 0          ; rax = counter, return value
.loop:
    mov     dl, [rdi + rax] ; load byte at s + rax
    test    dl, dl          ; check if it's zero
    jz      .done           ; if zero, end
    inc     rax             ; else, increment counter
    jmp     .loop           ; repeat
.done:
    ret