   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 50 uint8_t ITC_GetCPUCC(void)
  44                     ; 51 {
  46                     	switch	.text
  47  0000               _ITC_GetCPUCC:
  51                     ; 53   _asm("push cc");
  54  0000 8a            push cc
  56                     ; 54   _asm("pop a");
  59  0001 84            pop a
  61                     ; 55   return; /* Ignore compiler warning, the returned value is in A register */
  64  0002 81            	ret
  87                     ; 80 void ITC_DeInit(void)
  87                     ; 81 {
  88                     	switch	.text
  89  0003               _ITC_DeInit:
  93                     ; 82   ITC->ISPR1 = ITC_SPRX_RESET_VALUE;
  95  0003 35ff7f70      	mov	32624,#255
  96                     ; 83   ITC->ISPR2 = ITC_SPRX_RESET_VALUE;
  98  0007 35ff7f71      	mov	32625,#255
  99                     ; 84   ITC->ISPR3 = ITC_SPRX_RESET_VALUE;
 101  000b 35ff7f72      	mov	32626,#255
 102                     ; 85   ITC->ISPR4 = ITC_SPRX_RESET_VALUE;
 104  000f 35ff7f73      	mov	32627,#255
 105                     ; 86   ITC->ISPR5 = ITC_SPRX_RESET_VALUE;
 107  0013 35ff7f74      	mov	32628,#255
 108                     ; 87   ITC->ISPR6 = ITC_SPRX_RESET_VALUE;
 110  0017 35ff7f75      	mov	32629,#255
 111                     ; 88   ITC->ISPR7 = ITC_SPRX_RESET_VALUE;
 113  001b 35ff7f76      	mov	32630,#255
 114                     ; 89   ITC->ISPR8 = ITC_SPRX_RESET_VALUE;
 116  001f 35ff7f77      	mov	32631,#255
 117                     ; 90 }
 120  0023 81            	ret
 145                     ; 97 uint8_t ITC_GetSoftIntStatus(void)
 145                     ; 98 {
 146                     	switch	.text
 147  0024               _ITC_GetSoftIntStatus:
 151                     ; 99   return (uint8_t)(ITC_GetCPUCC() & CPU_CC_I1I0);
 153  0024 adda          	call	_ITC_GetCPUCC
 155  0026 a428          	and	a,#40
 158  0028 81            	ret
 408                     .const:	section	.text
 409  0000               L62:
 410  0000 0065          	dc.w	L14
 411  0002 0065          	dc.w	L14
 412  0004 0065          	dc.w	L14
 413  0006 0065          	dc.w	L14
 414  0008 006e          	dc.w	L34
 415  000a 006e          	dc.w	L34
 416  000c 006e          	dc.w	L34
 417  000e 006e          	dc.w	L34
 418  0010 00a2          	dc.w	L502
 419  0012 00a2          	dc.w	L502
 420  0014 0077          	dc.w	L54
 421  0016 0077          	dc.w	L54
 422  0018 0080          	dc.w	L74
 423  001a 0080          	dc.w	L74
 424  001c 0080          	dc.w	L74
 425  001e 0080          	dc.w	L74
 426  0020 0089          	dc.w	L15
 427  0022 0089          	dc.w	L15
 428  0024 0089          	dc.w	L15
 429  0026 0089          	dc.w	L15
 430  0028 00a2          	dc.w	L502
 431  002a 00a2          	dc.w	L502
 432  002c 0092          	dc.w	L35
 433  002e 0092          	dc.w	L35
 434  0030 009b          	dc.w	L55
 435                     ; 107 ITC_PriorityLevel_TypeDef ITC_GetSoftwarePriority(ITC_Irq_TypeDef IrqNum)
 435                     ; 108 {
 436                     	switch	.text
 437  0029               _ITC_GetSoftwarePriority:
 439  0029 88            	push	a
 440  002a 89            	pushw	x
 441       00000002      OFST:	set	2
 444                     ; 109   uint8_t Value = 0;
 446  002b 0f02          	clr	(OFST+0,sp)
 447                     ; 110   uint8_t Mask = 0;
 449                     ; 113   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 451  002d a119          	cp	a,#25
 452  002f 2403          	jruge	L41
 453  0031 4f            	clr	a
 454  0032 2010          	jra	L61
 455  0034               L41:
 456  0034 ae0071        	ldw	x,#113
 457  0037 89            	pushw	x
 458  0038 ae0000        	ldw	x,#0
 459  003b 89            	pushw	x
 460  003c ae0064        	ldw	x,#L102
 461  003f cd0000        	call	_assert_failed
 463  0042 5b04          	addw	sp,#4
 464  0044               L61:
 465                     ; 116   Mask = (uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U));
 467  0044 7b03          	ld	a,(OFST+1,sp)
 468  0046 a403          	and	a,#3
 469  0048 48            	sll	a
 470  0049 5f            	clrw	x
 471  004a 97            	ld	xl,a
 472  004b a603          	ld	a,#3
 473  004d 5d            	tnzw	x
 474  004e 2704          	jreq	L02
 475  0050               L22:
 476  0050 48            	sll	a
 477  0051 5a            	decw	x
 478  0052 26fc          	jrne	L22
 479  0054               L02:
 480  0054 6b01          	ld	(OFST-1,sp),a
 481                     ; 118   switch (IrqNum)
 483  0056 7b03          	ld	a,(OFST+1,sp)
 485                     ; 198   default:
 485                     ; 199     break;
 486  0058 a119          	cp	a,#25
 487  005a 2407          	jruge	L42
 488  005c 5f            	clrw	x
 489  005d 97            	ld	xl,a
 490  005e 58            	sllw	x
 491  005f de0000        	ldw	x,(L62,x)
 492  0062 fc            	jp	(x)
 493  0063               L42:
 494  0063 203d          	jra	L502
 495  0065               L14:
 496                     ; 120   case ITC_IRQ_TLI: /* TLI software priority can be read but has no meaning */
 496                     ; 121   case ITC_IRQ_AWU:
 496                     ; 122   case ITC_IRQ_CLK:
 496                     ; 123   case ITC_IRQ_PORTA:
 496                     ; 124     Value = (uint8_t)(ITC->ISPR1 & Mask); /* Read software priority */
 498  0065 c67f70        	ld	a,32624
 499  0068 1401          	and	a,(OFST-1,sp)
 500  006a 6b02          	ld	(OFST+0,sp),a
 501                     ; 125     break;
 503  006c 2034          	jra	L502
 504  006e               L34:
 505                     ; 127   case ITC_IRQ_PORTB:
 505                     ; 128   case ITC_IRQ_PORTC:
 505                     ; 129   case ITC_IRQ_PORTD:
 505                     ; 130   case ITC_IRQ_PORTE:
 505                     ; 131     Value = (uint8_t)(ITC->ISPR2 & Mask); /* Read software priority */
 507  006e c67f71        	ld	a,32625
 508  0071 1401          	and	a,(OFST-1,sp)
 509  0073 6b02          	ld	(OFST+0,sp),a
 510                     ; 132     break;
 512  0075 202b          	jra	L502
 513  0077               L54:
 514                     ; 141   case ITC_IRQ_SPI:
 514                     ; 142   case ITC_IRQ_TIM1_OVF:
 514                     ; 143     Value = (uint8_t)(ITC->ISPR3 & Mask); /* Read software priority */
 516  0077 c67f72        	ld	a,32626
 517  007a 1401          	and	a,(OFST-1,sp)
 518  007c 6b02          	ld	(OFST+0,sp),a
 519                     ; 144     break;
 521  007e 2022          	jra	L502
 522  0080               L74:
 523                     ; 146   case ITC_IRQ_TIM1_CAPCOM:
 523                     ; 147 #if defined (STM8S903) || defined (STM8AF622x)
 523                     ; 148   case ITC_IRQ_TIM5_OVFTRI:
 523                     ; 149   case ITC_IRQ_TIM5_CAPCOM:
 523                     ; 150 #else
 523                     ; 151   case ITC_IRQ_TIM2_OVF:
 523                     ; 152   case ITC_IRQ_TIM2_CAPCOM:
 523                     ; 153 #endif /* STM8S903 or STM8AF622x*/
 523                     ; 154   case ITC_IRQ_TIM3_OVF:
 523                     ; 155     Value = (uint8_t)(ITC->ISPR4 & Mask); /* Read software priority */
 525  0080 c67f73        	ld	a,32627
 526  0083 1401          	and	a,(OFST-1,sp)
 527  0085 6b02          	ld	(OFST+0,sp),a
 528                     ; 156     break;
 530  0087 2019          	jra	L502
 531  0089               L15:
 532                     ; 158   case ITC_IRQ_TIM3_CAPCOM:
 532                     ; 159 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 532                     ; 160     defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 532                     ; 161   case ITC_IRQ_UART1_TX:
 532                     ; 162   case ITC_IRQ_UART1_RX:
 532                     ; 163 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 532                     ; 164 #if defined(STM8AF622x)
 532                     ; 165   case ITC_IRQ_UART4_TX:
 532                     ; 166   case ITC_IRQ_UART4_RX:
 532                     ; 167 #endif /*STM8AF622x */
 532                     ; 168   case ITC_IRQ_I2C:
 532                     ; 169     Value = (uint8_t)(ITC->ISPR5 & Mask); /* Read software priority */
 534  0089 c67f74        	ld	a,32628
 535  008c 1401          	and	a,(OFST-1,sp)
 536  008e 6b02          	ld	(OFST+0,sp),a
 537                     ; 170     break;
 539  0090 2010          	jra	L502
 540  0092               L35:
 541                     ; 184   case ITC_IRQ_ADC1:
 541                     ; 185 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S903 or STM8AF626x or STM8AF622x */
 541                     ; 186 #if defined (STM8S903) || defined (STM8AF622x)
 541                     ; 187   case ITC_IRQ_TIM6_OVFTRI:
 541                     ; 188 #else
 541                     ; 189   case ITC_IRQ_TIM4_OVF:
 541                     ; 190 #endif /*STM8S903 or STM8AF622x */
 541                     ; 191     Value = (uint8_t)(ITC->ISPR6 & Mask); /* Read software priority */
 543  0092 c67f75        	ld	a,32629
 544  0095 1401          	and	a,(OFST-1,sp)
 545  0097 6b02          	ld	(OFST+0,sp),a
 546                     ; 192     break;
 548  0099 2007          	jra	L502
 549  009b               L55:
 550                     ; 194   case ITC_IRQ_EEPROM_EEC:
 550                     ; 195     Value = (uint8_t)(ITC->ISPR7 & Mask); /* Read software priority */
 552  009b c67f76        	ld	a,32630
 553  009e 1401          	and	a,(OFST-1,sp)
 554  00a0 6b02          	ld	(OFST+0,sp),a
 555                     ; 196     break;
 557  00a2               L75:
 558                     ; 198   default:
 558                     ; 199     break;
 560  00a2               L502:
 561                     ; 202   Value >>= (uint8_t)(((uint8_t)IrqNum % 4u) * 2u);
 563  00a2 7b03          	ld	a,(OFST+1,sp)
 564  00a4 a403          	and	a,#3
 565  00a6 48            	sll	a
 566  00a7 5f            	clrw	x
 567  00a8 97            	ld	xl,a
 568  00a9 7b02          	ld	a,(OFST+0,sp)
 569  00ab 5d            	tnzw	x
 570  00ac 2704          	jreq	L03
 571  00ae               L23:
 572  00ae 44            	srl	a
 573  00af 5a            	decw	x
 574  00b0 26fc          	jrne	L23
 575  00b2               L03:
 576  00b2 6b02          	ld	(OFST+0,sp),a
 577                     ; 204   return((ITC_PriorityLevel_TypeDef)Value);
 579  00b4 7b02          	ld	a,(OFST+0,sp)
 582  00b6 5b03          	addw	sp,#3
 583  00b8 81            	ret
 649                     	switch	.const
 650  0032               L66:
 651  0032 014a          	dc.w	L702
 652  0034 014a          	dc.w	L702
 653  0036 014a          	dc.w	L702
 654  0038 014a          	dc.w	L702
 655  003a 015c          	dc.w	L112
 656  003c 015c          	dc.w	L112
 657  003e 015c          	dc.w	L112
 658  0040 015c          	dc.w	L112
 659  0042 01c6          	dc.w	L362
 660  0044 01c6          	dc.w	L362
 661  0046 016e          	dc.w	L312
 662  0048 016e          	dc.w	L312
 663  004a 0180          	dc.w	L512
 664  004c 0180          	dc.w	L512
 665  004e 0180          	dc.w	L512
 666  0050 0180          	dc.w	L512
 667  0052 0192          	dc.w	L712
 668  0054 0192          	dc.w	L712
 669  0056 0192          	dc.w	L712
 670  0058 0192          	dc.w	L712
 671  005a 01c6          	dc.w	L362
 672  005c 01c6          	dc.w	L362
 673  005e 01a4          	dc.w	L122
 674  0060 01a4          	dc.w	L122
 675  0062 01b6          	dc.w	L322
 676                     ; 220 void ITC_SetSoftwarePriority(ITC_Irq_TypeDef IrqNum, ITC_PriorityLevel_TypeDef PriorityValue)
 676                     ; 221 {
 677                     	switch	.text
 678  00b9               _ITC_SetSoftwarePriority:
 680  00b9 89            	pushw	x
 681  00ba 89            	pushw	x
 682       00000002      OFST:	set	2
 685                     ; 222   uint8_t Mask = 0;
 687                     ; 223   uint8_t NewPriority = 0;
 689                     ; 226   assert_param(IS_ITC_IRQ_OK((uint8_t)IrqNum));
 691  00bb 9e            	ld	a,xh
 692  00bc a119          	cp	a,#25
 693  00be 2403          	jruge	L63
 694  00c0 4f            	clr	a
 695  00c1 2010          	jra	L04
 696  00c3               L63:
 697  00c3 ae00e2        	ldw	x,#226
 698  00c6 89            	pushw	x
 699  00c7 ae0000        	ldw	x,#0
 700  00ca 89            	pushw	x
 701  00cb ae0064        	ldw	x,#L102
 702  00ce cd0000        	call	_assert_failed
 704  00d1 5b04          	addw	sp,#4
 705  00d3               L04:
 706                     ; 227   assert_param(IS_ITC_PRIORITY_OK(PriorityValue));
 708  00d3 7b04          	ld	a,(OFST+2,sp)
 709  00d5 a102          	cp	a,#2
 710  00d7 2710          	jreq	L44
 711  00d9 7b04          	ld	a,(OFST+2,sp)
 712  00db a101          	cp	a,#1
 713  00dd 270a          	jreq	L44
 714  00df 0d04          	tnz	(OFST+2,sp)
 715  00e1 2706          	jreq	L44
 716  00e3 7b04          	ld	a,(OFST+2,sp)
 717  00e5 a103          	cp	a,#3
 718  00e7 2603          	jrne	L24
 719  00e9               L44:
 720  00e9 4f            	clr	a
 721  00ea 2010          	jra	L64
 722  00ec               L24:
 723  00ec ae00e3        	ldw	x,#227
 724  00ef 89            	pushw	x
 725  00f0 ae0000        	ldw	x,#0
 726  00f3 89            	pushw	x
 727  00f4 ae0064        	ldw	x,#L102
 728  00f7 cd0000        	call	_assert_failed
 730  00fa 5b04          	addw	sp,#4
 731  00fc               L64:
 732                     ; 230   assert_param(IS_ITC_INTERRUPTS_DISABLED);
 734  00fc cd0024        	call	_ITC_GetSoftIntStatus
 736  00ff a128          	cp	a,#40
 737  0101 2603          	jrne	L05
 738  0103 4f            	clr	a
 739  0104 2010          	jra	L25
 740  0106               L05:
 741  0106 ae00e6        	ldw	x,#230
 742  0109 89            	pushw	x
 743  010a ae0000        	ldw	x,#0
 744  010d 89            	pushw	x
 745  010e ae0064        	ldw	x,#L102
 746  0111 cd0000        	call	_assert_failed
 748  0114 5b04          	addw	sp,#4
 749  0116               L25:
 750                     ; 234   Mask = (uint8_t)(~(uint8_t)(0x03U << (((uint8_t)IrqNum % 4U) * 2U)));
 752  0116 7b03          	ld	a,(OFST+1,sp)
 753  0118 a403          	and	a,#3
 754  011a 48            	sll	a
 755  011b 5f            	clrw	x
 756  011c 97            	ld	xl,a
 757  011d a603          	ld	a,#3
 758  011f 5d            	tnzw	x
 759  0120 2704          	jreq	L45
 760  0122               L65:
 761  0122 48            	sll	a
 762  0123 5a            	decw	x
 763  0124 26fc          	jrne	L65
 764  0126               L45:
 765  0126 43            	cpl	a
 766  0127 6b01          	ld	(OFST-1,sp),a
 767                     ; 237   NewPriority = (uint8_t)((uint8_t)(PriorityValue) << (((uint8_t)IrqNum % 4U) * 2U));
 769  0129 7b03          	ld	a,(OFST+1,sp)
 770  012b a403          	and	a,#3
 771  012d 48            	sll	a
 772  012e 5f            	clrw	x
 773  012f 97            	ld	xl,a
 774  0130 7b04          	ld	a,(OFST+2,sp)
 775  0132 5d            	tnzw	x
 776  0133 2704          	jreq	L06
 777  0135               L26:
 778  0135 48            	sll	a
 779  0136 5a            	decw	x
 780  0137 26fc          	jrne	L26
 781  0139               L06:
 782  0139 6b02          	ld	(OFST+0,sp),a
 783                     ; 239   switch (IrqNum)
 785  013b 7b03          	ld	a,(OFST+1,sp)
 787                     ; 329   default:
 787                     ; 330     break;
 788  013d a119          	cp	a,#25
 789  013f 2407          	jruge	L46
 790  0141 5f            	clrw	x
 791  0142 97            	ld	xl,a
 792  0143 58            	sllw	x
 793  0144 de0032        	ldw	x,(L66,x)
 794  0147 fc            	jp	(x)
 795  0148               L46:
 796  0148 207c          	jra	L362
 797  014a               L702:
 798                     ; 241   case ITC_IRQ_TLI: /* TLI software priority can be written but has no meaning */
 798                     ; 242   case ITC_IRQ_AWU:
 798                     ; 243   case ITC_IRQ_CLK:
 798                     ; 244   case ITC_IRQ_PORTA:
 798                     ; 245     ITC->ISPR1 &= Mask;
 800  014a c67f70        	ld	a,32624
 801  014d 1401          	and	a,(OFST-1,sp)
 802  014f c77f70        	ld	32624,a
 803                     ; 246     ITC->ISPR1 |= NewPriority;
 805  0152 c67f70        	ld	a,32624
 806  0155 1a02          	or	a,(OFST+0,sp)
 807  0157 c77f70        	ld	32624,a
 808                     ; 247     break;
 810  015a 206a          	jra	L362
 811  015c               L112:
 812                     ; 249   case ITC_IRQ_PORTB:
 812                     ; 250   case ITC_IRQ_PORTC:
 812                     ; 251   case ITC_IRQ_PORTD:
 812                     ; 252   case ITC_IRQ_PORTE:
 812                     ; 253     ITC->ISPR2 &= Mask;
 814  015c c67f71        	ld	a,32625
 815  015f 1401          	and	a,(OFST-1,sp)
 816  0161 c77f71        	ld	32625,a
 817                     ; 254     ITC->ISPR2 |= NewPriority;
 819  0164 c67f71        	ld	a,32625
 820  0167 1a02          	or	a,(OFST+0,sp)
 821  0169 c77f71        	ld	32625,a
 822                     ; 255     break;
 824  016c 2058          	jra	L362
 825  016e               L312:
 826                     ; 264   case ITC_IRQ_SPI:
 826                     ; 265   case ITC_IRQ_TIM1_OVF:
 826                     ; 266     ITC->ISPR3 &= Mask;
 828  016e c67f72        	ld	a,32626
 829  0171 1401          	and	a,(OFST-1,sp)
 830  0173 c77f72        	ld	32626,a
 831                     ; 267     ITC->ISPR3 |= NewPriority;
 833  0176 c67f72        	ld	a,32626
 834  0179 1a02          	or	a,(OFST+0,sp)
 835  017b c77f72        	ld	32626,a
 836                     ; 268     break;
 838  017e 2046          	jra	L362
 839  0180               L512:
 840                     ; 270   case ITC_IRQ_TIM1_CAPCOM:
 840                     ; 271 #if defined(STM8S903) || defined(STM8AF622x) 
 840                     ; 272   case ITC_IRQ_TIM5_OVFTRI:
 840                     ; 273   case ITC_IRQ_TIM5_CAPCOM:
 840                     ; 274 #else
 840                     ; 275   case ITC_IRQ_TIM2_OVF:
 840                     ; 276   case ITC_IRQ_TIM2_CAPCOM:
 840                     ; 277 #endif /*STM8S903 or STM8AF622x */
 840                     ; 278   case ITC_IRQ_TIM3_OVF:
 840                     ; 279     ITC->ISPR4 &= Mask;
 842  0180 c67f73        	ld	a,32627
 843  0183 1401          	and	a,(OFST-1,sp)
 844  0185 c77f73        	ld	32627,a
 845                     ; 280     ITC->ISPR4 |= NewPriority;
 847  0188 c67f73        	ld	a,32627
 848  018b 1a02          	or	a,(OFST+0,sp)
 849  018d c77f73        	ld	32627,a
 850                     ; 281     break;
 852  0190 2034          	jra	L362
 853  0192               L712:
 854                     ; 283   case ITC_IRQ_TIM3_CAPCOM:
 854                     ; 284 #if defined(STM8S208) ||defined(STM8S207) || defined (STM8S007) || defined(STM8S103) || \
 854                     ; 285     defined(STM8S003) ||defined(STM8S903) || defined (STM8AF52Ax) || defined (STM8AF62Ax)
 854                     ; 286   case ITC_IRQ_UART1_TX:
 854                     ; 287   case ITC_IRQ_UART1_RX:
 854                     ; 288 #endif /*STM8S208 or STM8S207 or STM8S007 or STM8S103 or STM8S003 or STM8S903 or STM8AF52Ax or STM8AF62Ax */ 
 854                     ; 289 #if defined(STM8AF622x)
 854                     ; 290   case ITC_IRQ_UART4_TX:
 854                     ; 291   case ITC_IRQ_UART4_RX:
 854                     ; 292 #endif /*STM8AF622x */
 854                     ; 293   case ITC_IRQ_I2C:
 854                     ; 294     ITC->ISPR5 &= Mask;
 856  0192 c67f74        	ld	a,32628
 857  0195 1401          	and	a,(OFST-1,sp)
 858  0197 c77f74        	ld	32628,a
 859                     ; 295     ITC->ISPR5 |= NewPriority;
 861  019a c67f74        	ld	a,32628
 862  019d 1a02          	or	a,(OFST+0,sp)
 863  019f c77f74        	ld	32628,a
 864                     ; 296     break;
 866  01a2 2022          	jra	L362
 867  01a4               L122:
 868                     ; 312   case ITC_IRQ_ADC1:
 868                     ; 313 #endif /*STM8S105, STM8S005, STM8S103 or STM8S003 or STM8S903 or STM8AF626x or STM8AF622x */
 868                     ; 314     
 868                     ; 315 #if defined (STM8S903) || defined (STM8AF622x)
 868                     ; 316   case ITC_IRQ_TIM6_OVFTRI:
 868                     ; 317 #else
 868                     ; 318   case ITC_IRQ_TIM4_OVF:
 868                     ; 319 #endif /* STM8S903 or STM8AF622x */
 868                     ; 320     ITC->ISPR6 &= Mask;
 870  01a4 c67f75        	ld	a,32629
 871  01a7 1401          	and	a,(OFST-1,sp)
 872  01a9 c77f75        	ld	32629,a
 873                     ; 321     ITC->ISPR6 |= NewPriority;
 875  01ac c67f75        	ld	a,32629
 876  01af 1a02          	or	a,(OFST+0,sp)
 877  01b1 c77f75        	ld	32629,a
 878                     ; 322     break;
 880  01b4 2010          	jra	L362
 881  01b6               L322:
 882                     ; 324   case ITC_IRQ_EEPROM_EEC:
 882                     ; 325     ITC->ISPR7 &= Mask;
 884  01b6 c67f76        	ld	a,32630
 885  01b9 1401          	and	a,(OFST-1,sp)
 886  01bb c77f76        	ld	32630,a
 887                     ; 326     ITC->ISPR7 |= NewPriority;
 889  01be c67f76        	ld	a,32630
 890  01c1 1a02          	or	a,(OFST+0,sp)
 891  01c3 c77f76        	ld	32630,a
 892                     ; 327     break;
 894  01c6               L522:
 895                     ; 329   default:
 895                     ; 330     break;
 897  01c6               L362:
 898                     ; 332 }
 901  01c6 5b04          	addw	sp,#4
 902  01c8 81            	ret
 915                     	xdef	_ITC_GetSoftwarePriority
 916                     	xdef	_ITC_SetSoftwarePriority
 917                     	xdef	_ITC_GetSoftIntStatus
 918                     	xdef	_ITC_DeInit
 919                     	xdef	_ITC_GetCPUCC
 920                     	xref	_assert_failed
 921                     	switch	.const
 922  0064               L102:
 923  0064 2e2e5c736f75  	dc.b	"..\source\stm8s_st"
 924  0076 647065726970  	dc.b	"dperiph_driver\src"
 925  0088 5c73746d3873  	dc.b	"\stm8s_itc.c",0
 945                     	end
