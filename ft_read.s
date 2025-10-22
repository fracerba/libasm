global ft_read
extern __errno_location

section .text
ft_read:
    mov     rax, 0                      ; syscall number for read
    syscall                             ; perform the syscall
    cmp     rax, 0                      ; if rax < 0, an error occurred
    jl      .error                      ; jump to error handler
    ret                                 ; on success, return value in rax
.error:
    neg     rax                         ; make error code positive
    mov     edi, eax                    ; move 32-bit error code into edi
    push    rdi                         ; preserve rdi across the call
    call    __errno_location wrt ..plt  ; get pointer to errno (returned in rax)
    pop     rdi                         ; restore rdi
    mov     dword [rax], edi            ; *errno = saved error code (32-bit)
    mov     rax, -1                     ; return -1 to indicate error
    ret