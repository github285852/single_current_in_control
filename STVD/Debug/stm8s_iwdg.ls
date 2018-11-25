   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  80                     ; 48 void IWDG_WriteAccessCmd(IWDG_WriteAccess_TypeDef IWDG_WriteAccess)
  80                     ; 49 {
  82                     	switch	.text
  83  0000               _IWDG_WriteAccessCmd:
  85  0000 88            	push	a
  86       00000000      OFST:	set	0
  89                     ; 51   assert_param(IS_IWDG_WRITEACCESS_MODE_OK(IWDG_WriteAccess));
  91  0001 a155          	cp	a,#85
  92  0003 2703          	jreq	L01
  93  0005 4d            	tnz	a
  94  0006 2603          	jrne	L6
  95  0008               L01:
  96  0008 4f            	clr	a
  97  0009 2010          	jra	L21
  98  000b               L6:
  99  000b ae0033        	ldw	x,#51
 100  000e 89            	pushw	x
 101  000f ae0000        	ldw	x,#0
 102  0012 89            	pushw	x
 103  0013 ae0000        	ldw	x,#L73
 104  0016 cd0000        	call	_assert_failed
 106  0019 5b04          	addw	sp,#4
 107  001b               L21:
 108                     ; 53   IWDG->KR = (uint8_t)IWDG_WriteAccess; /* Write Access */
 110  001b 7b01          	ld	a,(OFST+1,sp)
 111  001d c750e0        	ld	20704,a
 112                     ; 54 }
 115  0020 84            	pop	a
 116  0021 81            	ret
 207                     ; 63 void IWDG_SetPrescaler(IWDG_Prescaler_TypeDef IWDG_Prescaler)
 207                     ; 64 {
 208                     	switch	.text
 209  0022               _IWDG_SetPrescaler:
 211  0022 88            	push	a
 212       00000000      OFST:	set	0
 215                     ; 66   assert_param(IS_IWDG_PRESCALER_OK(IWDG_Prescaler));
 217  0023 4d            	tnz	a
 218  0024 2718          	jreq	L02
 219  0026 a101          	cp	a,#1
 220  0028 2714          	jreq	L02
 221  002a a102          	cp	a,#2
 222  002c 2710          	jreq	L02
 223  002e a103          	cp	a,#3
 224  0030 270c          	jreq	L02
 225  0032 a104          	cp	a,#4
 226  0034 2708          	jreq	L02
 227  0036 a105          	cp	a,#5
 228  0038 2704          	jreq	L02
 229  003a a106          	cp	a,#6
 230  003c 2603          	jrne	L61
 231  003e               L02:
 232  003e 4f            	clr	a
 233  003f 2010          	jra	L22
 234  0041               L61:
 235  0041 ae0042        	ldw	x,#66
 236  0044 89            	pushw	x
 237  0045 ae0000        	ldw	x,#0
 238  0048 89            	pushw	x
 239  0049 ae0000        	ldw	x,#L73
 240  004c cd0000        	call	_assert_failed
 242  004f 5b04          	addw	sp,#4
 243  0051               L22:
 244                     ; 68   IWDG->PR = (uint8_t)IWDG_Prescaler;
 246  0051 7b01          	ld	a,(OFST+1,sp)
 247  0053 c750e1        	ld	20705,a
 248                     ; 69 }
 251  0056 84            	pop	a
 252  0057 81            	ret
 286                     ; 78 void IWDG_SetReload(uint8_t IWDG_Reload)
 286                     ; 79 {
 287                     	switch	.text
 288  0058               _IWDG_SetReload:
 292                     ; 80   IWDG->RLR = IWDG_Reload;
 294  0058 c750e2        	ld	20706,a
 295                     ; 81 }
 298  005b 81            	ret
 321                     ; 89 void IWDG_ReloadCounter(void)
 321                     ; 90 {
 322                     	switch	.text
 323  005c               _IWDG_ReloadCounter:
 327                     ; 91   IWDG->KR = IWDG_KEY_REFRESH;
 329  005c 35aa50e0      	mov	20704,#170
 330                     ; 92 }
 333  0060 81            	ret
 356                     ; 99 void IWDG_Enable(void)
 356                     ; 100 {
 357                     	switch	.text
 358  0061               _IWDG_Enable:
 362                     ; 101   IWDG->KR = IWDG_KEY_ENABLE;
 364  0061 35cc50e0      	mov	20704,#204
 365                     ; 102 }
 368  0065 81            	ret
 381                     	xdef	_IWDG_Enable
 382                     	xdef	_IWDG_ReloadCounter
 383                     	xdef	_IWDG_SetReload
 384                     	xdef	_IWDG_SetPrescaler
 385                     	xdef	_IWDG_WriteAccessCmd
 386                     	xref	_assert_failed
 387                     .const:	section	.text
 388  0000               L73:
 389  0000 2e2e5c736f75  	dc.b	"..\source\stm8s_st"
 390  0012 647065726970  	dc.b	"dperiph_driver\src"
 391  0024 5c73746d3873  	dc.b	"\stm8s_iwdg.c",0
 411                     	end
