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
    mov     [rax], rsi                  ; move content of data in rax
    mov     rdx, [r8]                   ; rdi = new element
    test    rdx, rdx                    ; 
    jz      .set_null                   ;
    mov     [rax + 8], rdx              ; link r8 to rdi
    mov     [r8], rax                   ; begin_list
.done:
    ret
.set_null:
    mov     qword [rax + 8], 0          ; new->next = NULL
    mov     [r8], rax                   ; begin_list
    ret
.error:
    mov     edi, 12                     ; set errno to ENOMEM (12)
    call    __errno_location wrt ..plt  ; get pointer to errno
    mov     [rax], edi                  ; store error code in errno
    ret
