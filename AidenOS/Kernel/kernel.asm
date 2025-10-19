[BITS 32]

[org 0x1000]

section .text
global kernel_main
kernel_main:
    ; assign to v_key
    mov eax,0
    mov [v_key],al
    mov al,[v_key]
    movzx eax,al
    push eax
    mov eax,0
    pop ebx
    cmp ebx,eax
    sete al
    movzx eax,al
    cmp eax,0
    je skip_label0
    ; assign to v_j
    mov eax,5
    mov [v_j],ax
    ; assign to v_ptr
    lea eax,[v_j]
    mov [v_ptr],eax
    ; assign to v_x
    mov eax,[v_ptr]
    mov ax,[eax]
    movzx eax,ax
    push eax
    mov eax,5
    pop ebx
    add eax,ebx
    mov [v_x],eax
    mov eax,[v_x]
    push eax
    mov eax,5
    pop ebx
    cmp ebx,eax
    setg al
    movzx eax,al
    cmp eax,0
    je skip_label1
    mov eax,[v_x]
    push eax
    mov eax,7
    pop ebx
    cmp ebx,eax
    setg al
    movzx eax,al
    cmp eax,0
    je skip_label2
    mov eax,[v_x]
    push eax
    mov eax,10
    pop ebx
    cmp ebx,eax
    sete al
    movzx eax,al
    cmp eax,0
    je skip_label3
    ; assign to v_i
    mov eax,15
    mov [v_i],eax
    ; assign to v_ptr2x
    lea eax,[v_x]
    mov [v_ptr2x],eax
    ; assign to *v_ptr2x
    mov eax,[v_i]
    push eax
    mov eax,[v_ptr2x]
    pop ebx
    mov [eax],ebx
    mov eax,[v_ptr2x]
    mov eax,[eax]
    push eax
    mov eax,20
    pop ebx
    cmp ebx,eax
    setl al
    movzx eax,al
    cmp eax,0
    je skip_label4
    mov eax,[v_ptr2x]
    mov eax,[eax]
    push eax
    mov eax,15
    pop ebx
    cmp ebx,eax
    sete al
    movzx eax,al
    cmp eax,0
    je skip_label5
    lea esi,[str0]
    mov edi,0xB8000
    call print_string
skip_label5:
skip_label4:
skip_label3:
skip_label2:
skip_label1:
skip_label0:
    mov al,[v_key]
    movzx eax,al
    push eax
    mov eax,1
    pop ebx
    cmp ebx,eax
    sete al
    movzx eax,al
    cmp eax,0
    je skip_label6
    lea esi,[str1]
    mov edi,0xB8000
    call print_string
skip_label6:
    jmp $

print_string:
    pusha
    mov ax,0x10
.print_loop:
    lodsb
    test al,al
    jz .done
    mov ah,0x0F
    stosw
    jmp .print_loop
.done:
    popa
    ret
section .data
str0 db 87,111,114,107,101,100,33,0
str1 db 78,111,116,32,80,111,115,115,105,98,108,101,33,0
section .bss
v_key resb 1
v_j resw 1
v_ptr resd 1
v_x resd 1
v_i resd 1
v_ptr2x resd 1
vga_cursor resd 1
