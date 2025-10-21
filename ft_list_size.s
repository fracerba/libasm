global ft_list_size

section .text
ft_list_size:
    mov     rax, 0          ; rax = element counter (return value)
.while:
    test    rdi, rdi        ; if (list == NULL)
    jz      .done           ;   return 0
    inc     rax             ; increment counter
    mov     rdi, [rdi + 8]  ; load pointer to next node
    jmp     .while          ; continue loop
.done:
    ret