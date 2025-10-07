global ft_list_push_front
extern __errno_location
extern malloc

section .text
ft_list_push_front:
    test    rdi, rdi                    ; check if list exist
    jz      .done                       ; if list is empty return
    mov     r8, rdi                     ; else, move list to r8
    mov     rdi, 16                     ; number of bytes to allocate
    call    malloc wrt ..plt            ; syscall to malloc
    test    rax, rax                    ; check if malloc failed
    jz      .error                      ; if NULL, handle error
    mov     rdi, rax                    ; rdi = new element
    mov     [rdi], rsi                  ; move content of data in rdi
    mov     [rdi + 8], r8               ; link r8 to rdi
.done:
    ret
.error:
    mov     eax, 12                     ; set errno to ENOMEM (12)
    call    __errno_location wrt ..plt  ; get pointer to errno
    mov     [rax], eax                  ; store eax in errno
    ret
