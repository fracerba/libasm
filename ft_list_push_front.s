global ft_list_push_front
extern __errno_location
extern malloc

section .text
ft_list_push_front:
    test    rdi, rdi                    ; check if list exist
    jz      .end                        ; if list pointer is NULL, return
    push    rbx                         ;
    push    rsi                         ;
    mov     rbx, rdi                    ; save begin_list pointer in rbx
    mov     rdi, 16                     ; number of bytes to allocate
    sub     rsp, 8                      ;
    call    malloc wrt ..plt            ; call malloc
    test    rax, rax                    ; check if malloc failed
    jz      .error                      ; if NULL, handle error
    add     rsp, 8                      ;
    pop     rsi                         ;
    mov     [rax], rsi                  ; new->data = data
    mov     rdx, [rbx]                  ; rdx = *begin_list (old head)
    test    rdx, rdx                    ; 
    jz      .set_null                   ; 
    mov     [rax + 8], rdx              ; link rbx to rdi
    jmp     .done                       ;
.set_null:
    mov     qword [rax + 8], 0          ; new->next = NULL
.done:
    mov     [rbx], rax                  ; begin_list
    pop     rbx                         ;
.end:
    ret
.error:
    call    __errno_location wrt ..plt  ; get pointer to errno
    add     rsp, 8                      ;
    mov     edi, 12                     ; set errno to ENOMEM (12)
    mov     dword [rax], edi            ; store error code in errno
    pop     rsi                         ;
    pop     rbx                         ;
    ret
