global ft_list_push_front
extern __errno_location
extern malloc

section .text
ft_list_push_front:
    test    rdi, rdi                    ; if (begin_list == NULL)
    jz      .end                        ;   return
    push    rbx                         ; save callee-saved registers
    push    rsi                         ; save data argument across malloc
    mov     rbx, rdi                    ; save begin_list pointer in rbx
    mov     rdi, 16                     ; size to allocate (sizeof(t_list))
    sub     rsp, 8                      ; align stack for call
    call    malloc wrt ..plt            ; call malloc
    test    rax, rax                    ; check if malloc returned NULL
    jz      .error                      ; if NULL, handle error
    add     rsp, 8                      ; restore stack after call
    pop     rsi                         ; restore data argument into rsi
    mov     [rax], rsi                  ; new->data = data
    mov     rdx, [rbx]                  ; rdx = *begin_list (old head)
    test    rdx, rdx                    ; if old head == NULL
    jz      .set_null                   ; then set new->next = NULL
    mov     [rax + 8], rdx              ; new->next = old head
    jmp     .done                       ; branch to finish
.set_null:
    mov     qword [rax + 8], 0          ; new->next = NULL
.done:
    mov     [rbx], rax                  ; *begin_list = new
    pop     rbx                         ; restore rbx
.end:
    ret
.error:
    call    __errno_location wrt ..plt  ; get pointer to errno
    add     rsp, 8                      ; restore stack before touching saved registers
    mov     edi, 12                     ; set errno to ENOMEM (12)
    mov     dword [rax], edi            ; store errno value at *(__errno_location())
    pop     rsi                         ; restore saved rsi
    pop     rbx                         ; restore saved rbx
    ret
