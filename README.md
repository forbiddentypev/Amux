# Amux

Amux is a 64-bit OS kernel project aiming for high performance and deterministic control, written in C++.

Amux-OS function and suit all users activities such as 

- Development
- Video Editing
- Browsing
- Gaming
- ...any other normal os usage

---

## Kernel Philosophy

**Constraints:**
- Architecture: x86_64 only
- Mode: Long mode (64-bit)
- Kernel Type: Monolithic Modular
- Language: C++ (freestanding) + minimal C + Assembly

**Primary objective:** Performance and deterministic control over hardware.  
**Security:** Secondary to speed in early stages.



---

## Global Architecture

```
Amux/
├── kernel/
│   ├── arch/
│   │   ├── x86_64/
│   │   │   ├── boot/          # ASM (bootloader, CPU entry)
│   │   │   ├── cpu/           # C/C++ mix (CPU features classes + low-level ops)
│   │   │   ├── interrupts/    # C/C++ mix (handlers objects + low-level trap)
│   │   │   ├── paging/        # C (memory management, page tables)
│   │   │   └── apic/          # C (APIC/interrupt control)
│   │   └── arm64/             # same as x86_64 (for future expansion)
│   │
│   ├── core/
│   │   ├── init/              # C++ (RAII, kernel init classes)
│   │   ├── scheduler/         # C++ (process/thread classes)
│   │   ├── memory/            # C (allocators, physical memory)
│   │   ├── process/           # C++ (Process class & management)
│   │   └── syscall/           # C (syscall interface)
│   │
│   ├── drivers/
│   │   ├── block/             # C++ (driver class) + C (hardware I/O)
│   │   ├── char/              # C++ + C mix
│   │   ├── net/               # C++ (network classes) + C (low-level)
│   │   ├── gpu/               # C++ + C mix
│   │   └── input/             # C++ + C mix
│   │
│   ├── fs/
│   │   ├── vfs/               # C++ (virtual FS abstraction)
│   │   ├── ext2/              # C (disk structures, low-level FS)
│   │   └── tmpfs/             # C (in-memory FS)
│   │
│   ├── network/
│   │   ├── stack/             # C++ (protocol classes)
│   │   ├── tcp/               # C++ (TCP handling)
│   │   └── udp/               # C++ (UDP handling)
│   │
│   ├── lib/
│   │   ├── string/            # C++ (templates/classes)
│   │   ├── math/              # C++ (math utilities)
│   │   └── containers/        # C++ (containers, vectors, lists)
│   │
│   ├── include/
│   │   ├── pan/               # C/C++ headers
│   │   └── arch/              # C/C++ headers
│   │
│   └── init/
│       └── kmain.cpp          # C++ (kernel entry point)
│
├── user/
│   ├── ui/                    # C++ (GUI, widgets, event handling)
│   ├── apps/
│   │   ├── Calculator/        # C++ (application logic)
│   │   └── SnakeGame/         # C++ (game logic)
│   └── tools/                 # C++ (CLI tools)
└── tools/                      # C++ (build tools, helpers)

```

---

## OverView

```
[Physical Machine / Firmware]
          │
          ▼
   ┌─────────────┐
   │  Bootloader │
   │  (BIOS/UEFI)│
   └─────────────┘
          │
          ▼
   ┌─────────────┐
   │   Kernel    │
   │ ┌─────────┐ │
   │ │  Core   │ │
   │ │ schedul │ │
   │ │   er    │ │
   │ │ memory  │ │
   │ │ process │ │
   │ │ syscall │ │
   │ └─────────┘ │
   │ ┌─────────┐ │
   │ │ Drivers │ │
   │ │ block   │ │
   │ │ char    │ │
   │ │ net     │ │
   │ │ gpu     │ │
   │ │ input   │ │
   │ └─────────┘ │
   │ ┌─────────┐ │
   │ │   FS    │ │
   │ │ vfs/ext2│ │
   │ │ tmpfs   │ │
   │ └─────────┘ │
   │ ┌─────────┐ │
   │ │   Net   │ │
   │ │ stack/tc│ │
   │ │ pudp    │ │
   │ └─────────┘ │
   │ ┌─────────┐ │
   │ │   Lib   │ │
   │ │ string  │ │
   │ │ math    │ │
   │ │ containe│ │
   │ │   rs    │ │
   │ └─────────┘ │
   └─────────────┘
          │
          ▼
   ┌─────────────┐
   │   Userland  │
   │  tools/apps │
   │     ui      │
   └─────────────┘
```

---

## Build System Architecture – Official Policy

Amux OS uses **CMake** as the official build orchestrator.

**CMake is used strictly as:**
- Target manager
- Dependency resolver
- Multi-directory coordinator

**CMake must NOT:**
- Control architecture decisions
- Override linker script behavior
- Inject host system libraries
- Enable hosted compilation mode

---

## Cross Compilation Rules

- Pan OS must always be built using a **cross compiler**
- **Target:** x86_64-elf
- Host compiler usage is strictly forbidden
- All builds must be freestanding

---

## Required Toolchain

- x86_64-elf-gcc
- x86_64-elf-g++
- nasm
- ld (cross)
- cmake
- qemu-system-x86_64
- **Bootloader:** GRUB (Multiboot2)

---

## Building commands

```
mkdir build
cd build
cmake -DCMAKE_TOOLCHAIN_FILE=../cmake/toolchain-x86_64-elf.cmake ..
make // to generate Amux
```

---

## Moto

Amux Creativity Fuse With Introvert

---
