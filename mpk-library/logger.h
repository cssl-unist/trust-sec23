//
// Created by martin on 7/19/22.
//

#ifndef MPK_LIBRARY_LOGGER_H
#define MPK_LIBRARY_LOGGER_H
#define SERVER_PORT 4636

/* signals */
#define END_EXECUTION 101
#define BEGIN_EXECUTION 501
#define LOAD_FALSE_NEGATIVE 1
#define STORE_FALSE_NEGATIVE 2
#define LOAD_FALSE_POSITIVE 3
#define STORE_FALSE_POSITIVE 6
#define TOTAL_STORES    4
#define TOTAL_LOADS     5
#define TOTAL_UNSAFE_STORES 7
#define TOTAL_ALLOCAS   8
#define UNSAFE_ALLOCAS  9
#define TOTAL_HEAP_ALLOC 10
#define UNSAFE_HEAP_ALLOC 11

typedef struct{
    int signal;
    int value;
}Log;

extern int loggerFd;
void logging(int, int);
void init_logger_socket();
#endif //MPK_LIBRARY_LOGGER_H
