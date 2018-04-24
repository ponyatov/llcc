/**
@file
@brief GNU linker script: QEMU Cortex-M3 /RAM-only build/
*/

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 128K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

SECTIONS
{

	.isr_vector : {
		. = ALIGN(4);
		_sint = .;
		KEEP( *(.isr_vector) )	/* interrupt vector table */
		. = ALIGN(4);
		_eint = .;
	} > FLASH
	
}

INCLUDE ld/ANY_RAM.ld
INCLUDE ld/ANY.ld
