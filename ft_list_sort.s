global ft_list_sort

section .text
ft_list_sort:
    test    rdi, rdi                    ; check if list exist
    jz      .end                        ; if list pointer is NULL, return
    mov     rax, [rdi]                  ;    
    test    rax, rax                    ; check if list exist
    jz      .end                        ; if list pointer is NULL, return
    test    rdx, [rax + 8]              ; check if list exist
    test    rdx, rdx                    ; check if list exist
    jz      .end                        ; if list pointer is NULL, return
    test    rsi, rsi                    ; check if list exist
    jz      .end                        ; if list pointer is NULL, return
    push    r12                         ;
    push    r13                         ;
    push    rbx                         ;
    mov     r12, rdi                    ;
    mov     rbx, rsi                    ;                         