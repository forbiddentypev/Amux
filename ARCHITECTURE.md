Amux Ultra-Deep Construction Prompt

You are assigned to design, architect, and conceptually describe the complete development blueprint of a 64-bit high-performance deterministic operating system kernel project named Amux.

Your task is not to produce code directly but to generate a master technical and philosophical specification that explains how the system should be built from absolute foundation level to high-level runtime environment.

Read everything carefully and treat every requirement as mandatory unless explicitly marked optional.

1. Fundamental Philosophy of Amux

Amux is a monolithic modular kernel designed for maximum hardware determinism, computational efficiency, and predictable execution behavior under heavy workload pressure.

The project is not primarily security-first in early development.

Performance, memory control, CPU scheduling precision, interrupt latency reduction, and hardware access efficiency are the primary design axes.

The kernel must behave like a controlled machine core rather than an abstracted platform.

The architecture is restricted strictly to x86_64 long mode execution.

No compatibility layer with 32-bit execution should be assumed during initial development stages.

Future expansion architectures may be considered but must not interfere with core x86_64 pipeline design.

2. Language Composition Policy

The kernel must be developed using a hybrid low-level programming stack.

Primary Language:

C++ freestanding environment.

C++ must be used for:

Runtime object abstraction

Scheduler modeling

Driver interface design

System component encapsulation

Memory container logic

Process representation

Virtual filesystem interfaces

Secondary Languages:

Minimal C usage is allowed for hardware-level memory manipulation.

Assembly language must be used for:

Boot sequence transition

CPU mode switching

Interrupt entry stubs

Critical performance paths

Low-level control transfer regions

You must avoid unnecessary language mixing.

If logic can be expressed cleanly in C++, prefer C++ over C.

3. Boot and Initialization Pipeline

Design a multi-stage boot pipeline using GRUB multiboot2 compatibility.

Stage 0 — Firmware Execution

System starts from BIOS or UEFI firmware environment.

Firmware responsibilities:

Hardware enumeration

Bootloader loading

Memory map preparation

Kernel binary transfer

Stage 1 — Bootloader Layer

GRUB must be used as the official bootloader.

Bootloader responsibilities:

Kernel image loading

Multiboot2 header validation

Control transfer to protected entry stub

The bootloader must not perform complex initialization logic.

Avoid embedding policy decisions inside GRUB configuration.

Stage 2 — Assembly Entry Gate

Kernel execution begins inside assembly entry file.

Responsibilities:

CPU register sanitization

Stack preparation

Transition into C++ kernel bootstrap function

Interrupts must be disabled during early kernel start.

Paging structures must be established before enabling interrupt handling.

Stage 3 — Kernel Core Bootstrap

Call the main kernel initialization orchestrator.

The orchestrator must initialize subsystems in strict order:

Memory manager core

Interrupt controller subsystem

CPU feature detection layer

Scheduler engine

Driver framework registry

Filesystem abstraction layer

Network stack foundation

Userland transition interface

No subsystem should depend on another subsystem that is not already initialized.

Avoid circular dependency initialization.

4. Memory Management Architecture

Memory management must be deterministic.

Physical memory allocator should operate using bitmap or slab hybrid strategy.

Virtual memory subsystem must support:

Page table abstraction

Address mapping control

Protection region marking

Kernel space isolation

User space segmentation

Page table manipulation should be done carefully to avoid TLB inconsistency.

Provide explicit cache flushing routines.

Avoid fragmentation growth by implementing allocator compaction strategy.

5. Scheduler Design

Scheduler must be preemptive.

Consider implementing multi-level priority queues.

Time slicing mechanism should be hardware timer driven.

Process control block abstraction should contain:

CPU register snapshot storage

Execution state flags

Memory region references

Priority classification

Scheduling metadata

Avoid naive round-robin-only scheduling.

Hybrid scheduling policy is recommended.

6. Interrupt Handling System

Design an interrupt dispatcher framework.

