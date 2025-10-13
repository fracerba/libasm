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
.start:
    push    r12                         ;
    push    r13                         ;
    push    rbx                         ;
    mov     r12, rax                    ;
    mov     rbx, rsi                    ;
.while:
    test    r12, r12                    ; check if list exist
    jz      .restore                    ; if list pointer is NULL, return
    mov     r13, [r12 + 8]              ;
.while_next:
    test    r13, r13                    ; check if list exist
    jz      .repeat                     ; if list pointer is NULL, return
    mov     rdi, [r12]                  ;
    mov     rsi, [r13]                  ; 
    sub     rsp, 8                      ;
    call    rbx                         ;
    add     rsp, 8                      ;
    cmp     rax, 0                      ;
    jg      .swap                       ;
    jmp     .repeat_next                ;
.swap:
    mov     rcx, [r12]                  ;
    mov     rdx, [r13]                  ;
    mov     [r12], rdx                  ;
    mov     [r13], rcx                  ;
.repeat_next:
    mov     r13, [r13 + 8]              ;
    jmp     .while_next                 ;
.repeat:
    mov     r12, [r12 + 8]              ;
    jmp     .while                      ;
.restore:
    pop     rbx                         ;
    pop     r13                         ;
    pop     r12                         ;
.end:
    ret