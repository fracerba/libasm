global ft_strdup
extern __errno_location
extern malloc

section .text
ft_strdup:
    mov     r8, rdi                     ; rdi = src pointer
    xor     rcx, rcx                    ; rcx = counter
.count:
    mov     dl, [r8 + rcx]              ; load byte at src + rcx
    test    dl, dl                      ; check for null terminator
    jz      .alloc                      ; if null, go to alloc
    inc     rcx                         ; else, increment counter
    jmp     .count                      ; repeat
.alloc:
    inc     rcx                         ; increment rcx for null terminator
    mov     rdi, rcx                    ; number of bytes to allocate
    call    malloc wrt ..plt            ; syscall to malloc
    test    rax, rax                    ; check if malloc failed
    jz      .error                      ; if NULL, handle error
    mov     rdx, rax                    ; rdx = dest pointer
    mov     rcx, 0                      ; rcx = index
.loop:
    mov     al, [r8 + rcx]              ; load byte from src
    mov     [rdx + rcx], al             ; store byte to dest
    test    al, al                      ; check for null terminator
    jz      .end                        ; if null, go to end
    inc     rcx                         ; else, move to next character in src
    jmp     .loop                       ; repeat
.end:
    mov     rax, rdx                    ; return pointer to duplicated string
    ret
.error:
    mov     edi, 12                     ; set errno to ENOMEM (12)
    call    __errno_location wrt ..plt  ; get pointer to errno
    mov     [rax], edi                  ; store error code in errno
    mov     rax, 0                      ; return NULL
    ret