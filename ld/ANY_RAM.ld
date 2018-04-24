/**
@file
@brief GNU linker script: sections for RAM-only system
*/

SECTIONS
{

	.init : {					/* all init.code sections goes here */
		. = ALIGN(8);
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
		. = ALIGN(8);
	} > RAM
	
	.text : {
		. = ALIGN(8);
		_stext = .;
		*(.text*)				/* all program code */
		*(.ctors)				/* C++ constructors */
		*(.dtors)				/* C++ destructors */
		*(.rodata*)				/* constants & data initializers */
		KEEP(*(.eh_frame*))		/* C++ exceptions */
		*(.jcr*)				/* ??? */
		. = ALIGN(8);
		_etext = .;				/* end of code */
	} > RAM
	
	.data : {
		. = ALIGN(8);
		_sdata = .;
		*(.data*)
		. = ALIGN(8);
		_edata = .;
	} > RAM
	
}
