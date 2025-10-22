global ft_list_sort

section .text
ft_list_sort:
    test    rdi, rdi                    ; if (begin_list == NULL)
    jz      .end                        ;   return
    mov     rax, [rdi]                  ; rax = *begin_list (head)
    test    rax, rax                    ; if (head == NULL)
    jz      .end                        ;   return
    mov     rdx, [rax + 8]              ; rdx = head->next
    test    rdx, rdx                    ; if (head->next == NULL)
    jz      .end                        ;   return
    test    rsi, rsi                    ; if (cmp == NULL)
    jz      .end                        ;   return
.start:
    push    r12                         ; save callee-saved register r12
    push    r13                         ; save callee-saved register r13
    push    rbx                         ; save callee-saved register rbx
    mov     r12, rax                    ; r12 = current (outer loop pointer)
    mov     rbx, rsi                    ; rbx = cmp function pointer
.while:
    test    r12, r12                    ; if (current == NULL)
    jz      .restore                    ;   restore and return
    mov     r13, [r12 + 8]              ; r13 = current->next
.while_next:
    test    r13, r13                    ; if (next == NULL)
    jz      .repeat                     ;   advance outer loop
    mov     rdi, [r12]                  ; rdi = current->data
    mov     rsi, [r13]                  ; rsi = next->data
    call    rbx                         ; call cmp(current->data, next->data)
    cmp     rax, 0                      ; compare result to 0
    jg      .swap                       ; if result > 0, swap the data pointers
    jmp     .repeat_next                ; otherwise continue inner loop
.swap:
    mov     rcx, [r12]                  ; rcx = current->data
    mov     rdx, [r13]                  ; rdx = next->data
    mov     [r12], rdx                  ; current->data = saved next->data
    mov     [r13], rcx                  ; next->data = saved current->data
.repeat_next:
    mov     r13, [r13 + 8]              ; move to next->next
    jmp     .while_next                 ; continue inner loop
.repeat:
    mov     r12, [r12 + 8]              ; advance outer loop: current = current->next
    jmp     .while                      ; continue outer loop
.restore:
    pop     rbx                         ; restore saved register rbx
    pop     r13                         ; restore saved register r13
    pop     r12                         ; restore saved register r12
.end:
    ret