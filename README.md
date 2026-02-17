# Amux


---

## Kernel Philosophy

**Constraints:**
- Architecture: x86_64 only
- Mode: Long mode (64-bit)
- Kernel Type: Monolithic Modular
- Language: C++ (freestanding) + minimal C + Assembly
- No microkernel architecture
- No userspace drivers
- No hybrid model

**Primary objective:** Performance and deterministic control over hardware.  
**Security:** Secondary to speed in early stages.

All major subsystems live in kernel space:
- Scheduler
- Memory Manager
- VFS
- Drivers
- Network stack

---

## Global Architecture

```
Amux/
├── kernel/
│   ├── arch/
│   │   ├── x86_64/
│   │   │   ├── boot/
│   │   │   ├── cpu/
│   │   │   ├── interrupts/
│   │   │   ├── paging/
│   │   │   └── apic/
│   │   └── arm64/
│   │
│   ├── core/
│   │   ├── init/
│   │   ├── scheduler/
│   │   ├── memory/
│   │   ├── process/
│   │   └── syscall/
│   │
│   ├── drivers/
│   │   ├── block/
│   │   ├── char/
│   │   ├── net/
│   │   ├── gpu/
│   │   └── input/
│   │
│   ├── fs/
│   │   ├── vfs/
│   │   ├── ext2/
│   │   └── tmpfs/
│   │
│   ├── network/
│   │   ├── stack/
│   │   ├── tcp/
│   │   └── udp/
│   │
│   ├── lib/
│   │   ├── string/
│   │   ├── math/
│   │   └── containers/
│   │
│   ├── include/
│   │   ├── pan/
│   │   └── arch/
│   │
│   └── init/
│       └── kmain.cpp
│
├── user/
│   ├── ui/
│   ├── apps/
│   │   ├── Calculator/
│   │   └── SnakeGame/
│   └── tools/
└── tools/

```

---

## OverLook

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

## Moto
Amux Creativity Fuse With Introvert