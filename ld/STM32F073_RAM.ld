/**
@file
@brief STM32F073VZ linker script for RAM-only build
*/

ENTRY(Reset_Handler)					/* entry point (for debugger) */

MEMORY
{
FLASH	(rx)	: ORIGIN = 0x08000000, LENGTH = 192K
RAM		(xrw)	: ORIGIN = 0x20000000, LENGTH =  20K
}

INCLUDE ld/ANY_RAM.ld
INCLUDE ld/ANY.ld
