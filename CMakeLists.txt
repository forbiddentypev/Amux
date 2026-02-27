cmake_minimum_required(VERSION 3.15)
project(Amux LANGUAGES C CXX ASM)

# Prefer provided toolchain file when configuring builds
if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  set(CMAKE_TOOLCHAIN_FILE "${CMAKE_SOURCE_DIR}/cmake/toolchain-x86_64-elf.cmake" CACHE FILEPATH "Toolchain file")
endif()

add_subdirectory(kernel)
