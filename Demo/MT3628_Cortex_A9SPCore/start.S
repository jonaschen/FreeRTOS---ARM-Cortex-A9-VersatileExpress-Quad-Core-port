
.global _reset
.global _vector_table

.global _undefined_instruction
.global _software_interrupt
.global _prefetch_abort
.global _data_abort
.global _not_used
.global _irq
.global _fiq

.equ T_bit, 0x20

.section ".vectors", "ax"
_vector_table:
	b	_reset
	ldr	pc, _undefined_instruction
	ldr	pc, _software_interrupt
	ldr	pc, _prefetch_abort
	ldr	pc, _data_abort
	ldr	pc, _not_used
	ldr	pc, _irq
	ldr	pc, _fiq


_undefined_instruction:	.word undefined_instruction 
_software_interrupt: 	.word software_interrupt
_prefetch_abort:	.word prefetch_abort
_data_abort:		.word data_abort
_not_used:		.word not_used
_irq:			.word irq
_fiq:			.word fiq


_reset:
	ldr	sp, main_stack
        bl      _init

main_stack:	.word	__stack		// set __stack in link scripts (ld file)


undefined_instruction:
    // Put system/user mode R14-R0, exception address (LR - (4(ARM) or 2(THUMB))) and SPSR on stack
    // used for logging
    STMDB      SP, {R0-LR}^
    NOP
    SUB        SP, SP, #60
    MRS        R0, SPSR
    SUB        R1, LR, #2
    // if ARM mode subtract 2 more
    TST        R0, #T_bit
    SUBEQ      R1, R1, #2
    STMDB      SP!, {R1}
    STMDB      SP!, {R0}
    NOP
    MOV        R0, SP
    BL         Undefined_Handler_Panic

// The following SWI handler support just the taskswitch for OpenRTOS
software_interrupt:
                B                               vPortSVCHandler

prefetch_abort:
    // Put system/user mode R14-R0, exception address (LR - 4) and SPSR on stack
    // used for logging
    STMDB      SP, {R0-LR}^
    NOP
    SUB        SP, SP, #60
    SUB        R0, LR, #4
    STMDB      SP!, {R0}
    MRS        R0, SPSR
    STMDB      SP!, {R0}
    NOP
    MOV        R0, SP
    BL         Prefetch_Handler_Panic

data_abort:
    // Put system/user mode R14-R0, exception address (LR - 8) and SPSR on stack
    // used for logging
    STMDB      SP, {R0-LR}^
    NOP
    SUB        SP, SP, #60
    SUB        R0, LR, #8
    STMDB      SP!, {R0}
    MRS        R0, SPSR
    STMDB      SP!, {R0}
    NOP
    MOV        R0, SP
    BL         Abort_Handler_Panic

not_used:
1:
	bl	1b

irq:
fiq:
        B                                       vPortInterruptContext

.end
