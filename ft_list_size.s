global ft_list_size

section .text
ft_list_size:
    mov     rax, 0          ; rax = counter, return value
.while:
    test    rdi, rdi        ; check if it's zero
    jz      .done           ; if zero, end
    inc     rax             ; else, increment counter
    mov     rdi, [rdi + 8]  ; load next node
    jmp     .while          ; repeat
.done:
    ret