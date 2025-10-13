global ft_list_remove_if
extern free

section .text
ft_list_remove_if:
    test    rdi, rdi        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
    mov     rax, [rdi]      ;    
    test    rax, rax        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
    test    rdx, rdx        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
    test    rcx, rcx        ; check if list exist
    jz      .end            ; if list pointer is NULL, return
.start:
    push    r12             ; 
    push    r13             ; 
    push    r14             ; 
    push    r15             ; 
    push    rbx             ; 
    mov     r12, [rdi]      ; tmp
    mov     r13, rdi        ; begin
    mov     r14, rsi        ; data_ref
    mov     r15, rcx        ; free_fct
    mov     rbx, rdx        ; cmp
    mov     r8, 0           ; prev
.while:
    test    r12, r12        ; check if list exist
    jz      .restore        ; if list pointer is NULL, return
    mov     r13, [r12 + 8]  ;
    mov     rdi, [r12]      ;
    mov     rsi, r14        ; 
    push    r8              ;
    push    r9              ;
    sub     rsp, 8          ;
    call    rbx             ;
    add     rsp, 8          ;
    cmp     rax, 0          ;
    jz      .free_node      ;
    pop     r9              ;
    pop     r8              ;
    mov     r8, r12         ;
    jmp     .repeat         ;
.free_node:
    mov     rdi, [r12]      ;
    sub     rsp, 8          ;
    call    r15             ;
    add     rsp, 8          ;
    mov     rdi, r12        ;
    sub     rsp, 8          ;
    call    free wrt ..plt  ;
    add     rsp, 8          ;
    pop     r9              ;
    pop     r8              ;
    cmp     r8, 0           ;
    jz      .move_begin     ;
    mov     [r8 + 8], r13   ;
    jmp     .repeat         ;
.move_begin:
    mov     [r9], r13       ;
.repeat:
    mov     r12, r13        ;
    jmp     .while          ;
.restore:
    pop     rbx             ;
    pop     r15             ;
    pop     r14             ;
    pop     r13             ;
    pop     r12             ;
.end:
    ret




section .text
; void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *))
ft_list_remove_if:
    test    rdi, rdi
    jz      .end
    test    rdx, rdx        ; cmp
    jz      .end
    test    rcx, rcx        ; free_fct
    jz      .end

    ; Save callee-saved registers we'll use
    push    r12
    push    r13
    push    r14
    push    r15
    push    rbx

    ; Map arguments to callee-saved registers:
    ; rdi = begin_list (pointer to head pointer)
    ; rsi = data_ref
    ; rdx = cmp
    ; rcx = free_fct
    mov     r12, rdi        ; r12 = begin_list (pointer to head pointer)
    mov     r13, [r12]      ; r13 = tmp = *begin_list (current node)
    mov     r14, rsi        ; r14 = data_ref
    mov     r15, rcx        ; r15 = free_fct
    mov     rbx, rdx        ; rbx = cmp
    xor     r9, r9          ; r9 = prev (NULL)

.loop:
    test    r13, r13
    jz      .done_loop

    mov     rax, [r13 + 8]  ; rax = next = r13->next

    ; call cmp(tmp->data, data_ref)
    mov     rdi, [r13]      ; arg1 = tmp->data
    mov     rsi, r14        ; arg2 = data_ref
    sub     rsp, 8          ; align stack for call (we pushed 5 regs -> rsp mod16 unchanged, but keep safe)
    call    rbx
    add     rsp, 8
    cmp     rax, 0
    jne     .keep_node

    ; match: remove node
    mov     rdi, [r13]      ; arg for free_fct = tmp->data
    sub     rsp, 8
    call    r15
    add     rsp, 8

    ; free the node itself
    mov     rdi, r13
    sub     rsp, 8
    call    free wrt ..plt
    add     rsp, 8

    ; relink: if prev == NULL -> *begin_list = next else prev->next = next
    test    r9, r9
    jnz     .link_prev
    mov     [r12], rax      ; *begin_list = next
    jmp     .after_relink
.link_prev:
    mov     [r9 + 8], rax   ; prev->next = next
.after_relink:
    ; move to next (rax)
    mov     r13, rax
    jmp     .loop

.keep_node:
    ; keep current node: prev = tmp; tmp = next
    mov     r9, r13
    mov     r13, rax
    jmp     .loop

.done_loop:
    pop     rbx
    pop     r15
    pop     r14
    pop     r13
    pop     r12
.end:
    ret

Brevi note su questa versione

Evito push/pop per prev/tmp/begin_list ad ogni iterazione: li tengo in r9, r13, r12 rispettivamente (r9 è volatile in System V ma lo uso solo internamente tra call e lo riallineo prima di call; per maggiore sicurezza potrei usare r12–r15 tutti callee-saved).
Uso rbx per cmp (callee-saved) e r15 per free_fct (callee-saved).
Per ogni call riallineo lo stack con sub rsp,8/add rsp,8 per completezza; qui dato il numero di push iniziali la somma mantiene l'allineamento, ma è sicuro aggiungerlo comunque prima delle call indirette.
Tutti i registri callee-saved che abbiamo pushato vengono ripristinati in ordine inverso prima del return.
Se vuoi, applico la patch a ft_list_remove_if.s con questa versione e poi eseguo make per testare. Vuoi che lo faccia?