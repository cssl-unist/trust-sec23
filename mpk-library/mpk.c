
#include "mpk.h"
#include "domain.h"
#include <stdio.h>

int INITIALIZING = 0;
size_t SAFE_STORE_IN_UNSAFE = 0;
size_t TOTAL_UNSAFE_LOADS = 0;
size_t TOTAL_SAFE_LOADS = 0;
size_t UNSAFE_LOAD_IN_SAFE = 0;
size_t TOTAL_SAFE_STORES = 0;
size_t UNSAFE_STORE_IN_SAFE = 0;
size_t SAFE_LOAD_IN_UNSAFE = 0;
size_t STORE_IN_UNSAFE = 0;
size_t UNSAFE_HEAP = 0;
size_t TOTAL_HEAP = 0;
size_t UNSAFE_ALLOCA = 0;
size_t TOTAL_ALLOCA = 0;
size_t FALSE_POSITIVES = 0;
size_t FALSE_NEGATIVES = 0;

static inline void __wrpkru(unsigned int pkru) {
  unsigned int eax = pkru;
  unsigned int ecx = 0;
  unsigned int edx = 0;

  asm volatile(".byte 0x0f,0x01,0xef\n\t" : : "a"(eax), "c"(ecx), "d"(edx));
}

int __pkey_set(int pkey, unsigned long rights, unsigned long flags) {
  unsigned int pkru = (rights << (2 * pkey));
  __wrpkru(pkru);
  return 0;
}

void *mpk_malloc(size_t size) {
  ensure_initialized();
    TOTAL_HEAP += 1;
  if (get_domain()) {
    UNSAFE_HEAP += 1;
    return unsafe_allocator.malloc(size);
  }

  /* fprintf(stderr, "safe malloc\n"); */
  return safe_allocator.malloc(size);
}

void *mpk_realloc(void *addr, size_t size) {
  ensure_initialized();
    TOTAL_HEAP += 1;
  if ((size_t)addr < UNSAFE_END_ADDR && (size_t)addr > UNSAFE_START_ADDR) {
      UNSAFE_HEAP += 1;
    return unsafe_allocator.realloc(addr, size);
  }
  return safe_allocator.realloc(addr, size);
}

void *mpk_calloc(size_t num, size_t size) {
  ensure_initialized();
    TOTAL_HEAP += num;
  if (get_domain()) {
      UNSAFE_HEAP += num;
    return unsafe_allocator.calloc(num, size);
  }

  return safe_allocator.calloc(num, size);
}

void mpk_free(void *addr) {
  ensure_initialized();
  if (!((size_t)addr < UNSAFE_END_ADDR && (size_t)addr > UNSAFE_START_ADDR)) {
     safe_allocator.free(addr);
  } else{
    unsafe_allocator.free(addr);
  }
}


void* mpk_mmap(void* addr, size_t length, int prot, int flags, int fd, off_t
offset){ ensure_initialized(); if(get_domain()){ return real_mmap(addr, length,
prot, flags, fd, offset);
    }

    return real_mmap(addr, length, prot, flags, fd, offset);
}

void* mpk_mremap(void* addr, size_t orig_len, size_t new_len, int flags, ...){
    ensure_initialized();
    if(get_domain()){
        return real_mremap(addr, orig_len, new_len, flags);
    }
    return real_mremap(addr, orig_len, new_len, flags);
}


void *mpk_sbrk(intptr_t incr) {
  ensure_initialized();
  if (incr == 0) {
    return real_sbrk(incr);
  }

  return (void *)-1;
}

void *__get_domain_ptr() {
  domain_t *domain = get_domain_ptr();
  return (void *)domain;
}

size_t SFI_EXCEPTION = 0;
void __sfi_exception() {
  SFI_EXCEPTION++;
  return;
}

uint8_t *__mpk_unsafe__rust_alloc(uint64_t size, uint64_t align, uint8_t flag) {
    TOTAL_HEAP += 1;
  if (flag) {
      UNSAFE_HEAP += 1;
    return unsafe_allocator.malloc(size);
  } else {
    return safe_allocator.malloc(size);
  }
}

void __mpk_unsafe__rust_dealloc(uint8_t *ptr, uint64_t size, uint64_t align) {
  if ((size_t)ptr < UNSAFE_END_ADDR && (size_t)ptr > UNSAFE_START_ADDR) {
    return unsafe_allocator.free(ptr);
  }
  safe_allocator.free(ptr);
}

uint8_t *__mpk_unsafe__rdl_alloc(uint64_t size, uint64_t align, uint8_t flag) {
    TOTAL_HEAP += 1;
    if (flag) {
        UNSAFE_HEAP += 1;
        return unsafe_allocator.malloc(size);
    } else {
        return safe_allocator.malloc(size);
    }
}

uint8_t *__mpk_unsafe__rdl_alloc_zeroed(uint64_t size, uint64_t align,
                                        uint8_t flag) {
    TOTAL_HEAP += 1;
    if (flag) {
        UNSAFE_HEAP += 1;
        return unsafe_allocator.calloc((size + align) / align, align);
    }else {
        return safe_allocator.calloc((size + align) / align, align);
    }
}

