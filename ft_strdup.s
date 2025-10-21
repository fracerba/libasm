global ft_strdup
extern __errno_location
extern malloc

section .text
ft_strdup:
    push    rbx                         ; save callee-saved register rbx
    mov     rbx, rdi                    ; rbx = src pointer (preserve original src)
    xor     rcx, rcx                    ; rcx = length counter
.count:
    mov     dl, [rbx + rcx]             ; load byte src[rcx]
    test    dl, dl                      ; test for null terminator
    jz      .alloc                      ; if zero, go allocate
    inc     rcx                         ; increment length
    jmp     .count                      ; continue counting
.alloc:
    inc     rcx                         ; include space for null terminator
    mov     rdi, rcx                    ; rdi = size for malloc
    call    malloc wrt ..plt            ; call malloc(size)
    test    rax, rax                    ; check if malloc returned NULL
    jz      .error                      ; if NULL, handle error
    mov     rdx, rax                    ; rdx = dest pointer
    mov     rcx, 0                      ; rcx = index 0
.while:
    mov     al, [rbx + rcx]             ; load byte from src[index]
    mov     [rdx + rcx], al             ; store byte to dest[index]
    test    al, al                      ; check for null terminator
    jz      .end                        ; if null, finished copying
    inc     rcx                         ; index++
    jmp     .while                      ; loop
.end:
    mov     rax, rdx                    ; return pointer to duplicated string
    pop     rbx                         ; restore rbx
    ret
.error:
    call    __errno_location wrt ..plt  ; get pointer to errno (returned in rax)
    mov     edi, 12                     ; errno = ENOMEM (12)
    mov     dword [rax], edi            ; *(__errno_location()) = ENOMEM
    mov     rax, 0                      ; return NULL
    pop     rbx                         ; restore rbx
    ret