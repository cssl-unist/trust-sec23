//
// Created by martin on 7/19/22.
//
#include "logger.h"
#include "errors.h"
#include <sys/socket.h>
#include <arpa/inet.h>

int logger_sock = -1;
struct sockaddr_in server;
pthread_mutex_t send_lock;
void init_logger_socket(){
    if((logger_sock = socket(AF_INET, SOCK_STREAM, 0)) < 0){
        SOCKET_ERROR
    }
    server.sin_family = AF_INET;
    server.sin_port = htons(SERVER_PORT);

    if(inet_pton(AF_INET, "127.0.0.1", &server.sin_addr) <= 0){
        ADDRESS_CONVERSION_ERROR
    }

    if(connect(logger_sock, (struct sockaddr*)&server, sizeof(server)) < 0){
        SERVER_CONNECTION_ERROR
    }

    pthread_mutex_init(&send_lock, NULL);
}

void logging(int signal, int value){
    pthread_mutex_lock(&send_lock);
    Log log = {.signal = signal, .value = value};
    if(send(logger_sock, (void*)(&log), sizeof(log), 0) < 0){
        TRANSMISSION_ERROR
    }
    pthread_mutex_unlock(&send_lock);
}