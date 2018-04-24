/**
@file
@brief GNU linker script: QEMU Cortex-M3 / Stellaris lm3s811evb /RAM-only build/

@see http://www.ti.com/product/lm3s811

*/

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 64K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 8K
}

SECTIONS
{

	.isr_vector : {
		. = ALIGN(8);
		_sint = .;
		KEEP( *(.isr_vector) )		/* interrupt vector table */
		. = ALIGN(8);
		_eint = .;
	} > FLASH
	
}

INCLUDE ld/ANY_RAM.ld
INCLUDE ld/ANY.ld
