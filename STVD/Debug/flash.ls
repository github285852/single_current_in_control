   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  83                     .const:	section	.text
  84  0000               L6:
  85  0000 00004000      	dc.l	16384
  86                     ; 4 void eeprom_write_nbyte(unsigned long addr,unsigned char * buf,unsigned int len)
  86                     ; 5 {
  87                     	scross	off
  88                     	switch	.text
  89  0000               _eeprom_write_nbyte:
  91  0000 5206          	subw	sp,#6
  92       00000006      OFST:	set	6
  95                     ; 7 	FLASH->DUKR = 0xAE; /* Warning: keys are reversed on data memory !!! */
  97  0002 35ae5064      	mov	20580,#174
  98                     ; 9   while (FLASH->IAPSR & FLASH_FLAG_DUL == RESET);
 101  0006 35565064      	mov	20580,#86
 102                     ; 10 	for(i=0;i<len;i++)
 104  000a 5f            	clrw	x
 105  000b 1f05          	ldw	(OFST-1,sp),x
 107  000d 2035          	jra	L74
 108  000f               L34:
 109                     ; 13 		while (FLASH->IAPSR & FLASH_FLAG_EOP == RESET);
 112  000f 1e05          	ldw	x,(OFST-1,sp)
 113  0011 cd0000        	call	c_uitolx
 115  0014 96            	ldw	x,sp
 116  0015 1c0001        	addw	x,#OFST-5
 117  0018 cd0000        	call	c_rtol
 119  001b 96            	ldw	x,sp
 120  001c 1c0009        	addw	x,#OFST+3
 121  001f cd0000        	call	c_ltor
 123  0022 ae0000        	ldw	x,#L6
 124  0025 cd0000        	call	c_ladd
 126  0028 96            	ldw	x,sp
 127  0029 1c0001        	addw	x,#OFST-5
 128  002c cd0000        	call	c_ladd
 130  002f be02          	ldw	x,c_lreg+2
 131  0031 160d          	ldw	y,(OFST+7,sp)
 132  0033 72f905        	addw	y,(OFST-1,sp)
 133  0036 90f6          	ld	a,(y)
 134  0038 f7            	ld	(x),a
 135                     ; 14 		IWDG->KR = 0xaa;
 137  0039 35aa50e0      	mov	20704,#170
 138                     ; 10 	for(i=0;i<len;i++)
 140  003d 1e05          	ldw	x,(OFST-1,sp)
 141  003f 1c0001        	addw	x,#1
 142  0042 1f05          	ldw	(OFST-1,sp),x
 143  0044               L74:
 146  0044 1e05          	ldw	x,(OFST-1,sp)
 147  0046 130f          	cpw	x,(OFST+9,sp)
 148  0048 25c5          	jrult	L34
 149                     ; 16 	FLASH->IAPSR &= 0xF7;
 151  004a 7217505f      	bres	20575,#3
 152                     ; 17 }
 155  004e 5b06          	addw	sp,#6
 156  0050 81            	ret
 218                     ; 18 void eeprom_read_nbyte(unsigned long addr,unsigned char * buf, unsigned int len)
 218                     ; 19 {
 219                     	switch	.text
 220  0051               _eeprom_read_nbyte:
 222  0051 5206          	subw	sp,#6
 223       00000006      OFST:	set	6
 226                     ; 21 	for(i=0;i<len;i++)
 228  0053 5f            	clrw	x
 229  0054 1f05          	ldw	(OFST-1,sp),x
 231  0056 2030          	jra	L111
 232  0058               L501:
 233                     ; 23 		buf[i] = *(PointerAttr uint8_t *) (MemoryAddressCast)(FLASH_DATA_START_PHYSICAL_ADDRESS + addr + i);
 235  0058 1e05          	ldw	x,(OFST-1,sp)
 236  005a cd0000        	call	c_uitolx
 238  005d 96            	ldw	x,sp
 239  005e 1c0001        	addw	x,#OFST-5
 240  0061 cd0000        	call	c_rtol
 242  0064 96            	ldw	x,sp
 243  0065 1c0009        	addw	x,#OFST+3
 244  0068 cd0000        	call	c_ltor
 246  006b ae0000        	ldw	x,#L6
 247  006e cd0000        	call	c_ladd
 249  0071 96            	ldw	x,sp
 250  0072 1c0001        	addw	x,#OFST-5
 251  0075 cd0000        	call	c_ladd
 253  0078 be02          	ldw	x,c_lreg+2
 254  007a f6            	ld	a,(x)
 255  007b 1e0d          	ldw	x,(OFST+7,sp)
 256  007d 72fb05        	addw	x,(OFST-1,sp)
 257  0080 f7            	ld	(x),a
 258                     ; 21 	for(i=0;i<len;i++)
 260  0081 1e05          	ldw	x,(OFST-1,sp)
 261  0083 1c0001        	addw	x,#1
 262  0086 1f05          	ldw	(OFST-1,sp),x
 263  0088               L111:
 266  0088 1e05          	ldw	x,(OFST-1,sp)
 267  008a 130f          	cpw	x,(OFST+9,sp)
 268  008c 25ca          	jrult	L501
 269                     ; 25 }
 272  008e 5b06          	addw	sp,#6
 273  0090 81            	ret
 298                     ; 26 void config_ram2flash(void)
 298                     ; 27 {
 299                     	switch	.text
 300  0091               _config_ram2flash:
 304                     ; 28 	eeprom_write_nbyte(ConfigAddr,(unsigned char *) &Sys.Config, sizeof (Sys.Config));
 306  0091 ae0021        	ldw	x,#33
 307  0094 89            	pushw	x
 308  0095 ae0006        	ldw	x,#_Sys+6
 309  0098 89            	pushw	x
 310  0099 ae0000        	ldw	x,#0
 311  009c 89            	pushw	x
 312  009d ae0000        	ldw	x,#0
 313  00a0 89            	pushw	x
 314  00a1 cd0000        	call	_eeprom_write_nbyte
 316  00a4 5b08          	addw	sp,#8
 317                     ; 29 }
 320  00a6 81            	ret
 345                     ; 30 void config_flash2ram(void)
 345                     ; 31 {
 346                     	switch	.text
 347  00a7               _config_flash2ram:
 351                     ; 32 	eeprom_read_nbyte(ConfigAddr, (unsigned char *) &Sys.Config, sizeof (Sys.Config));
 353  00a7 ae0021        	ldw	x,#33
 354  00aa 89            	pushw	x
 355  00ab ae0006        	ldw	x,#_Sys+6
 356  00ae 89            	pushw	x
 357  00af ae0000        	ldw	x,#0
 358  00b2 89            	pushw	x
 359  00b3 ae0000        	ldw	x,#0
 360  00b6 89            	pushw	x
 361  00b7 ad98          	call	_eeprom_read_nbyte
 363  00b9 5b08          	addw	sp,#8
 364                     ; 33 }
 367  00bb 81            	ret
 380                     	xref.b	_Sys
 381                     	xdef	_config_flash2ram
 382                     	xdef	_config_ram2flash
 383                     	xdef	_eeprom_read_nbyte
 384                     	xdef	_eeprom_write_nbyte
 385                     	xref.b	c_lreg
 404                     	xref	c_rtol
 405                     	xref	c_uitolx
 406                     	xref	c_ladd
 407                     	xref	c_ltor
 408                     	end
