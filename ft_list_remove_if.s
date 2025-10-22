global ft_list_remove_if
extern free

section .text
ft_list_remove_if:
    test    rdi, rdi        ; if (begin_list == NULL)
    jz      .end            ;   return
    mov     rax, [rdi]      ; rax = *begin_list (head)
    test    rax, rax        ; if (head == NULL)
    jz      .end            ;   return
    test    rdx, rdx        ; if (cmp == NULL)
    jz      .end            ;   return
    test    rcx, rcx        ; if (free_fct == NULL)
    jz      .end            ;   return
.start:
    push    r12             ; save callee-saved register r12
    push    r13             ; save callee-saved register r13
    push    r14             ; save callee-saved register r14
    push    r15             ; save callee-saved register r15
    push    rbx             ; save callee-saved register rbx
    mov     r12, [rdi]      ; r12 = current node (tmp)
    mov     r13, rdi        ; r13 = begin_list (pointer to head)
    mov     r14, rsi        ; r14 = data_ref
    mov     r15, rcx        ; r15 = free_fct
    mov     rbx, rdx        ; rbx = cmp function pointer
    mov     r8, 0           ; r8 = prev (NULL)
.while:
    test    r12, r12        ; if (current == NULL)
    jz      .restore        ;   restore and return  
    mov     rdi, [r12]      ; rdi = tmp->data
    mov     rsi, r14        ; rsi = data_ref
    push    r8              ; preserve prev on stack
    sub     rsp, 8          ; align stack before calling cmp
    call    rbx             ; cmp(tmp->data, data_ref)
    cmp     rax, 0          ; if (cmp == 0)
    jz      .free_node      ;   remove node
    add     rsp, 8          ; undo the sub before call (stack balanced)
    pop     r8              ; restore prev from stack
    mov     r8, r12         ; prev = tmp
    mov     r12, [r12 + 8]  ; tmp = tmp->next
    jmp     .while          ; continue loop
.free_node:
    mov     rdi, [r12]      ; rdi = tmp->data
    call    r15             ; free_fct(tmp->data)
    add     rsp, 8          ; undo the sub before call (stack balanced)
    mov     rdi, r12        ; rdi = node to free
    mov     r9, [r12 + 8]   ; r9 = next = tmp->next
    push    r9              ; preserve next on stack (save & align)
    call    free wrt ..plt  ; free(node)
    pop     r9              ; restore next from stack
    pop     r8              ; restore prev from stack
    cmp     r8, 0           ; if (prev == NULL)
    jz      .move_begin     ;   move begin_list
    mov     [r8 + 8], r9    ; prev->next = next
    jmp     .repeat         ; advance tmp to next
.move_begin:
    mov     [r13], r9       ; *begin_list = next
.repeat:
    mov     r12, r9         ; tmp = next
    jmp     .while          ; continue loop
.restore:
    pop     rbx             ; restore callee-saved register rbx
    pop     r15             ; restore callee-saved register r15
    pop     r14             ; restore callee-saved register r14
    pop     r13             ; restore callee-saved register r13
    pop     r12             ; restore callee-saved register r12
.end:
    ret