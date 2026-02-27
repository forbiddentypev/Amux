set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

# Cross compilers (user may override environment)
set(CMAKE_C_COMPILER x86_64-elf-gcc CACHE STRING "C compiler")
set(CMAKE_CXX_COMPILER x86_64-elf-g++ CACHE STRING "C++ compiler")

set(CMAKE_ASM_COMPILER x86_64-elf-as CACHE STRING "ASM compiler")

# Basic flags for freestanding kernel
set(CMAKE_C_FLAGS "-ffreestanding -fno-exceptions -fno-rtti -mno-red-zone -Wall -Wextra -O2" CACHE STRING "C flags")
set(CMAKE_CXX_FLAGS "-ffreestanding -fno-exceptions -fno-rtti -mno-red-zone -Wall -Wextra -O2" CACHE STRING "C++ flags")

# Linker flags: rely on explicit linker script
set(CMAKE_EXE_LINKER_FLAGS "-nostdlib -static")
