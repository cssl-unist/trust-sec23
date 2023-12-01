//
// Created by martin on 21. 5. 21..
//

#ifndef MPK_LIBRARY_ALLOCATOR_H
#define MPK_LIBRARY_ALLOCATOR_H
#include "domain.h"

#define MIN_REQ_SSIZE               ((size_t)0x1000000)   //80KB
#define DEFAULT_STACK_SIZE          (MIN_REQ_SSIZE)
#define PAGE_SIZE                   ((size_t)0x1000)    //4KB
#define TEMP_CALLOC_SIZE            (0x80)              //128B
#define EXTERN_MAP_BOUNDARY         (0xE0000000)        //provisional

typedef void* (*malloc_t)(size_t);
typedef void* (*realloc_t)(void*, size_t);
typedef void* (*calloc_t)(size_t, size_t);
typedef void  (*free_t)(void*);
typedef void* (*sbrk_t)(intptr_t);
typedef void* (*mmap_t)(void*, size_t, int, int, int, off_t);
typedef void*  (*mremap_t)(void*, size_t, size_t, int, ...);

typedef struct allocator{
    malloc_t malloc;
    realloc_t realloc;
    calloc_t calloc;
    free_t free;
} allocator_t;

extern allocator_t safe_allocator;
extern allocator_t unsafe_allocator;
extern int MPK_INITIALIZED;
extern int INITIALIZING;

/* global function hooks */
extern sbrk_t real_sbrk;
extern mmap_t real_mmap;
extern mremap_t real_mremap;

void* __safe_malloc(size_t);
void* __unsafe_malloc(size_t);
void __safe_free(void*);
void __unsafe_free(void*);
void* __allocate_extern_stack(size_t);
void init_allocator_hooks();
#endif //MPK_LIBRARY_ALLOCATOR_H
