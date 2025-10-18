[BITS 16]

global gdt_descriptor

gdt:                   ; label marking the start of the GDT
    dq 0x0000000000000000       ; NULL descriptor (required)
    dq 0x00CF9A000000FFFF       ; Code segment descriptor
    dq 0x00CF92000000FFFF       ; Data segment descriptor
gdt_end:

; GDTR (Global Descriptor Table Register structure)
gdt_descriptor:
    dw gdt_end - gdt - 1        ; size of GDT in bytes minus 1
    dd gdt                      ; 32-bit linear address of GDT