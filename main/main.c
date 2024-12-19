/*
 * SPDX-FileCopyrightText: 2010-2022 Espressif Systems (Shanghai) CO LTD
 *
 * SPDX-License-Identifier: CC0-1.0
 */

#include <stdio.h>
#include <mrubyc.h>

#ifndef HEAP_SIZE
#define HEAP_SIZE (1024 * 194)
#endif

static uint8_t heap_pool[HEAP_SIZE];

void app_main(void)
{
  mrbc_init(heap_pool, HEAP_SIZE);
}
