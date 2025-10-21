global ft_write
extern __errno_location

section .text
ft_write:
    mov     rax, 1                      ; syscall number for write
    syscall                             ; perform the syscall
    cmp     rax, 0                      ; if rax < 0, an error occurred
    jl      .error                      ; jump to error handler
    ret                                 ; on success, return bytes written in rax
.error:
    neg     rax                         ; make error code positive
    mov     edi, eax                    ; move 32-bit error code into edi
    push    rdi                         ; preserve rdi across the call
    call    __errno_location wrt ..plt  ; get pointer to errno (returned in rax)
    pop     rdi                         ; restore rdi
    mov     dword [rax], edi            ; *errno = saved error code (32-bit)
    mov     rax, -1                     ; return -1 to indicate error
    ret