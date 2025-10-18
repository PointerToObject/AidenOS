# AidenOS and Aiden++ Language

## Overview

**AidenOS** is a 32-bit protected mode operating system that boots from BIOS using a custom 8086 bootloader and executes a kernel compiled from the **Aiden++** programming language.  
The project forms a complete, self-sufficient software stack — from the bootloader to the kernel — without the use of any external operating systems, compilers, or libraries.

---

## System Architecture

- **Bootloader:**  
  Handwritten in 8086 real-mode assembly. It initializes segment registers, sets up the Global Descriptor Table (GDT), and transitions the CPU into 32-bit protected mode. After setup, it loads the kernel into memory and transfers execution.

- **Kernel:**  
  Written entirely in **Aiden++**, compiled into x86 assembly, and executed directly on bare metal. The kernel handles VGA text output and basic system logic without relying on a runtime or C library.

- **Compiler:**  
  The **Aiden++ Compiler** is a standalone tool that converts Aiden++ source files into NASM-compatible x86 assembly. It performs lexical analysis, tokenization, parsing, and code generation for integer operations, pointers, and print statements.

---

## The Aiden++ Language

**Aiden++** is a compact, C-inspired language designed exclusively for kernel and low-level systems programming.  
It offers a minimal, direct syntax that translates predictably into assembly, giving developers full visibility into how source code maps to machine operations.

Supported features include:

- Integer variables  
- Pointer creation (`&`) and dereferencing (`*`)  
- Integer addition (`+`)  
- Function definitions and calls  
- String literals and printing via `print()`  

There is **no support** for arrays, structs, loops, heap allocation, or any arithmetic other than addition.  
This deliberate limitation ensures simplicity, determinism, and transparent control over generated instructions.

---

### Example: Basic Kernel Entry

```c
int kernel_main() {
    print("Kernel powered by Aiden++ Compiled Programming Language for x86");
    return 0;
}
```

### Example: Pointer Operations

```c
int kernel_main() {
    int a = 10;
    int* ptr = &a;
    int b = *ptr + 10;
    *ptr = b;

    print("Pointer dereferencing successful");
    return *ptr;
}
```

---

### Generated Assembly Example

```asm
[BITS 32]
section .text
global kernel_main

kernel_main:
    mov dword [ebp-4], 10
    lea eax, [ebp-4]
    mov [ebp-8], eax
    mov eax, [ebp-8]
    mov eax, [eax]
    add eax, 10
    mov ecx, [ebp-8]
    mov [ecx], eax
    push str0
    call print_string
    mov eax, [ebp-4]
    ret

section .data
str0 db "Pointer dereferencing successful", 0
```

---

## Capabilities

- Handwritten 8086 BIOS bootloader  
- Protected mode transition using a custom GDT  
- 32-bit kernel compiled from Aiden++ source  
- Pointer and address-of operations supported  
- Integer addition and register-level manipulation  
- VGA text output via direct memory access  
- Self-contained compiler generating NASM-compatible x86 assembly  
- Fully functional without external toolchains or operating systems  

---

## Project Significance

**AidenOS** represents a rare class of software projects that bridges the entire stack — from raw hardware initialization to compiled kernel execution.  
Every layer is purpose-built and controlled, including the compiler, which directly emits real x86 machine code.

The result is a minimal, educational, and functional system that demonstrates complete understanding of compiler construction, low-level programming, and the x86 protected mode environment.

---

## Attribution

Developed entirely by **Aiden**, including the BIOS bootloader, compiler, and kernel implementation.  
AidenOS and Aiden++ stand as an example of complete systems ownership — a foundation built entirely from first principles.
