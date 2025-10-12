global ft_atoi_base

section .text
ft_atoi_base:
    mov     rax, 0          ; rax = return value, str buffer
    mov     rcx, -1         ; rcx = src counter
    mov     rdx, 0          ; rdx = base counter
    mov     r8, 0           ; r8 = number
    mov     r9, 1           ; r9 = sign
    mov     r10, -1         ; r10 = base
.start:
    test    rdi, rdi        ; 
    jz      .error          ;
    test    rsi, rsi        ;
    jz      .error          ;
.length:
    inc     r10             ; else, increment counter
    mov     al, [rsi + r10] ; load byte at s + rax
    test    al, al          ; check if it's null
    jz      .checklen       ; if null, end
    cmp     al, 8           ;
    jg      .lengthaux      ;
    mov     rdx, r10        ;
    jmp     .checkdup       ;
.lengthaux
    cmp     al, 14          ;
    jl      .error          ;
    cmp     al, 32          ;
    je      .error          ;
    cmp     al, 43          ;
    je      .error          ;
    cmp     al, 45          ;
    je      .error          ;
    mov     rdx, r10        ;
.checkdup:
    inc     rdx             ;
    mov     ah, [rsi + rdx] ;
    test    ah, ah          ;
    jz      .length         ;
    cmp     al, ah          ;
    je      .error          ;
    jmp     .checkdup       ;
.checklen:
    cmp     r10, 2          ;
    jl      .error          ;
.checkspaces:
    inc     rcx             ;
    mov     al, [rdi + rcx] ; load byte at s + rax
    test    al, al          ; check if it's null
    jz      .error          ; if null, end
    cmp     al, 8           ;
    jg      .checkspacesaux ;
    jmp     .checksign      ;
.checkspacesaux
    cmp     al, 14          ;
    jl      .checkspaces    ;
    cmp     al, 32          ;
    je      .checkspaces    ;
.checksign:
    cmp     al, 43          ;
    je      .handleplus     ;
    cmp     al, 45          ;
    je      .handleminus    ;
    jmp     .checknum       ;
.handleminus:
    neg     r9              ;
.handleplus:
    inc     rcx             ;
    jmp     .checknum       ;
.checknum:
    mov     al, [rdi + rcx] ; load byte at s + rax
    test    al, al          ; check if it's null
    jz      .return         ; if null, end
    mov     rax, r10        ;
    imul    r8              ;
    mov     r8, rax         ;
    mov     al, [rdi + rcx] ; load byte at s + rax
    mov     rdx, 0          ;
.findvalue:
    mov     ah, [rsi + rdx] ;
    test    ah, ah          ;
    jz      .return         ;
    cmp     ah, al          ;
    je      .addnum         ;
    inc     rdx             ;
    jmp     .findvalue      ;
.addnum:
    add     r8, rdx         ;
    inc     rcx             ;
    jmp     .checknum       ;
.return:
    mov     rax, r9         ;
    imul    r8              ;
    ret
.error:
    mov     rax, 0          ;
    ret