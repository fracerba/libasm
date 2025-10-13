global ft_read
extern __errno_location

section .text
ft_read:
    mov     rax, 0                      ; syscall number for read
    syscall                             ; perform the syscall
    cmp     rax, 0                      ; check if return value is negative (error)
    jl      .error                      ; if error, jump to error handler
    ret                                 ; on success, return
.error:
    neg     rax                         ; get positive error code
    mov     edi, eax                    ; save error code in edi
    push    rdi                         ;
    call    __errno_location wrt ..plt  ; get pointer to errno
    pop     rdi                         ;
    mov     [rax], edi                  ; store error code in errno
    mov     rax, -1                     ; return -1 on error
    ret