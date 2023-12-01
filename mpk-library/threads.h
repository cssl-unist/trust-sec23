//
// Created by martin on 21. 5. 21..
//

#ifndef MPK_LIBRARY_THREADS_H
#define MPK_LIBRARY_THREADS_H

#include "allocator.h"

typedef struct thread_data{
    int domain;
    void* (*orig_func)(void*);
    void* orig_args;
    void* temp_domain;
} thread_data_t;

void init_threading_hooks();
void free_domain_data(void*);
void *thread_hook(void* args);
typedef int (*pthread_create_t)(pthread_t* restrict, const pthread_attr_t* restrict, void*(*)(void*), void* restrict);
#endif //MPK_LIBRARY_THREADS_H
