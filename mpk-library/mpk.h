#ifndef MPK_H
#define MPK_H

#define _GNU_SOURCE
#include "allocator.h"
#include "domain.h"
#include <stdio.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <unistd.h>

#define UNSAFE_START_ADDR (size_t)(0x510000000000UL)
#define UNSAFE_REGION_LEN (size_t)(0x1UL << 34UL)
#define UNSAFE_END_ADDR (size_t)(UNSAFE_START_ADDR + UNSAFE_REGION_LEN)

uint8_t *__mpk_unsafe__rust_alloc(uint64_t size, uint64_t align, uint8_t flag);
void __mpk_unsafe__rust_dealloc(uint8_t *ptr, uint64_t size, uint64_t align);
uint8_t *__mpk_unsafe__rust_realloc(uint8_t *ptr, uint64_t old_size,
                                    uint64_t align, uint64_t new_size,
                                    uint8_t flag);
uint8_t *__mpk_unsafe__rust_alloc_zeroed(uint64_t size, uint64_t align,
                                         uint8_t flag);
uint8_t *__mpk_unsafe__rdl_alloc(uint64_t size, uint64_t align, uint8_t flag);
uint8_t *__mpk_unsafe__rdl_alloc_zeroed(uint64_t size, uint64_t align,
                                        uint8_t flag);
uint8_t *__mpk_unsafe__rdl_realloc(uint8_t *ptr, uint64_t old_size,
                                   uint64_t align, uint64_t new_size,
                                   uint8_t flag);
void __mpk_unsafe__rdl_dealloc(uint8_t *ptr, uint64_t size, uint64_t align);

void __mpk_exit();
void __mpk_entry();
void __sfi_exception();
void *__get_domain_ptr();
static inline void __wrpkru(unsigned int pkru);
int __pkey_set(int pkey, unsigned long rights, unsigned long flags);
void __check_load_false_positive(void *addr);
void __check_store_false_positive(void *addr);
void __check_load_false_negative(void *addr);
void __check_store_false_negative(void *addr);
void __count_allocas(uint8_t allocas, uint8_t unsafe_allocas);
void __check_r15();
#endif
