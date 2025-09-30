global ft_read
extern __errno_location

section .text
ft_read:
    mov     rax, 0              ; syscall number for read
    syscall                     ; perform the syscall
    cmp     rax, 0              ; check if return value is negative (error)
    jl      .error              ; if error, jump to error handler
    ret                         ; on success, return
.error:
    neg     rax                 ; get positive error code
    call    __errno_location    ; get pointer to errno
    mov     [rax], eax          ; store error code in errno
    mov     rax, -1             ; return -1 on error
    ret