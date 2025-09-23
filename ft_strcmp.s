global ft_strcmp

section .text
ft_strcmp:
    mov     rax, 0          ; rax = return value
.loop:
    mov     al, [rdi]       ; load byte at s1 + rax
    mov     dl, [rsi]       ; load byte at s2 + rbx
    cmp     al, dl          ; check difference
    jne     .diff           ; if different, go to diff
    test    al, al          ; check if it's null terminator
    je      .done           ; if null, end
    inc     rdi             ; else, move to next character in s1
    inc     rsi             ; else, move to next character in s2
    jmp     .loop           ; repeat
.diff:
    movzx   eax, al         ; extend al to unsigned 32 bit
    movzx   edx, dl         ; extend dl to unsigned 32 bit
    sub     eax, edx        ; calculate difference
    ret
.done:
    xor     eax, eax        ; return 0
    ret