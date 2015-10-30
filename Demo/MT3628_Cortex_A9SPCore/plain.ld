ENTRY(_vector_table);
MEMORY
{
	ram (rwx) : ORIGIN = 0x0000000, LENGTH = ( 4M - 0x00000 )
}

PROVIDE(__stack = 0x00600000);

SECTIONS
{
    .text :
    {
        _text = .;
        __isr_vector_start = .;
        *(.vectors)
        __isr_vector_end = .;
        *(.text*)
        *(.rodata*)
        _etext = .;
    } > ram
    .data : /*AT(ADDR(.text) + SIZEOF(.text))*/
    {
        _data = .;
        *(vtable)
        *(.data*)
        _edata = .;
    } > ram
    .bss :
    {
        _bss = .;
        *(.bss*)
        *(COMMON)
        _ebss = .;
    } > ram
}

