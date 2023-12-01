cmake_minimum_required(VERSION 3.14)
project(mpk_library C)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_COMPILER "clang")
set(CMAKE_CXX_COMPILER "clang++")
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_FLAGS  "-ggdb3")
set(CMAKE_SHARED_LINKER_FLAGS "-lpthread")
add_library(mpk SHARED
        mpk.c errors.h mpk.h threads.c threads.h allocator.c allocator.h domain.h logger.c logger.h)

target_link_libraries(mpk PUBLIC mimalloc)
target_link_directories(mpk PUBLIC $ENV{PRJHOME}/mpk-mimalloc/out/release)
target_include_directories(mpk PUBLIC $ENV{PRJHOME}/mpk-mimalloc/include)
