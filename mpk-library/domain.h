//
// Created by martin on 21. 5. 21..
//

#ifndef MPK_LIBRARY_DOMAIN_H
#define MPK_LIBRARY_DOMAIN_H
#include "errors.h"
#include "mimalloc.h"
#include "malloc.h"

#define EU_DOMAIN_VALUE (0x1)
#define EXTERN_DOMAIN_VALUE EU_DOMAIN_VALUE
#define IU_DOMAIN_VALUE (0x2)
#define SAFE_DOMAIN_VALUE (0x0)
#define EU_STACK_INDEX (0x0)
#define IMMUTABLE_STACK_INDEX EU_STACK_INDEX
#define IU_STACK_INDEX (0x1)
#define MUTABLE_STACK_INDEX IU_STACK_INDEX
#define EU_TOP_ADDRESS (0x77FFF000)
#define IU_TOP_ADDRESS (0x77FFFFF000)

typedef struct domain {
  void *extern_stack_ptr; //+0
  uint64_t domain; //+8
  uint64_t eax_scrap; //+16
  uint64_t edx_scrap; //+32
  uint64_t ecx_scrap; //+48
  void *safe_stack_ptr; //+56
  uint64_t unsafeFlag; //+64
} domain_t;


void *get_extern_stack_ptr();
void init_domain_key();
void set_domain_value(int);
void allocate_domain_key();
void **get_mutable_stack_address();
void **get_immutable_stack_address();
void *mpk_malloc(size_t);
void *mpk_realloc(void *, size_t);
void *mpk_calloc(size_t, size_t);
void mpk_free(void *);
void *mpk_mmap(void *, size_t, int, int, int, off_t);
void *mpk_mremap(void *, size_t, size_t, int, ...);
void ensure_initialized();
void *mpk_sbrk(intptr_t);
int get_domain();
domain_t *get_domain_ptr();
#endif // MPK_LIBRARY_DOMAIN_H
