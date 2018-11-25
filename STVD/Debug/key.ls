   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  16                     	bsct
  17  0000               _key_press_time:
  18  0000 0000          	dc.w	0
  19  0002               _key_push_lock:
  20  0002 00            	dc.b	0
  21  0003               _key_change:
  22  0003 00            	dc.b	0
  23  0004               L3_key_release_time:
  24  0004 00            	dc.b	0
  25  0005               L5_key_click:
  26  0005 00            	dc.b	0
  27  0006               L7_Continue:
  28  0006 00            	dc.b	0
 116                     ; 8 void key_service(void)
 116                     ; 9 {
 118                     	switch	.text
 119  0000               _key_service:
 121  0000 5203          	subw	sp,#3
 122       00000003      OFST:	set	3
 125                     ; 13 	unsigned char ReadData=0;
 127  0002 0f03          	clr	(OFST+0,sp)
 128                     ; 16 	if(!(KEY_DEC_GPIO->IDR & KEY_DEC_PIN))
 130  0004 c65010        	ld	a,20496
 131  0007 a508          	bcp	a,#8
 132  0009 2606          	jrne	L16
 133                     ; 18 		ReadData |= 0x01;
 135  000b 7b03          	ld	a,(OFST+0,sp)
 136  000d aa01          	or	a,#1
 137  000f 6b03          	ld	(OFST+0,sp),a
 138  0011               L16:
 139                     ; 20 	if(!(KEY_SET_GPIO->IDR & KEY_SET_PIN))
 141  0011 c65010        	ld	a,20496
 142  0014 a510          	bcp	a,#16
 143  0016 2606          	jrne	L36
 144                     ; 22 		ReadData |= 0x02;
 146  0018 7b03          	ld	a,(OFST+0,sp)
 147  001a aa02          	or	a,#2
 148  001c 6b03          	ld	(OFST+0,sp),a
 149  001e               L36:
 150                     ; 24 	if(!(KEY_INC_GPIO->IDR & KEY_INC_PIN))
 152  001e c6500b        	ld	a,20491
 153  0021 a580          	bcp	a,#128
 154  0023 2606          	jrne	L56
 155                     ; 26 		ReadData |= 0x04;
 157  0025 7b03          	ld	a,(OFST+0,sp)
 158  0027 aa04          	or	a,#4
 159  0029 6b03          	ld	(OFST+0,sp),a
 160  002b               L56:
 161                     ; 29 	Trigger  = (uint8_t)(ReadData & (ReadData ^ Continue));
 163  002b 7b03          	ld	a,(OFST+0,sp)
 164  002d b806          	xor	a,L7_Continue
 165  002f 1403          	and	a,(OFST+0,sp)
 166  0031 6b02          	ld	(OFST-1,sp),a
 167                     ; 30 	Release  = (uint8_t)(ReadData ^ Trigger ^ Continue);
 169  0033 7b03          	ld	a,(OFST+0,sp)
 170  0035 1802          	xor	a,(OFST-1,sp)
 171  0037 b806          	xor	a,L7_Continue
 172  0039 6b01          	ld	(OFST-2,sp),a
 173                     ; 31 	Continue = ReadData;
 175  003b 7b03          	ld	a,(OFST+0,sp)
 176  003d b706          	ld	L7_Continue,a
 177                     ; 32 	if (Trigger) key_press_time = 0; //在释放时清零
 179  003f 0d02          	tnz	(OFST-1,sp)
 180  0041 2703          	jreq	L76
 183  0043 5f            	clrw	x
 184  0044 bf00          	ldw	_key_press_time,x
 185  0046               L76:
 186                     ; 33 	if (Continue)
 188  0046 3d06          	tnz	L7_Continue
 189  0048 2717          	jreq	L17
 190                     ; 35 		key_value = ReadData;
 192  004a 7b03          	ld	a,(OFST+0,sp)
 193  004c b700          	ld	_key_value,a
 194                     ; 36 		if (key_press_time++ > press_time_min)//长按按下大5s
 196  004e be00          	ldw	x,_key_press_time
 197  0050 1c0001        	addw	x,#1
 198  0053 bf00          	ldw	_key_press_time,x
 199  0055 1d0001        	subw	x,#1
 200  0058 a301f5        	cpw	x,#501
 201  005b 2504          	jrult	L17
 202                     ; 38 		    key_status = 254; //长按操作正在按下
 204  005d 35fe0001      	mov	_key_status,#254
 205  0061               L17:
 206                     ; 41 	if (Release)//按键抬起
 208  0061 0d01          	tnz	(OFST-2,sp)
 209  0063 2731          	jreq	L57
 210                     ; 43 		if ((key_press_time > click_time_min) && (key_press_time <= click_time_max)) // 短按操作, 按下时间介于30ms到500ms
 212  0065 be00          	ldw	x,_key_press_time
 213  0067 a30003        	cpw	x,#3
 214  006a 250b          	jrult	L77
 216  006c be00          	ldw	x,_key_press_time
 217  006e a30033        	cpw	x,#51
 218  0071 2404          	jruge	L77
 219                     ; 45 	    key_click++;
 221  0073 3c05          	inc	L5_key_click
 223  0075 201d          	jra	L101
 224  0077               L77:
 225                     ; 47 		else if ((key_press_time > click_time_max) && (key_press_time <= press_time_min)) //按下时间在0.5---5s
 227  0077 be00          	ldw	x,_key_press_time
 228  0079 a30033        	cpw	x,#51
 229  007c 250b          	jrult	L301
 231  007e be00          	ldw	x,_key_press_time
 232  0080 a301f5        	cpw	x,#501
 233  0083 2404          	jruge	L301
 234                     ; 49 	    key_click = 0;
 236  0085 3f05          	clr	L5_key_click
 238  0087 200b          	jra	L101
 239  0089               L301:
 240                     ; 51 		else if (key_press_time > press_time_min) //长按按下大5s
 242  0089 be00          	ldw	x,_key_press_time
 243  008b a301f5        	cpw	x,#501
 244  008e 2504          	jrult	L101
 245                     ; 53 	    key_status = 255;//长按操作已经抬起
 247  0090 35ff0001      	mov	_key_status,#255
 248  0094               L101:
 249                     ; 55 		key_release_time = 0;
 251  0094 3f04          	clr	L3_key_release_time
 252  0096               L57:
 253                     ; 57 	if (key_release_time++ > click_time_max)//按键抬起时间大于0.5s
 255  0096 b604          	ld	a,L3_key_release_time
 256  0098 3c04          	inc	L3_key_release_time
 257  009a a133          	cp	a,#51
 258  009c 2509          	jrult	L111
 259                     ; 59 		if (key_click)
 261  009e 3d05          	tnz	L5_key_click
 262  00a0 2705          	jreq	L111
 263                     ; 61 	    key_status = key_click;
 265  00a2 450501        	mov	_key_status,L5_key_click
 266                     ; 62 	    key_click = 0;
 268  00a5 3f05          	clr	L5_key_click
 269  00a7               L111:
 270                     ; 65 }
 273  00a7 5b03          	addw	sp,#3
 274  00a9 81            	ret
 334                     	xdef	_key_change
 335                     	xdef	_key_push_lock
 336                     	switch	.ubsct
 337  0000               _key_value:
 338  0000 00            	ds.b	1
 339                     	xdef	_key_value
 340                     	xdef	_key_press_time
 341  0001               _key_status:
 342  0001 00            	ds.b	1
 343                     	xdef	_key_status
 344                     	xdef	_key_service
 364                     	end
