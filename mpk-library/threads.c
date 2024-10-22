//
// Created by martin on 21. 5. 21..
//

#include "threads.h"
#include "mpk.h"
#include <sys/mman.h>
/* hook function */
pthread_create_t real_pthread_create = 0;

static pthread_key_t DOMAIN_KEY;
static pthread_once_t MPK_INITIALIZATION = PTHREAD_ONCE_INIT;
static int unsafe_key = 0;

void init_domain_key(){
    if(pthread_key_create(&DOMAIN_KEY, NULL)){
        DOMAIN_KEY_CREATE_ERROR
    }
    domain_t* domain = safe_allocator.malloc(sizeof(domain_t));
    domain->domain = 0;
    domain->extern_stack_ptr = NULL;
    if(pthread_setspecific(DOMAIN_KEY, domain)){
        DOMAIN_SET_ERROR
    }
    unsafe_key = pkey_alloc(0,0);
    // You can gracefully allocate any key != 1, then modify mprotect in the allocator side to use the allocated key
    //if(unsafe_key < 0 || unsafe_key != 1) {
    //	    DOMAIN_KEY_CREATE_ERROR
    //}
}

void init_threading_hooks(){
  real_pthread_create = dlsym(RTLD_NEXT, "pthread_create");
  if(!real_pthread_create){
    PTHREAD_HOOKING_ERROR
  }
}

static void mpk_initialization(){
    init_allocator_hooks();
    init_domain_key();
    init_threading_hooks();
    mi_process_init();
}
void ensure_initialized(){
    pthread_once(&MPK_INITIALIZATION, mpk_initialization);
}

int get_domain(){
    domain_t* domain = pthread_getspecific(DOMAIN_KEY);
    if(!domain)
        NO_DOMAIN_VALUE_ERROR
    return domain->domain;
}

void set_domain_value(int new_domain){
    domain_t* domain = pthread_getspecific(DOMAIN_KEY);
    domain->domain = new_domain;
    __pkey_set(DOMAIN_KEY, 0, 0); //dummy function call for measuring ovh.
    if(new_domain ==2 )
      fprintf(stderr,"Got domain %d\n", new_domain);
}

domain_t *get_domain_ptr(){
    domain_t *domain = pthread_getspecific(DOMAIN_KEY);
    if(!domain)
        NO_DOMAIN_VALUE_ERROR
    if(!domain->extern_stack_ptr){
        domain->extern_stack_ptr = __allocate_extern_stack(DEFAULT_STACK_SIZE);
    }
    return domain;
}

void* thread_hook(void* args){
    thread_data_t data = *(thread_data_t*)args;

    if(pthread_setspecific(DOMAIN_KEY, (domain_t*)data.temp_domain))
        DOMAIN_SET_ERROR

    domain_t* domain;
    if(data.domain){
        fprintf(stderr,"Got domain in thread_hook: %d\n", data.domain);
        domain = __unsafe_malloc(sizeof (domain_t ));
        __unsafe_free(data.temp_domain);
        __unsafe_free(args);
    }else{
        domain = __safe_malloc(sizeof (domain_t));
        __safe_free(data.temp_domain);
        __safe_free(args);
    }

    if(!domain)
        OUT_OF_MEMORY_ERROR
    domain->domain = data.domain;
    domain->extern_stack_ptr = __allocate_extern_stack(DEFAULT_STACK_SIZE);
    domain->safe_stack_ptr = NULL;
    if(pthread_setspecific(DOMAIN_KEY, domain)){
        DOMAIN_SET_ERROR
    }
    asm("mov %0, %%r15;"
        ::"r" (domain)
        :"%r15");
    return data.orig_func(data.orig_args);
}

int pthread_create(pthread_t *restrict thread, const pthread_attr_t *restrict attr, void *(*routine)(void*), void *restrict arg){
    pthread_t curr_thread = pthread_self();
    pthread_attr_t curr_thread_attr;
    /* obtain caller thread attributes */
    /* fprintf(stderr, "thread create\n"); */
    if(pthread_getattr_np(curr_thread, &curr_thread_attr)){//error
        GET_THREAD_ATTR_ERROR
    }
    void* curr_thread_stack_addr;
    size_t curr_thread_stack_size;
    /* obtain caller thread stack information */
    if(pthread_attr_getstack(&curr_thread_attr, &curr_thread_stack_addr, &curr_thread_stack_size)){//error
        GET_THREAD_STACK_ADDR_ERROR
    }
    /* fprintf(stderr, "thread_creating\n"); */
    thread_data_t* thread_data = mpk_malloc(sizeof(thread_data_t));
    thread_data->orig_args = arg;
    thread_data->orig_func = routine;
    thread_data->domain = get_domain();
    thread_data->temp_domain = mpk_malloc(sizeof(domain_t));
    ((domain_t*)thread_data->temp_domain)->domain = thread_data->domain;
    size_t stack_size;
    pthread_attr_t temp_attr;
    void* stack_addr;
    if(thread_data->domain) {
        /* fprintf(stderr, "external, temp_attr %p\n"); */

        if(pthread_attr_init(&temp_attr)){
            THREAD_ATTR_INIT_ERROR
        }

        if(pthread_attr_getstack(&temp_attr, &stack_addr, &stack_size)){
            GET_THREAD_STACK_ADDR_ERROR
        }

        /* fprintf(stderr,"assigned stack size: 0x%lx, addr: %p\n",stack_size, stack_addr); */
        stack_size = stack_size > DEFAULT_STACK_SIZE? stack_size: DEFAULT_STACK_SIZE;
       void *stack = __allocate_extern_stack(DEFAULT_STACK_SIZE);
       //fprintf(stderr,"New thread stack = %p\n", stack);
       pthread_attr_setstack(&temp_attr, stack, DEFAULT_STACK_SIZE);
       attr = &temp_attr;
    }
    int _return = real_pthread_create(thread, attr, thread_hook, thread_data);
    /* fprintf(stderr, "Thread created\n"); */
    return _return;
}

void free_domain_data(void* domain){
    ///Destroy thread domain data
}
