/**
@file
@brief GNU linker script: sections for any system
*/

_estack = ORIGIN(RAM) + LENGTH(RAM);	/* end of .stack */

SECTIONS
{

	.bss : {
		. = ALIGN(8);
		_sbss = .;				/* [s]tart .bss */
		__bss_start__ = _sbss;
		*(.bss)
		*(.bss*)
		*(COMMON*)
		. = ALIGN(8);
		_ebss = .;				/* [e]nd .bss */
		__bss_end__ = _ebss;
	} > RAM
	
	/DISCARD/ : {				/* drop unused segments */
		*(.ARM*)				/* ARM magic sections */
		*(.comment*)
	}
	
	.ARM.attributes 0 : { *(.ARM.attributes) }

}