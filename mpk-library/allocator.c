//
// Created by martin on 21. 5. 21..
//

#include "allocator.h"
/* this is a private function to allocate thread specific data.
 * It will allocate data using the safe_allocator function, which we
 * know allocates memory in the safe region and won't be tampered with.
 */
allocator_t safe_allocator;
allocator_t unsafe_allocator;
static unsigned TEMP_CALLOC[TEMP_CALLOC_SIZE];

/* static function Hooks */
sbrk_t real_sbrk;
mmap_t real_mmap;
mremap_t real_mremap;

static void init_dlsym_links(void* handle, allocator_t* allocator,
                             const char* calloc_pfx,
                             const char* free_pfx,
                             const char* malloc_pfx,
                             const char* realloc_pfx){
    allocator->calloc = dlsym(handle, calloc_pfx);
    allocator->free = dlsym(handle, free_pfx);
    allocator->malloc = dlsym(handle, malloc_pfx);
    allocator->realloc = dlsym(handle, realloc_pfx);
}

static void init_malloc_funcs(void* handle, int allocator,
                              allocator_t* funcs, const char* err_message){
    if(!allocator){
        init_dlsym_links(handle, funcs, "calloc", "free", "malloc", "realloc");
    }else{
#if !defined(CUSTOM_MALLOC) || CUSTOM_MALLOC==1
        init_dlsym_links( handle, funcs,"mi_calloc", "mi_free", "mi_malloc", "mi_realloc");
#elif CUSTOM_MALLOC==2
        init_dlsym_links(RTLD_NEXT, funcs, "tc_calloc", "tc_free", "tc_malloc", "tc_realloc");
#elif CUSTOM_MALLOC==3
    init_dlsym_links(RTLD_NEXT, funcs, "dl_calloc", "dl_free", "dl_malloc", "dl_realloc");
#endif
    }

    if(!funcs->calloc || !funcs->free || !funcs->malloc || !funcs->realloc){
        ALLOCATOR_HOOKING_ERROR(err_message)
    }
}

void init_allocator_hooks(){
    INITIALIZING=1;
    real_sbrk = dlsym(RTLD_NEXT, "sbrk");
    real_mmap = dlsym(RTLD_NEXT, "mmap");
    real_mremap = dlsym(RTLD_NEXT, "mremap");
    init_malloc_funcs(RTLD_NEXT, 0, &safe_allocator, "Unable to initialize allocator hook functions\n");
    INITIALIZING = 0;
    if(!real_sbrk || !real_mmap || !real_mremap){
        MAP_SBRK_HOOK_ERROR
    }
    init_malloc_funcs(RTLD_NEXT, 1, &unsafe_allocator, "Unable to initialize extern allocator functions\n");
}

void* __safe_malloc(size_t size){
    ensure_initialized();
    return safe_allocator.malloc(size);
}

/* this is a private function to allocate unsafe copy objects.
 * We use it to allocate copies of objects whose addresses are arguments to
 * FFI calls.
 */
void* __unsafe_malloc(size_t size){
    ensure_initialized();
    return unsafe_allocator.malloc(size);
}

void __safe_free(void* addr){
    ensure_initialized();
    safe_allocator.free(addr);
}

void __unsafe_free(void* addr){
    ensure_initialized();
    return unsafe_allocator.free(addr);
}

void *malloc(size_t size){
    if(INITIALIZING)
        return TEMP_CALLOC;
    return mpk_malloc(size);
}

void free(void* addr){
    if(addr==TEMP_CALLOC){
        memset(TEMP_CALLOC, 0, TEMP_CALLOC_SIZE);
    }else if(!addr){
        return;
    }
    mpk_free(addr);
}

void* calloc(size_t num, size_t size){
    if(INITIALIZING)
        return malloc(num*size);
    return mpk_calloc(num, size);
}

void* sbrk(intptr_t incr){
    return mpk_sbrk(incr);
}

void* realloc(void* addr, size_t new_size){
    return mpk_realloc(addr, new_size);
}

/*
void *mmap(void* addr, size_t length, int prot, int flags, int fd, off_t offset){
    return mpk_mmap(addr, length, prot, flags, fd, offset);
}

void *mremap(void* addr, size_t old_len, size_t new_len, int flags, ...){
    return mpk_mremap(addr, old_len, new_len, flags);
}
*/

void* __allocate_extern_stack(size_t size){
    //TODO: should ensure mmap is done in extern stack. perhaps should use real_mmap
     char* extern_stack_ptr = unsafe_allocator.malloc(size); 
    //char* extern_stack_ptr = mmap(0, size,  PROT_READ | PROT_WRITE, MAP_POPULATE | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    return extern_stack_ptr+size;
}