uint8_t *__mpk_unsafe__rdl_realloc(uint8_t *ptr, uint64_t old_size,
                                   uint64_t align, uint64_t new_size,
                                   uint8_t flag) {
    TOTAL_HEAP += 1;
    if ((size_t)ptr < UNSAFE_END_ADDR && (size_t)ptr > UNSAFE_START_ADDR) {
        UNSAFE_HEAP += 1;
        return unsafe_allocator.realloc(ptr, new_size);
    }
    return safe_allocator.realloc(ptr, new_size);
}

void __mpk_unsafe__rdl_dealloc(uint8_t *ptr, uint64_t size, uint64_t align) {
    if ((size_t)ptr < UNSAFE_END_ADDR && (size_t)ptr > UNSAFE_START_ADDR) {
        return unsafe_allocator.free(ptr);
    }
    safe_allocator.free(ptr);
}
uint8_t *__mpk_unsafe__rust_realloc(uint8_t *ptr, uint64_t old_size,
                                    uint64_t align, uint64_t new_size,
                                    uint8_t flag) {
    TOTAL_HEAP += 1;
  if ((size_t)ptr < UNSAFE_END_ADDR && (size_t)ptr > UNSAFE_START_ADDR) {
      UNSAFE_HEAP += 1;
    return unsafe_allocator.realloc(ptr, new_size);
  }
  return safe_allocator.realloc(ptr, new_size);
}
uint8_t *__mpk_unsafe__rust_alloc_zeroed(uint64_t size, uint64_t align,
                                         uint8_t flag) {

    TOTAL_HEAP += 1;
  if (flag) {
      UNSAFE_HEAP += 1;
    return unsafe_allocator.calloc((size + align) / align, align);
  }else {
      return safe_allocator.calloc((size + align) / align, align);
  }
}



void __check_store_false_positive(void *ptr) {
  if (!((size_t)ptr < UNSAFE_END_ADDR && (size_t)ptr > UNSAFE_START_ADDR)) {
    SAFE_STORE_IN_UNSAFE += 1;
  }
    STORE_IN_UNSAFE += 1;
}

void __check_load_false_positive(void *ptr) {
  if (!((size_t)ptr < UNSAFE_END_ADDR && (size_t)ptr > UNSAFE_START_ADDR)) {
    SAFE_LOAD_IN_UNSAFE += 1;
  }
    TOTAL_UNSAFE_LOADS += 1;
}

void __check_store_false_negative(void *addr) {
  if (((size_t)addr < UNSAFE_END_ADDR && (size_t)addr > UNSAFE_START_ADDR)) {
      UNSAFE_STORE_IN_SAFE += 1;
  }
  TOTAL_SAFE_STORES += 1;
}


void __check_load_false_negative(void *addr) {
  if (((size_t)addr < UNSAFE_END_ADDR && (size_t)addr > UNSAFE_START_ADDR)) {
      UNSAFE_LOAD_IN_SAFE += 1;
  }
    TOTAL_SAFE_LOADS += 1;
}


void __count_allocas(uint8_t allocas, uint8_t unsafe) {
    UNSAFE_ALLOCA += unsafe;
    TOTAL_ALLOCA += allocas;
}

__attribute__((constructor)) static void initialize_counters() {
  ensure_initialized();
  TOTAL_ALLOCA = 0;
  UNSAFE_ALLOCA = 0;
  TOTAL_UNSAFE_LOADS = 0;
    SAFE_LOAD_IN_UNSAFE = 0;
    SAFE_STORE_IN_UNSAFE = 0;
  TOTAL_HEAP = 0;
  UNSAFE_HEAP = 0;
  TOTAL_SAFE_LOADS = 0;
  UNSAFE_LOAD_IN_SAFE = 0;
  TOTAL_SAFE_STORES = 0;
  UNSAFE_STORE_IN_SAFE = 0;
}

void __check_r15() {
  domain_t *domain = get_domain_ptr();
  intptr_t r15;
  asm("mov %%r15, %0" : "=r"(r15));
  if (r15 != (size_t)domain) {
    // something went wrong
    asm("mov %0, %%r15;" ::"r"(domain) : "%r15");
  }
}


__attribute__((destructor)) static void print_counter_logs() {
    printf("Total heap: %zu\n", TOTAL_HEAP);
    printf("Unsafe Heap: %zu\n", UNSAFE_HEAP);
    printf("Total Stack: %zu\n",TOTAL_ALLOCA);
    printf("Unsafe Stack: %zu\n", UNSAFE_ALLOCA);
    printf("Total Unsafe Read: %zu\n", TOTAL_UNSAFE_LOADS);
    printf("Safe Read In Unsafe: %zu\n",SAFE_LOAD_IN_UNSAFE);
    printf("Total Unsafe Write: %zu\n", STORE_IN_UNSAFE);
    printf("Safe Write In Unsafe: %zu\n",SAFE_STORE_IN_UNSAFE);
    printf("Total Safe Read: %zu\n",TOTAL_SAFE_LOADS);
    printf("Unsafe Read In Safe: %zu\n", UNSAFE_LOAD_IN_SAFE);
    printf("Total Safe Write: %zu\n", TOTAL_SAFE_STORES);
    printf("Unsafe Write In Safe: %zu\n", UNSAFE_STORE_IN_SAFE);
}
