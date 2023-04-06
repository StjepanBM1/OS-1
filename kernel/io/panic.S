
	.section	.text
	.global		panic
	.global		id
	.code16

		panic:

			.screen:
				mov 	$0x03,	%ax
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0x20,	%al
				mov 	$0x00,	%bh
				mov 	$0x0C,	%bl
				mov 	$2240,	%cx
				int 	$0x10

				mov 	$0x09,	%ah
				mov 	$0x2A,	%al
				mov 	$0x0C,	%bl
				mov 	$80,	%cx
				int 	$0x10

				mov 	$0x02,	%ah
				mov 	$1,		%dh
				mov 	$0,		%dl
				int 	$0x10

			.info:
			
				#mov 	$0xFF,	id

				mov 	$pmsg1,	%si
				call   	write

				mov 	$pmsg2,	%si
				call   	write

				mov 	$pmsg3,	%si
				call   	write

				mov 	$ax_s,	%si
				call 	write
				movw	%ax,	(reg16)
				call 	wregs

				mov 	$bx_s,	%si
				call 	write
				movw	%bx,	(reg16)
				call 	wregs

				mov 	$cx_s,	%si
				call 	write
				movw	%cx,	(reg16)
				call 	wregs

				mov 	$dx_s,	%si
				call 	write
				movw	%dx,	(reg16)
				call 	wregs

				############################
				mov 	$0x02,	%ah
				mov 	$6,		%dh
				mov 	$14,	%dl
				int 	$0x10
				mov 	$sp_s,	%si
				call 	write
				movw	%sp,	(reg16)
				call 	wregs

				mov 	$0x02,	%ah
				mov 	$7,		%dh
				mov 	$14,	%dl
				int 	$0x10
				mov 	$bp_s,	%si
				call 	write
				movw	%bp,	(reg16)
				call 	wregs

				mov 	$0x02,	%ah
				mov 	$8,		%dh
				mov 	$14,	%dl
				int 	$0x10
				mov 	$si_s,	%si
				call 	write
				movw	%si,	(reg16)
				call 	wregs

				mov 	$0x02,	%ah
				mov 	$9,		%dh
				mov 	$14,	%dl
				int 	$0x10
				mov 	$di_s,	%si
				call 	write
				movw	%di,	(reg16)
				call 	wregs

				############################
				mov 	$0x02,	%ah
				mov 	$6,		%dh
				mov 	$28,	%dl
				int 	$0x10
				mov 	$cs_s,	%si
				call 	write
				movw	%cs,	(reg16)
				call 	wregs

				mov 	$0x02,	%ah
				mov 	$7,		%dh
				mov 	$28,	%dl
				int 	$0x10
				mov 	$ds_s,	%si
				call 	write
				movw	%ds,	(reg16)
				call 	wregs

				mov 	$0x02,	%ah
				mov 	$8,		%dh
				mov 	$28,	%dl
				int 	$0x10
				mov 	$es_s,	%si
				call 	write
				movw	%es,	(reg16)
				call 	wregs

				mov 	$0x02,	%ah
				mov 	$9,		%dh
				mov 	$28,	%dl
				int 	$0x10
				mov 	$ss_s,	%si
				call 	write
				movw	%ss,	(reg16)
				call 	wregs

				mov 	$pmsg4,	%si
				call   	write

				mov 	$0x01,	%ah
				mov 	$0x2607,%cx
				int 	$0x10

				mov 	$0x02,	%ah
				mov 	$12,	%dh
				mov 	$0,		%dl
				int 	$0x10
				mov 	$0x09,	%ah
				mov 	$0x2A,	%al
				mov 	$0x0C,	%bl
				mov 	$80,	%cx
				int 	$0x10

				call 	waitk_reb

	.section	.rodata
		#	Registers
		ax_s:	.asciz	"  AX :: "
		bx_s:	.asciz	"  BX :: "
		cx_s:	.asciz	"  CX :: "
		dx_s:	.asciz	"  DX :: "

		sp_s:	.asciz	"  SP :: "
		bp_s:	.asciz	"  BP :: "
		si_s:	.asciz	"  SI :: "
		di_s:	.asciz	"  DI :: "
		
		cs_s:	.asciz	"  CS :: "
		ds_s:	.asciz	"  DS :: "
		es_s:	.asciz	"  ES :: "
		ss_s:	.asciz	"  SS :: "
		id_s:	.asciz	"  ID :: "

		#	Msgs
		pmsg1:	.asciz	"   \xAF System Panic \xAE\r\n\r\n"
		pmsg2:	.asciz	"    The operating system kernel has experienced a fatal error.\r\n"
		pmsg3:	.asciz	"    Registers dumped.\r\n\n"
		pmsg4:	.asciz	"\r\n    Press any key to restart"
