global ft_atoi_base

section .text
ft_atoi_base:
    mov     rax, 0              ; rax = return value / temp
    mov     rcx, -1             ; rcx = str index (will be incremented before use)
    mov     rdx, 0              ; rdx = temp/index for base scanning
    mov     r8, 0               ; r8 = accumulated number
    mov     r9, 1               ; r9 = sign (1 or -1)
    mov     r10, -1             ; r10 = base length counter
.start:
    test    rdi, rdi            ; if (str == NULL)
    jz      .error              ;   return 0
    test    rsi, rsi            ; if (base == NULL)
    jz      .error              ;   return 0
.length:
    inc     r10                 ; increment base length counter
    mov     al, [rsi + r10]     ; al = base[r10]
    test    al, al              ; if base[r10] == 0 -> end of base string
    jz      .checklen           ; check base length
    cmp     al, 8               ; if al <= 8 (control)
    jg      .length_aux         ; continue checking
    mov     rdx, r10            ; rdx = base length
    jmp     .check_dup          ; check duplicates
.length_aux:
    cmp     al, 14              ; invalid control chars < 14
    jl      .error              ;   error
    cmp     al, 32              ; space invalid
    je      .error              ;   error
    cmp     al, 43              ; '+' invalid
    je      .error              ;   error
    cmp     al, 45              ; '-' invalid
    je      .error              ;   error
    mov     rdx, r10            ; rdx = base length
.check_dup:
    inc     rdx                 ; check duplicates: compare base[r10] with following chars
    mov     ah, [rsi + rdx]     ; ah = base[rdx]
    test    ah, ah              ; if ah == 0 -> end of base string
    jz      .length             ; no duplicate for this char, continue scanning base
    cmp     al, ah              ; compare base[r10] with base[rdx]
    je      .error              ; duplicate found -> error
    jmp     .check_dup          ; continue checking duplicates
.checklen:
    cmp     r10, 2              ; base length < 2 -> error
    jl      .error              ;   return 0
.check_spaces:
    inc     rcx                 ; skip leading whitespace in str
    mov     al, [rdi + rcx]     ; al = str[rcx]
    test    al, al              ; if (al == 0)
    jz      .error              ; if end of string, return 0
    cmp     al, 8               ; check for whitespace characters
    jg      .check_spaces_aux   ; if al > 8, check next
    jmp     .check_sign         ; is whitespace, continue skipping
.check_spaces_aux:
    cmp     al, 14              ; if al < 14, it's whitespace
    jl      .check_spaces       ; continue skipping
    cmp     al, 32              ; if al == 32 (space)
    je      .check_spaces       ; continue skipping
.check_sign:
    cmp     al, 43              ; '+'
    je      .handle_plus        ; handle plus sign
    cmp     al, 45              ; '-'
    je      .handle_minus       ; handle minus sign
    jmp     .check_num          ; no sign, continue parsing number
.handle_minus:
    neg     r9                  ; sign = -1
.handle_plus:
    inc     rcx                 ; skip sign character
    jmp     .check_num          ; continue parsing number
.check_num:
    mov     al, [rdi + rcx]     ; al = str[rcx]
    test    al, al              ; if (al == 0)
    jz      .return             ; end of string -> return accumulated value
    mov     al, [rdi + rcx]     ; reload al
    mov     rdx, 0              ; rdx = index into base for search
.find_value:
    mov     ah, [rsi + rdx]     ; ah = base[rdx]
    test    ah, ah              ; if (ah == 0)
    jz      .return             ; char not found in base -> finish parsing
    cmp     ah, al              ; compare base[rdx] with current char
    je      .add_num            ; match found
    inc     rdx                 ; advance base index
    jmp     .find_value         ; continue searching
.add_num:
    imul    r8, r10             ; r8 *= base_length
    add     r8, rdx             ; r8 += digit_value
    inc     rcx                 ; advance input index
    jmp     .check_num          ; continue parsing number
.return:
    mov     rax, r8             ; rax = accumulated number
    imul    rax, r9             ; apply sign
    ret
.error:
    mov     rax, 0              ; return 0 on error
    ret