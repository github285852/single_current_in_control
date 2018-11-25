   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  55                     ; 4 void _delay_us(u16 n)
  55                     ; 5 {
  57                     	switch	.text
  58  0000               __delay_us:
  60  0000 89            	pushw	x
  61       00000000      OFST:	set	0
  64  0001               L13:
  65                     ; 6 	while(n--)
  67  0001 1e01          	ldw	x,(OFST+1,sp)
  68  0003 1d0001        	subw	x,#1
  69  0006 1f01          	ldw	(OFST+1,sp),x
  70  0008 1c0001        	addw	x,#1
  71  000b a30000        	cpw	x,#0
  72  000e 26f1          	jrne	L13
  73                     ; 9 }
  76  0010 85            	popw	x
  77  0011 81            	ret
 120                     ; 10 void _delay_10us(u16 n)
 120                     ; 11 {
 121                     	switch	.text
 122  0012               __delay_10us:
 124  0012 89            	pushw	x
 125  0013 89            	pushw	x
 126       00000002      OFST:	set	2
 129  0014 2011          	jra	L16
 130  0016               L75:
 131                     ; 15 		for(i=0;i<10;i++)
 133  0016 5f            	clrw	x
 134  0017 1f01          	ldw	(OFST-1,sp),x
 135  0019               L56:
 138  0019 1e01          	ldw	x,(OFST-1,sp)
 139  001b 1c0001        	addw	x,#1
 140  001e 1f01          	ldw	(OFST-1,sp),x
 143  0020 1e01          	ldw	x,(OFST-1,sp)
 144  0022 a3000a        	cpw	x,#10
 145  0025 25f2          	jrult	L56
 146  0027               L16:
 147                     ; 13 	while(n--)
 149  0027 1e03          	ldw	x,(OFST+1,sp)
 150  0029 1d0001        	subw	x,#1
 151  002c 1f03          	ldw	(OFST+1,sp),x
 152  002e 1c0001        	addw	x,#1
 153  0031 a30000        	cpw	x,#0
 154  0034 26e0          	jrne	L75
 155                     ; 19 }
 158  0036 5b04          	addw	sp,#4
 159  0038 81            	ret
 202                     ; 20 void _delay_ms(u16 n)
 202                     ; 21 {
 203                     	switch	.text
 204  0039               __delay_ms:
 206  0039 89            	pushw	x
 207  003a 89            	pushw	x
 208       00000002      OFST:	set	2
 211  003b 2015          	jra	L711
 212  003d               L511:
 213                     ; 25 		IWDG->KR = 0xaa;
 215  003d 35aa50e0      	mov	20704,#170
 216                     ; 26 		for(i=0;i<1120;i++)
 218  0041 5f            	clrw	x
 219  0042 1f01          	ldw	(OFST-1,sp),x
 220  0044               L321:
 223  0044 1e01          	ldw	x,(OFST-1,sp)
 224  0046 1c0001        	addw	x,#1
 225  0049 1f01          	ldw	(OFST-1,sp),x
 228  004b 1e01          	ldw	x,(OFST-1,sp)
 229  004d a30460        	cpw	x,#1120
 230  0050 25f2          	jrult	L321
 231  0052               L711:
 232                     ; 23 	while(n--)
 234  0052 1e03          	ldw	x,(OFST+1,sp)
 235  0054 1d0001        	subw	x,#1
 236  0057 1f03          	ldw	(OFST+1,sp),x
 237  0059 1c0001        	addw	x,#1
 238  005c a30000        	cpw	x,#0
 239  005f 26dc          	jrne	L511
 240                     ; 30 }
 243  0061 5b04          	addw	sp,#4
 244  0063 81            	ret
 257                     	xdef	__delay_ms
 258                     	xdef	__delay_10us
 259                     	xdef	__delay_us
 278                     	end
