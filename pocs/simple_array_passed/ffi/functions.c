#include <stdio.h>

void write_memory_ptr(long int* mem_addr) {
//	printf("Writing memory from: write_memory_ptr, address = %p\n", mem_addr);
	*mem_addr = 1337;
//	printf("Written memory successfully\n");
	return;
}

void write_memory_val(long int addr) {
	long int* ptr = (long int*)addr;
	*ptr = 100;
}
