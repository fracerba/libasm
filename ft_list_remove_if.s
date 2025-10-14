global ft_list_remove_if
extern free

section .text
ft_list_remove_if:
    test    rdi, rdi        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
    mov     rax, [rdi]      ;    
    test    rax, rax        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
    test    rdx, rdx        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
    test    rcx, rcx        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
.start:
    push    r12             ; 
    push    r13             ; 
    push    r14             ; 
    push    r15             ; 
    push    rbx             ; 
    mov     r12, [rdi]      ; tmp
    mov     r13, rdi        ; begin
    mov     r14, rsi        ; data_ref
    mov     r15, rcx        ; free_fct
    mov     rbx, rdx        ; cmp
    mov     r8, 0           ; prev
.while:
    test    r12, r12        ; check if list exist
    jz      .restore        ; if list pointer is NULL, return
    mov     rdi, [r12]      ;
    mov     rsi, r14        ; 
    push    r8              ;
    sub     rsp, 8          ;
    call    rbx             ;
    cmp     rax, 0          ;
    jz      .free_node      ;
    add     rsp, 8          ;
    pop     r8              ;
    mov     r8, r12         ;
    mov     r12, [r12 + 8]  ;
    jmp     .while          ;
.free_node:
    mov     rdi, [r12]      ;
    call    r15             ;
    add     rsp, 8          ;
    mov     rdi, r12        ;
    mov     r9, [r12 + 8]   ;
    push    r9              ;
    call    free wrt ..plt  ;
    pop     r9              ;
    pop     r8              ;
    cmp     r8, 0           ;
    jz      .move_begin     ;
    mov     [r8 + 8], r9    ;
    jmp     .repeat         ;
.move_begin:
    mov     [r13], r9       ;
.repeat:
    mov     r12, r9         ;
    jmp     .while          ;
.restore:
    pop     rbx             ;
    pop     r15             ;
    pop     r14             ;
    pop     r13             ;
    pop     r12             ;
.end:
    ret