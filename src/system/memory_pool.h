#pragma once
#include "../header.h"
byte *memory_pool;
typedef struct pnode{
    void* last_used;
    void* end_memory;
    struct pnode* next;
}pool_node;
pool_node pool_head = {nullptr, nullptr, (pool_node*)nullptr};
void* malloc(unsigned long memory_length){
    pool_node* target = &pool_head;
    while(target != nullptr){
        if((byte*)target->end_memory - (byte*)target->last_used >= memory_length){
            target->last_used += memory_length;
            return (target->last_used - memory_length);
        }
        target = target->next;
    }
    return nullptr;
}
void add_pool(void* base_addr, unsigned long length){
    pool_node* target = &pool_head;
    while(target->next != nullptr){
        target = target->next;
        if(target->next == nullptr) {
            target = target->next = malloc(sizeof(pool_node));
            target->next = (pool_node*)nullptr;
        }
    }
    target->last_used = base_addr;
    target->end_memory = base_addr + length;
}
void init_pool(){
    memory_pool = getESP();
    add_pool(memory_pool + 0x10000, SPACE * 1024 * 1024);
}
#define free(x, y) add_pool(x, y)
