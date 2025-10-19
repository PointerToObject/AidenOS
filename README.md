# AidenOS and Aiden++ Language
<img width="727" height="81" alt="image" src="https://github.com/user-attachments/assets/636d5c3d-c61c-45ba-8eb0-7928fa55e1bb" />

## Overview

**AidenOS** is a 32-bit protected mode operating system that boots from BIOS using a custom 8086 bootloader and executes a kernel compiled from the **Aiden++** programming language.  
The project forms a complete, self-sufficient software stack — from the bootloader to the kernel — without the use of any external operating systems, compilers, or libraries.

---

## System Architecture

- **Bootloader:**  
  Handwritten in 8086 real-mode assembly. It initializes segment registers, sets up the Global Descriptor Table (GDT), and transitions the CPU into 32-bit protected mode. After setup, it loads the kernel into memory and transfers execution.

- **Kernel:**  
  Written entirely in **Aiden++**, compiled into x86 assembly, and executed directly on bare metal. The kernel handles VGA text output and system logic without relying on a runtime or C library.

- **Compiler:**  
  The **Aiden++ Compiler** is a standalone tool that converts Aiden++ source files into NASM-compatible x86 assembly. It performs lexical analysis, tokenization, parsing, and code generation for integers, pointers, expressions, and control flow.

---

## The Aiden++ Language

**Aiden++** is a compact, C-inspired language designed exclusively for kernel and low-level systems programming.  
It provides a minimal, deterministic syntax that directly maps to real x86 instructions, offering complete transparency between source and output.

### Supported Features

#### Primitive Data Types
- `__int8`, `__int16`, and `int` (32-bit)  
- Each type is compiled into the correct instruction width (`al`, `ax`, `eax`)

#### Pointers
- Address-of (`&`) and dereference (`*`) operators  
- Pointer arithmetic compatible with all integer types  

#### Arithmetic Operations
- Addition (`+`), subtraction (`-`), multiplication (`*`), and division (`/`)  
- Fully type-aware across all integer sizes  

#### Control Flow
- `if` statements (including nested conditionals)  
- Full comparison operators: `==`, `!=`, `<`, `>`, `<=`, `>=`

#### Functions
- Function definitions and calls with automatic stack handling  

#### Strings and Output
- String literals  
- `print()` for kernel text output via VGA memory  

---

### Example: Pointer and Arithmetic Operations

```c
int kernel_main() 
{
    __int8 key = 0;

    if(key == 0)
    {
        __int16 j = 5;
        int* ptr = &j;
        int x = *ptr + 5;

        if(x > 5)
        {
            if(x > 7)
            {
                if(x == 10)
                {
                    int i = 15;
                    int* ptr2x = &x;
                    *ptr2x = i;

                    if(*ptr2x < 20)
                    {
                        if(*ptr2x == 15)
                        {
                            print("Worked!");
                        }
                    }
                }
            }
        }
    }

    if(key == 1)
    {
        print("Not Possible!");
    }
}
```

---

### Generated Assembly Example

```asm
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
str0 db "Worked!",0
str1 db "Not Possible!",0

section .bss
v_key resb 1
v_j resw 1
v_ptr resd 1
v_x resd 1
v_i resd 1
v_ptr2x resd 1
vga_cursor resd 1
```

---

## Capabilities

- Handwritten 8086 BIOS bootloader  
- Protected mode transition using a custom GDT  
- 32-bit kernel compiled from Aiden++ source  
- Type-aware arithmetic and pointer operations  
- Nested conditional logic with multiple comparison operators  
- VGA text output through direct memory access  
- Self-contained compiler generating NASM-compatible x86 assembly  
- Fully functional without external toolchains or operating systems  

---

## Project Significance

**AidenOS** represents a complete educational operating system and compiler stack, demonstrating full control over every software layer — from the BIOS to protected-mode execution.  
The **Aiden++ language** provides an ultra-minimal foundation for understanding real compiler construction and x86 architecture behavior at the instruction level.

---

## Changelog

### **10/19/2025**
- Added support for all core arithmetic operations: `+`, `-`, `*`, `/`  
- Added comparison operators: `<`, `>`, `<=`, `>=`, `==`, `!=`  
- Implemented multi-size integer types: `__int8`, `__int16`, and `int` (32-bit)  
- Introduced type-aware pointer arithmetic and dereferencing  
- Added nested conditional support for `if` statements  
- Improved code generation for proper width handling (`al`, `ax`, `eax`)  
- Enhanced print system for string literals in VGA memory  
- Updated kernel examples and assembly generation to reflect new feature set  

---

## Attribution

Developed entirely by **Aiden**, including the BIOS bootloader, compiler, and kernel implementation.  
AidenOS and Aiden++ stand as an example of complete systems ownership — a foundation built entirely from first principles.
