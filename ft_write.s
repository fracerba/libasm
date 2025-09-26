global ft_write
extern __errno_location

section .text
ft_write:
    mov     rax, 1          ; syscall number for write
    syscall                 ; do the syscall
    cmp     rax, 0          ; check for error
    jl      .error          ; if negative go to error
    ret
.error
    neg     rax             ; absolute value of rax
    call    __errno_location
    mov     [rax], eax      ; store eax in errno
    mov     rax, -1         ; return value
    ret