   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  16                     	bsct
  17  0000               _t2ms:
  18  0000 00            	dc.b	0
  19  0001               _t10ms:
  20  0001 00            	dc.b	0
  21  0002               _t1s:
  22  0002 00            	dc.b	0
  62                     ; 23 void TIM2_SetCounter(uint16_t Counter)
  62                     ; 24 {
  64                     	switch	.text
  65  0000               _TIM2_SetCounter:
  69                     ; 25   TIM2->CNTRH = (uint8_t)(Counter >> 8);
  71  0000 9e            	ld	a,xh
  72  0001 c7530c        	ld	21260,a
  73                     ; 26   TIM2->CNTRL = (uint8_t)(Counter);
  75  0004 9f            	ld	a,xl
  76  0005 c7530d        	ld	21261,a
  77                     ; 27 }
  80  0008 81            	ret
 114                     ; 28 uint16_t TIM2_GetCounter(void)
 114                     ; 29 {
 115                     	switch	.text
 116  0009               _TIM2_GetCounter:
 118  0009 89            	pushw	x
 119       00000002      OFST:	set	2
 122                     ; 30   uint16_t tmpcntr = 0;
 124                     ; 31   tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
 126  000a c6530c        	ld	a,21260
 127  000d 5f            	clrw	x
 128  000e 97            	ld	xl,a
 129  000f 4f            	clr	a
 130  0010 02            	rlwa	x,a
 131  0011 1f01          	ldw	(OFST-1,sp),x
 132                     ; 32   return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
 134  0013 c6530d        	ld	a,21261
 135  0016 5f            	clrw	x
 136  0017 97            	ld	xl,a
 137  0018 01            	rrwa	x,a
 138  0019 1a02          	or	a,(OFST+0,sp)
 139  001b 01            	rrwa	x,a
 140  001c 1a01          	or	a,(OFST-1,sp)
 141  001e 01            	rrwa	x,a
 144  001f 5b02          	addw	sp,#2
 145  0021 81            	ret
 179                     ; 34 void TIM2_SetCompare1(uint16_t Compare1)
 179                     ; 35 {
 180                     	switch	.text
 181  0022               _TIM2_SetCompare1:
 185                     ; 36   TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
 187  0022 9e            	ld	a,xh
 188  0023 c75311        	ld	21265,a
 189                     ; 37   TIM2->CCR1L = (uint8_t)(Compare1);
 191  0026 9f            	ld	a,xl
 192  0027 c75312        	ld	21266,a
 193                     ; 38 }
 196  002a 81            	ret
 315                     ; 39 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
 315                     ; 40 {
 316                     	switch	.text
 317  002b               _TIM2_GetITStatus:
 319  002b 88            	push	a
 320  002c 89            	pushw	x
 321       00000002      OFST:	set	2
 324                     ; 41   ITStatus bitstatus = RESET;
 326                     ; 42   uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
 330                     ; 43   assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
 332  002d a101          	cp	a,#1
 333  002f 270c          	jreq	L61
 334  0031 a102          	cp	a,#2
 335  0033 2708          	jreq	L61
 336  0035 a104          	cp	a,#4
 337  0037 2704          	jreq	L61
 338  0039 a108          	cp	a,#8
 339  003b 2603          	jrne	L41
 340  003d               L61:
 341  003d 4f            	clr	a
 342  003e 2010          	jra	L02
 343  0040               L41:
 344  0040 ae002b        	ldw	x,#43
 345  0043 89            	pushw	x
 346  0044 ae0000        	ldw	x,#0
 347  0047 89            	pushw	x
 348  0048 ae0000        	ldw	x,#L141
 349  004b cd0000        	call	_assert_failed
 351  004e 5b04          	addw	sp,#4
 352  0050               L02:
 353                     ; 44   TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
 355  0050 c65304        	ld	a,21252
 356  0053 1403          	and	a,(OFST+1,sp)
 357  0055 6b01          	ld	(OFST-1,sp),a
 358                     ; 45   TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
 360  0057 c65303        	ld	a,21251
 361  005a 1403          	and	a,(OFST+1,sp)
 362  005c 6b02          	ld	(OFST+0,sp),a
 363                     ; 46   if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
 365  005e 0d01          	tnz	(OFST-1,sp)
 366  0060 270a          	jreq	L341
 368  0062 0d02          	tnz	(OFST+0,sp)
 369  0064 2706          	jreq	L341
 370                     ; 48     bitstatus = SET;
 372  0066 a601          	ld	a,#1
 373  0068 6b02          	ld	(OFST+0,sp),a
 375  006a 2002          	jra	L541
 376  006c               L341:
 377                     ; 52     bitstatus = RESET;
 379  006c 0f02          	clr	(OFST+0,sp)
 380  006e               L541:
 381                     ; 54   return (ITStatus)(bitstatus);
 383  006e 7b02          	ld	a,(OFST+0,sp)
 386  0070 5b03          	addw	sp,#3
 387  0072 81            	ret
 411                     ; 58 INTERRUPT_HANDLER(NonHandledInterrupt, 25)
 411                     ; 59 {
 413                     	switch	.text
 414  0073               f_NonHandledInterrupt:
 418                     ; 60 }
 421  0073 80            	iret
 443                     ; 62 INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
 443                     ; 63 {
 444                     	switch	.text
 445  0074               f_TRAP_IRQHandler:
 449                     ; 64 }
 452  0074 80            	iret
 474                     ; 65 INTERRUPT_HANDLER(TLI_IRQHandler, 0)
 474                     ; 66 {
 475                     	switch	.text
 476  0075               f_TLI_IRQHandler:
 480                     ; 67 }
 483  0075 80            	iret
 505                     ; 68 INTERRUPT_HANDLER(AWU_IRQHandler, 1)
 505                     ; 69 {
 506                     	switch	.text
 507  0076               f_AWU_IRQHandler:
 511                     ; 70 }
 514  0076 80            	iret
 536                     ; 71 INTERRUPT_HANDLER(CLK_IRQHandler, 2)
 536                     ; 72 {
 537                     	switch	.text
 538  0077               f_CLK_IRQHandler:
 542                     ; 73 }
 545  0077 80            	iret
 568                     ; 74 INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
 568                     ; 75 {
 569                     	switch	.text
 570  0078               f_EXTI_PORTA_IRQHandler:
 574                     ; 94 }
 577  0078 80            	iret
 600                     ; 95 INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
 600                     ; 96 {
 601                     	switch	.text
 602  0079               f_EXTI_PORTB_IRQHandler:
 606                     ; 97 }
 609  0079 80            	iret
 632                     ; 98 INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
 632                     ; 99 {
 633                     	switch	.text
 634  007a               f_EXTI_PORTC_IRQHandler:
 638                     ; 131 }
 641  007a 80            	iret
 664                     ; 132 INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
 664                     ; 133 {
 665                     	switch	.text
 666  007b               f_EXTI_PORTD_IRQHandler:
 670                     ; 134 }
 673  007b 80            	iret
 696                     ; 135 INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
 696                     ; 136 {
 697                     	switch	.text
 698  007c               f_EXTI_PORTE_IRQHandler:
 702                     ; 137 }
 705  007c 80            	iret
 727                     ; 138 INTERRUPT_HANDLER(SPI_IRQHandler, 10)
 727                     ; 139 {
 728                     	switch	.text
 729  007d               f_SPI_IRQHandler:
 733                     ; 140 }
 736  007d 80            	iret
 759                     ; 141 INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
 759                     ; 142 {
 760                     	switch	.text
 761  007e               f_TIM1_UPD_OVF_TRG_BRK_IRQHandler:
 765                     ; 143 	TIM1->CNTRH = 0xFF;//定时 200us,手动加载
 767  007e 35ff525e      	mov	21086,#255
 768                     ; 144 	TIM1->CNTRL = 0x9b + 3;
 770  0082 359e525f      	mov	21087,#158
 771                     ; 145 }
 774  0086 80            	iret
 797                     ; 146 INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
 797                     ; 147 {
 798                     	switch	.text
 799  0087               f_TIM1_CAP_COM_IRQHandler:
 803                     ; 148 }
 806  0087 80            	iret
 829                     ; 149 INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
 829                     ; 150 {
 830                     	switch	.text
 831  0088               f_TIM2_UPD_OVF_BRK_IRQHandler:
 835                     ; 151 	TIM2->SR1 = (uint8_t)~TIM2_IT_UPDATE;
 837  0088 35fe5304      	mov	21252,#254
 838                     ; 152 }
 841  008c 80            	iret
 864                     ; 153 INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
 864                     ; 154 {
 865                     	switch	.text
 866  008d               f_TIM2_CAP_COM_IRQHandler:
 870                     ; 178 }
 873  008d 80            	iret
 896                     ; 179 INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
 896                     ; 180 {
 897                     	switch	.text
 898  008e               f_TIM3_UPD_OVF_BRK_IRQHandler:
 902                     ; 181 }
 905  008e 80            	iret
 928                     ; 182 INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
 928                     ; 183 {
 929                     	switch	.text
 930  008f               f_TIM3_CAP_COM_IRQHandler:
 934                     ; 184 }
 937  008f 80            	iret
 960                     ; 185 INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
 960                     ; 186 {
 961                     	switch	.text
 962  0090               f_UART1_TX_IRQHandler:
 966                     ; 187 }
 969  0090 80            	iret
 992                     ; 188 INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
 992                     ; 189 {
 993                     	switch	.text
 994  0091               f_UART1_RX_IRQHandler:
 998                     ; 190 }
1001  0091 80            	iret
1023                     ; 191 INTERRUPT_HANDLER(I2C_IRQHandler, 19)
1023                     ; 192 {
1024                     	switch	.text
1025  0092               f_I2C_IRQHandler:
1029                     ; 193 }
1032  0092 80            	iret
1054                     ; 194 INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
1054                     ; 195 {
1055                     	switch	.text
1056  0093               f_ADC1_IRQHandler:
1060                     ; 196 }
1063  0093 80            	iret
1087                     ; 198 void t1s_loop(void)
1087                     ; 199 {
1089                     	switch	.text
1090  0094               _t1s_loop:
1094                     ; 200 	if(t10ms > 99)	// 1 second
1096  0094 b601          	ld	a,_t10ms
1097  0096 a164          	cp	a,#100
1098  0098 250e          	jrult	L724
1099                     ; 202 		t10ms = 0;
1101  009a 3f01          	clr	_t10ms
1102                     ; 203 		t1s++;
1104  009c 3c02          	inc	_t1s
1105                     ; 205 		if(t1s > 59)	// 1 minute
1107  009e b602          	ld	a,_t1s
1108  00a0 a13c          	cp	a,#60
1109  00a2 2508          	jrult	L334
1110                     ; 207 			t1s = 0;
1112  00a4 3f02          	clr	_t1s
1113  00a6 2004          	jra	L334
1114  00a8               L724:
1115                     ; 211 	else if(t10ms > 49)	// 0.5 second
1117  00a8 b601          	ld	a,_t10ms
1118  00aa a132          	cp	a,#50
1119  00ac               L334:
1120                     ; 215 }
1123  00ac 81            	ret
1150                     ; 217 INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
1150                     ; 218 {
1152                     	switch	.text
1153  00ad               f_TIM4_UPD_OVF_IRQHandler:
1155  00ad 3b0002        	push	c_x+2
1156  00b0 be00          	ldw	x,c_x
1157  00b2 89            	pushw	x
1158  00b3 3b0002        	push	c_y+2
1159  00b6 be00          	ldw	x,c_y
1160  00b8 89            	pushw	x
1163                     ; 219 	t2ms++;
1165  00b9 3c00          	inc	_t2ms
1166                     ; 220 	if(t2ms > 4)
1168  00bb b600          	ld	a,_t2ms
1169  00bd a105          	cp	a,#5
1170  00bf 2507          	jrult	L744
1171                     ; 222 		t2ms = 0;
1173  00c1 3f00          	clr	_t2ms
1174                     ; 223 		t10ms++;
1176  00c3 3c01          	inc	_t10ms
1177                     ; 224 		key_service();
1179  00c5 cd0000        	call	_key_service
1181  00c8               L744:
1182                     ; 226 	TIM4->SR1 = (uint8_t)~0x01;
1184  00c8 35fe5344      	mov	21316,#254
1185                     ; 227 }
1188  00cc 85            	popw	x
1189  00cd bf00          	ldw	c_y,x
1190  00cf 320002        	pop	c_y+2
1191  00d2 85            	popw	x
1192  00d3 bf00          	ldw	c_x,x
1193  00d5 320002        	pop	c_x+2
1194  00d8 80            	iret
1217                     ; 228 INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
1217                     ; 229 {
1218                     	switch	.text
1219  00d9               f_EEPROM_EEC_IRQHandler:
1223                     ; 230 }
1226  00d9 80            	iret
1267                     	xdef	_t1s_loop
1268                     	xdef	f_TIM3_CAP_COM_IRQHandler
1269                     	xdef	f_TIM3_UPD_OVF_BRK_IRQHandler
1270                     	xdef	_t1s
1271                     	xdef	_t10ms
1272                     	xdef	_t2ms
1273                     	xref	_key_service
1274                     	xdef	f_EEPROM_EEC_IRQHandler
1275                     	xdef	f_TIM4_UPD_OVF_IRQHandler
1276                     	xdef	f_ADC1_IRQHandler
1277                     	xdef	f_I2C_IRQHandler
1278                     	xdef	f_UART1_RX_IRQHandler
1279                     	xdef	f_UART1_TX_IRQHandler
1280                     	xdef	f_TIM2_CAP_COM_IRQHandler
1281                     	xdef	f_TIM2_UPD_OVF_BRK_IRQHandler
1282                     	xdef	f_TIM1_UPD_OVF_TRG_BRK_IRQHandler
1283                     	xdef	f_TIM1_CAP_COM_IRQHandler
1284                     	xdef	f_SPI_IRQHandler
1285                     	xdef	f_EXTI_PORTE_IRQHandler
1286                     	xdef	f_EXTI_PORTD_IRQHandler
1287                     	xdef	f_EXTI_PORTC_IRQHandler
1288                     	xdef	f_EXTI_PORTB_IRQHandler
1289                     	xdef	f_EXTI_PORTA_IRQHandler
1290                     	xdef	f_CLK_IRQHandler
1291                     	xdef	f_AWU_IRQHandler
1292                     	xdef	f_TLI_IRQHandler
1293                     	xdef	f_TRAP_IRQHandler
1294                     	xdef	f_NonHandledInterrupt
1295                     	xref	_assert_failed
1296                     	xdef	_TIM2_GetITStatus
1297                     	xdef	_TIM2_GetCounter
1298                     	xdef	_TIM2_SetCompare1
1299                     	xdef	_TIM2_SetCounter
1300                     .const:	section	.text
1301  0000               L141:
1302  0000 2e2e5c736f75  	dc.b	"..\source\hal\stm8"
1303  0012 735f69742e63  	dc.b	"s_it.c",0
1304                     	xref.b	c_x
1305                     	xref.b	c_y
1325                     	end
