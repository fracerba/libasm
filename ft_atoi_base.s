global ft_atoi_base

section .text
ft_atoi_base:
    mov     rax, 0              ; rax = return value, str buffer
    mov     rcx, -1             ; rcx = src counter
    mov     rdx, 0              ; rdx = base counter
    mov     r8, 0               ; r8 = number
    mov     r9, 1               ; r9 = sign
    mov     r10, -1             ; r10 = base
.start:
    test    rdi, rdi            ; 
    jz      .error              ;
    test    rsi, rsi            ;
    jz      .error              ;
.length:
    inc     r10                 ; else, increment counter
    mov     al, [rsi + r10]     ; load byte at s + rax
    test    al, al              ; check if it's null
    jz      .checklen           ; if null, end
    cmp     al, 8               ;
    jg      .length_aux         ;
    mov     rdx, r10            ;
    jmp     .check_dup          ;
.length_aux:
    cmp     al, 14              ;
    jl      .error              ;
    cmp     al, 32              ;
    je      .error              ;
    cmp     al, 43              ;
    je      .error              ;
    cmp     al, 45              ;
    je      .error              ;
    mov     rdx, r10            ;
.check_dup:
    inc     rdx                 ;
    mov     ah, [rsi + rdx]     ;
    test    ah, ah              ;
    jz      .length             ;
    cmp     al, ah              ;
    je      .error              ;
    jmp     .check_dup          ;
.checklen:
    cmp     r10, 2              ;
    jl      .error              ;
.check_spaces:
    inc     rcx                 ;
    mov     al, [rdi + rcx]     ; load byte at s + rax
    test    al, al              ; check if it's null
    jz      .error              ; if null, end
    cmp     al, 8               ;
    jg      .check_spaces_aux   ;
    jmp     .check_sign         ;
.check_spaces_aux:
    cmp     al, 14              ;
    jl      .check_spaces       ;
    cmp     al, 32              ;
    je      .check_spaces       ;
.check_sign:
    cmp     al, 43              ;
    je      .handle_plus        ;
    cmp     al, 45              ;
    je      .handle_minus       ;
    jmp     .check_num          ;
.handle_minus:
    neg     r9                  ;
.handle_plus:
    inc     rcx                 ;
    jmp     .check_num          ;
.check_num:
    mov     al, [rdi + rcx]     ; load byte at s + rax
    test    al, al              ; check if it's null
    jz      .return             ; if null, end
    imul    r8, r10             ;
    mov     al, [rdi + rcx]     ; load byte at s + rax
    mov     rdx, 0              ;
.find_value:
    mov     ah, [rsi + rdx]     ;
    test    ah, ah              ;
    jz      .return             ;
    cmp     ah, al              ;
    je      .add_num            ;
    inc     rdx                 ;
    jmp     .find_value         ;
.add_num:
    add     r8, rdx             ;
    inc     rcx                 ;
    jmp     .check_num          ;
.return:
    mov     rax, r8             ;
    imul    rax, r9             ;
    ret
.error:
    mov     rax, 0              ;
    ret