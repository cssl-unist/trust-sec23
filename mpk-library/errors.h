#ifndef MPK_ERRORS_H
#define MPK_ERRORS_H

#define _GNU_SOURCE
#include<stdio.h>
#include<dlfcn.h>
#include<stdlib.h>
#include<sys/mman.h>
#include<sys/syscall.h>
#include<stdint.h>
#include<string.h>
#include<stddef.h>
#include<unistd.h>
#include<pthread.h>
#include<limits.h>

#define OUT_OF_MEMORY_ERROR \
{                           \
      fprintf(stderr, "Out of memory\n"); \
      abort();              \
}

#define NO_DOMAIN_VALUE_ERROR \
{                             \
    fprintf(stderr, "Thread has no domain\n"); \
    abort();\
};
#define UNINITIALIZED_CALL_PRIVATE_ERROR  \
    {                                     \
        fprintf(stderr,"Calling private function without initialization. Something seems wrong\n"); \
        abort();                          \
    }

#define GET_THREAD_STACK_ADDR_ERROR \
{                                   \
    fprintf(stderr, "Unable to obtain thread stack address and size\n"); \
    abort();                        \
}

#define GET_THREAD_STACK_SIZE_ERROR \
{                                   \
    fprintf(stderr, "Unable to obtain thread stack size\n"); \
    abort();                        \
}

#define GET_THREAD_ATTR_ERROR \
{                             \
    fprintf(stderr, "Unable to obtain the stack address and size of the caller thread\n"); \
    abort();                  \
}

#define PTHREAD_HOOKING_ERROR \
  fprintf(stderr, "Unable to create pthread library hooks\n"); \
  abort(); 

#define DOMAIN_KEY_CREATE_ERROR \
{                                     \
    fprintf(stderr, "Unable to initialize domain key\n"); \
    abort();                           \
}

#define DOMAIN_SET_ERROR \
{                                     \
    fprintf(stderr, "Unable to set domain value\n"); \
    abort();                           \
}

#define ALLOCATOR_HOOKING_ERROR(s) \
{                                     \
    fprintf(stderr, "%s", s); \
    abort();                           \
}

#define MAP_SBRK_HOOK_ERROR \
{                           \
    fprintf(stderr, "Hooking sbrk, mmap or mremap failed\n"); \
    abort();                            \
}

#define THREAD_ATTR_INIT_ERROR    \
{                           \
    fprintf(stderr, "Unable to create thread attribute\n"); \
    abort();                \
}

#define SOCKET_ERROR \
{                    \
    fprintf(stderr, "Unable to open server socket\n"); \
    abort();\
};

#define ADDRESS_CONVERSION_ERROR \
{                                \
    fprintf(stderr, "Unable to convert server address to binary form\n"); \
    abort();                    \
};

#define SERVER_CONNECTION_ERROR \
{                               \
    fprintf(stderr, "Unable to establish server connection\n"); \
    abort();\
};

#define TRANSMISSION_ERROR \
{                          \
    fprintf(stderr, "Unable to send signal\n"); \
    abort();\
};
#endif
