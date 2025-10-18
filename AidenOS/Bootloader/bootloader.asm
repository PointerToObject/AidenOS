[org 0x7C00]
[BITS 16]
start:
    mov dx, 0x3F8
    mov al, 'B'  ; Bootloader start
    out dx, al

    ; Setup segments and stack
    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7BFE  ; Stack below code

    mov al, 'S'  ; Segments set
    out dx, al

    ; Debug before read
    mov al, 'R'  ; Before read
    out dx, al

    ; Reset hard disk
    mov ah, 0x00
    mov dl, 0x80  ; Hard disk 0
    int 0x13
    jc reset_fail
    mov al, 'Z'  ; Reset success
    out dx, al
    jmp read_sector

reset_fail:
    mov al, 'X'  ; Reset failed
    out dx, al
    jmp hang

read_sector:
    ; Load kernel
    mov ah, 0x02
    mov al, 1    ; 1 sector
    mov ch, 0
    mov cl, 2    ; Sector 2 (kernel)
    mov dh, 0    ; Head 0
    mov dl, 0x80  ; Hard disk 0
    mov bx, 0x1000
    int 0x13
    jc read_fail
    mov al, 'A'  ; After read success
    out dx, al
    jmp success

read_fail:
    mov al, 'E'  ; Read failed
    out dx, al
    jmp hang

success:
    mov al, 'L'  ; Load success
    out dx, al
    jmp mode_switch

mode_switch:
    ; Set text mode 3 before protected mode
    mov ax, 0x3
    int 0x10

    cli
    lgdt [gdt_desc]
    mov eax, cr0
    or eax, 1
    mov cr0, eax
    jmp 0x08:protected_mode

hang:
    mov al, 'H'  ; Hang
    out dx, al
    jmp $

[BITS 32]
protected_mode:
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov dx, 0x3F8
    mov al, 'K'  ; Kernel start
    out dx, al
    jmp 0x1000   ; Jump to kernel

gdt_start:
    dq 0
gdt_code:
    dw 0xFFFF
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0
gdt_data:
    dw 0xFFFF       ; limit low
    dw 0            ; base low
    db 0            ; base mid
    db 10010010b    ; access byte: present, RW, data
    db 11111111b    ; granularity: 4K blocks + limit high
    db 0            ; base high
gdt_end:
gdt_desc:
    dw gdt_end - gdt_start - 1
    dd gdt_start

times 510 - ($ - $$) db 0
dw 0xAA55