global ft_strcmp

section .text
ft_strcmp:
    mov     rax, 0          ; rax = return value
.while:
    mov     al, [rdi]       ; load byte from s1 into al
    mov     dl, [rsi]       ; load byte from s2 into dl
    cmp     al, dl          ; compare characters
    jne     .diff           ; if different, compute difference
    test    al, al          ; check for NUL terminator
    jz      .done           ; if NUL, strings equal, jump to .done
    inc     rdi             ; advance s1 pointer
    inc     rsi             ; advance s2 pointer
    jmp     .while          ; continue loop
.diff:
    movzx   eax, al         ; zero-extend s1 char to eax (unsigned)
    movzx   edx, dl         ; zero-extend s2 char to edx (unsigned)
    sub     eax, edx        ; return (int)(unsigned char)s1 - (int)(unsigned char)s2
    ret
.done:
    xor     eax, eax        ; return 0
    ret