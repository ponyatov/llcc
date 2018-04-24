/**
@file
@brief GNU linker script: QEMU Cortex-M3 /RAM-only build/
*/

MEMORY
{
  FLASH (rx) : ORIGIN = 0x00000000, LENGTH = 128K
   RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

INCLUDE ANY.ld
INCLUDE ANY_RAM.ld