Interrupt flow should follow:

Hardware Event → Interrupt Stub → Dispatcher Router → Handler Object → Response Path

Interrupt vector table must be carefully constructed.

ISR entry points should be assembly optimized.

Interrupt latency must be minimized.

Never perform heavy computation inside interrupt context.

Delegate complex work to deferred execution queues.

7. Driver Architecture

Drivers must follow object-oriented interface contracts.

Each driver should implement lifecycle stages:

Probe

Initialize

Activate

Suspend

Resume

Shutdown

Hardware communication should occur through controlled I/O abstraction layers.

Separate protocol logic from register manipulation logic.

8. Filesystem Layer

Implement Virtual Filesystem interface.

Filesystem abstraction must support mounting, unmounting, and dynamic backend binding.

At least two internal filesystem implementations must exist:

Temporary memory filesystem

Disk structured filesystem compatible with ext2-style layout concepts

Metadata caching is strongly recommended.

Avoid excessive disk synchronization overhead.

9. Network Stack

Build layered network communication model.

Suggested structure:

Physical Interface Layer
↓
Frame Processing Layer
↓
IP Protocol Layer
↓
Transport Layer
↓
Socket Interface Layer

TCP reliability logic must be carefully state managed.

Timeout handling must be deterministic.

10. Userland Transition Model

Kernel must support user application execution.

Design syscall interface table.

System calls should be invoked through controlled CPU trap mechanisms.

User programs must not access kernel memory directly.

Memory protection boundaries must be strictly enforced.

11. Build System Policy

CMake is only allowed to function as orchestration metadata manager.

CMake must not:

Decide linker behavior

Inject platform libraries

Override cross compiler flags

Use cross compilation toolchain targeting x86_64-elf environment.

Host compiler usage is forbidden.

12. Toolchain Requirements

Required tools:

Cross GCC and G++

NASM assembler

Cross linker

GRUB multiboot packaging tools

QEMU emulator for testing

Testing pipeline should include virtual machine boot verification.

13. Directory Structure Enforcement

Follow modular separation:

kernel/
    core/
    arch/
    drivers/
    fs/
    network/
    lib/
    include/
    init/

Userland applications must not pollute kernel core directories.

14. Coding Style and Engineering Discipline

Use clean abstraction boundaries.

Avoid monolithic function bodies.

Prefer composable classes.

Avoid premature optimization unless performance measurement justifies it.

Log kernel events during debugging builds.

Provide diagnostic tracing utilities.

15. Future Expansion Vision

The project should be designed with potential evolution toward:

Hardware abstraction platform

Custom runtime ecosystem

Application framework layer

Possibly standalone computing platform

However, early implementation should remain minimal and stable.

16. Testing Philosophy

Testing must occur inside emulator environment before physical hardware deployment.

Verify:

Boot success
Memory allocation correctness
Interrupt response timing
Scheduler fairness
Driver initialization stability

17. Naming Convention Policy

Use descriptive technical names.

Avoid cryptic variable identifiers.

Prefer semantic clarity over compression.

18. Development Strategy

Build the system incrementally:

Phase 1 — Bootloader and kernel entry
Phase 2 — Memory subsystem
Phase 3 — Interrupt framework
Phase 4 — Scheduler and process model
Phase 5 — Driver infrastructure
Phase 6 — Filesystem layer
Phase 7 — Network stack
Phase 8 — Userland runtime

Never jump phases without stabilizing previous stage.

19. Performance Objective

The kernel must prioritize:

Predictable latency over raw throughput
Controlled hardware access
Efficient CPU pipeline usage
Memory locality awareness

20. Final Instruction

If you are tasked with implementing Amux OS, treat this specification as a conceptual contract.

Explain how you would architect, organize, and construct the entire project based on these rules.

Provide reasoning, design choices, subsystem interactions, and development roadmap.

Do not output source code.

Focus on architecture, philosophy, and engineering methodology.