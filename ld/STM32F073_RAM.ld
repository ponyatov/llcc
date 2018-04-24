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

_estack = ORIGIN(RAM) + LENGTH(RAM);	/* end of .stack */

SECTIONS
{

	.isr_vector : {
		. = ALIGN(4);
		_sint = .;
		KEEP( *(.isr_vector) )	/* interrupt vector table */
		. = ALIGN(4);
		_eint = .;
	} > RAM
	
	.init : {					/* all init.code sections goes here */
		. = ALIGN(4);
		/* The standalone startup code
         * currently does not run these, better use the init arrays  */
		KEEP(*(.init))
		KEEP(*(.fini))
		/* Used to run the SystemInit() before anything else. */
		KEEP(*(.preinit_array_sysinit*))
		KEEP(*(.preinit_array_platform*))	/* Other platform inits */
		/* The init code, i.e. an array of pointers to static constructors. */
		KEEP(*(SORT(.init_array*)))
		/* The fini code, i.e. an array of pointers to static destructors */
		KEEP(*(SORT(.fini_array*)))
		. = ALIGN(4);
	} > RAM
	
	.text : {
		. = ALIGN(4);
		_stext = .;
		*(.text*)				/* all program code */
		*(.rodata*)				/* constants & data initializers */
		KEEP(*(.eh_frame*))
		*(.jcr*)				/* ??? */
		. = ALIGN(4);
		_etext = .;				/* end of code */
	} > RAM
	
	.data : {
		. = ALIGN(4);
		_sdata = .;
		*(.data*)
		. = ALIGN(4);
		_edata = .;
	} > RAM
	
	.bss : {
		. = ALIGN(4);
		_sbss = .;				/* [s]tart .bss */
		__bss_start__ = _sbss;
		*(.bss)
		*(.bss*)
		*(COMMON*)
		. = ALIGN(4);
		_ebss = .;				/* [e]nd .bss */
		__bss_end__ = _ebss;
	} > RAM
	
	/DISCARD/ : {				/* drop unused segments */
		*(.ARM*)				/* ARM magic sections */
		*(.comment*)
	}
	
	.ARM.attributes 0 : { *(.ARM.attributes) }
}

