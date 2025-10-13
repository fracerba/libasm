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
    mov     r12, rax                    ;
    mov     rbx, rsi                    ;
.while:
    mov     rdx, [r12]                  ;    
    test    rdx, rdx                    ; check if list exist
    jz      .end                        ; if list pointer is NULL, return
    mov     r13, [r12 + 8]              ;
.while_next:
    mov     rdx, [r13]                  ;    
    test    rdx, rdx                    ; check if list exist
    jz      .repeat                     ; if list pointer is NULL, return
    mov     rdi, [r12]                  ;
    mov     rsi, [r13]                  ; 
    call    rbx                         ;
    cmp     rax, 0                      ;
    jg      .swap                       ;
    jmp     .repeat_next                ;
.swap:
    mov     rcx, [r12]                  ;
    mov     r12, r13                    ;
    mov     r13, rcx                    ;
.repeat_next:
    mov     rdx, [r13 + 8]              ;
    mov     r13, rdx                    ;
    jmp     .while_next                 ;
.repeat:
    mov     rdx, [r12 + 8]              ;
    mov     r12, rdx                    ;
    jmp     .while                      ;
.end:
    ret