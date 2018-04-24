/**
@file
@brief GNU linker script: QEMU Cortex-M3 / Stellaris lm3s6965 /RAM-only build/

@see http://www.ti.com/product/lm3s6965
@see http://balau82.wordpress.com/2011/09/03/using-codesourcery-bare-metal-toolchain-for-cortex-m3/

*/

MEMORY
{
  FLASH (rx)  : ORIGIN = 0x00000000, LENGTH = 256K
    RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

SECTIONS
{

	.isr_vector : {
		. = ALIGN(8);
		_sint = .;
		KEEP( *(.isr_vector) )	/* interrupt vector table */
		. = ALIGN(8);
		_eint = .;
	} > FLASH
	
}

INCLUDE ld/ANY_RAM.ld
INCLUDE ld/ANY.ld

