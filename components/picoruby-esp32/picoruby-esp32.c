#include <inttypes.h>
#include <picogem_init.c>
#include <executables_init.c>

#include <mrubyc.h>
#include "../../build/mrb/main_task.c"

#ifndef HEAP_SIZE
#define HEAP_SIZE (1024 * 192)
#endif

static uint8_t heap_pool[HEAP_SIZE];

void picoruby_esp32(void)
{
  mrbc_init(heap_pool, HEAP_SIZE);

  mrbc_tcb *tcb = mrbc_create_task(main_task, 0);
  mrbc_vm *vm = &tcb->vm;

  picoruby_init_require(vm);
  picoruby_init_executables(vm);
  mrbc_run();
}
