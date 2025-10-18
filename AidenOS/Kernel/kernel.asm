[BITS 32]

[org 0x1000]

section .text
global kernel_main
kernel_main:
    mov eax, str0
    call print_string
    jmp $

; print_string: expects pointer in eax, writes to 0xB8000
print_string:
    pusha
    mov esi, eax        ; string pointer
    mov edi, 0xB8000    ; VGA text buffer
.print_loop:
    lodsb               ; load byte from [esi] into al, inc esi
    test al, al
    jz .print_done
    mov ah, 0x0F        ; attribute (white on black)
    stosw               ; write ax to [edi], edi += 2
    jmp .print_loop
.print_done:
    popa
    ret
section .data
str0 db 75,101,114,110,101,108,32,112,111,119,101,114,101,100,32,98,121,32,65,105,100,101,110,43,43,32,67,111,109,112,105,108,101,100,32,80,114,111,103,114,97,109,109,105,110,103,32,76,97,110,103,117,97,103,101,32,102,111,114,32,120,56,54,0
section .bss
vga_cursor resd 1
