cmake_minimum_required(VERSION 3.15)
project(amux-kernel NONE)

set(KERNEL_NAME amux-kernel)

set(KERNEL_SOURCES
  ${CMAKE_SOURCE_DIR}/kernel/arch/x86_64/boot/multiboot.S
  ${CMAKE_SOURCE_DIR}/kernel/arch/x86_64/boot/entry.S
  ${CMAKE_SOURCE_DIR}/kernel/init/kmain.cpp
)

add_executable(${KERNEL_NAME} ${KERNEL_SOURCES})

target_include_directories(${KERNEL_NAME} PRIVATE ${CMAKE_SOURCE_DIR}/include)

set(LDSCRIPT ${CMAKE_SOURCE_DIR}/kernel/linker.ld)
if(EXISTS ${LDSCRIPT})
  target_link_options(${KERNEL_NAME} PRIVATE "-T${LDSCRIPT}")
endif()

set_target_properties(${KERNEL_NAME} PROPERTIES OUTPUT_NAME "amux-kernel")

find_program(GRUB_MKRESCUE NAMES grub-mkrescue grub2-mkrescue)
if(NOT GRUB_MKRESCUE)
  message(FATAL_ERROR "grub-mkrescue (or grub2-mkrescue) not found; please install grub2-mkrescue and xorriso")
endif()

add_custom_target(iso
  COMMAND ${CMAKE_COMMAND} -E rm -rf ${CMAKE_BINARY_DIR}/iso
  COMMAND ${CMAKE_COMMAND} -E make_directory ${CMAKE_BINARY_DIR}/iso/boot/grub
  COMMAND ${CMAKE_COMMAND} -E copy $<TARGET_FILE:${KERNEL_NAME}> ${CMAKE_BINARY_DIR}/iso/boot/amux-kernel
  COMMAND ${CMAKE_COMMAND} -E copy ${CMAKE_SOURCE_DIR}/cmake/grub.cfg ${CMAKE_BINARY_DIR}/iso/boot/grub/grub.cfg
  COMMAND ${GRUB_MKRESCUE} -o ${CMAKE_BINARY_DIR}/amux.iso ${CMAKE_BINARY_DIR}/iso
  DEPENDS ${KERNEL_NAME}
  WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
  COMMENT "Building GRUB ISO (requires grub-mkrescue or grub2-mkrescue)"
)
