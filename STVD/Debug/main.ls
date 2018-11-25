   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  45                     ; 7 void ALL_GpioInit(void)
  45                     ; 8 {
  47                     	switch	.text
  48  0000               _ALL_GpioInit:
  52                     ; 10 	GPIO_Init(KEY_SET_GPIO,KEY_SET_PIN,GPIO_MODE_IN_PU_NO_IT);
  54  0000 4b40          	push	#64
  55  0002 4b10          	push	#16
  56  0004 ae500f        	ldw	x,#20495
  57  0007 cd0000        	call	_GPIO_Init
  59  000a 85            	popw	x
  60                     ; 11 	GPIO_Init(KEY_DEC_GPIO,KEY_DEC_PIN,GPIO_MODE_IN_PU_NO_IT);
  62  000b 4b40          	push	#64
  63  000d 4b08          	push	#8
  64  000f ae500f        	ldw	x,#20495
  65  0012 cd0000        	call	_GPIO_Init
  67  0015 85            	popw	x
  68                     ; 12 	GPIO_Init(KEY_INC_GPIO,KEY_INC_PIN,GPIO_MODE_IN_PU_NO_IT);
  70  0016 4b40          	push	#64
  71  0018 4b80          	push	#128
  72  001a ae500a        	ldw	x,#20490
  73  001d cd0000        	call	_GPIO_Init
  75  0020 85            	popw	x
  76                     ; 16 }
  79  0021 81            	ret
 102                     ; 18 void IWDG_Config(void)
 102                     ; 19 {
 103                     	switch	.text
 104  0022               _IWDG_Config:
 108                     ; 20 	IWDG->KR = 0xCC;
 110  0022 35cc50e0      	mov	20704,#204
 111                     ; 21 	IWDG->KR = 0x55;
 113  0026 355550e0      	mov	20704,#85
 114                     ; 22 	IWDG->PR = 0x06;
 116  002a 350650e1      	mov	20705,#6
 117                     ; 23 	IWDG->RLR= 0xff;
 119  002e 35ff50e2      	mov	20706,#255
 120                     ; 24 	IWDG->KR = 0xAA;
 122  0032 35aa50e0      	mov	20704,#170
 123                     ; 25 }
 126  0036 81            	ret
 149                     ; 28 void init_timer4(void)
 149                     ; 29 {
 150                     	switch	.text
 151  0037               _init_timer4:
 155                     ; 30 	TIM4->PSCR = 0x07;
 157  0037 35075347      	mov	21319,#7
 158                     ; 31   TIM4->ARR  = 250;// 2ms
 160  003b 35fa5348      	mov	21320,#250
 161                     ; 32 	TIM4->IER |= 0x01;
 163  003f 72105343      	bset	21315,#0
 164                     ; 33 	TIM4->CR1 |= 0x01;
 166  0043 72105340      	bset	21312,#0
 167                     ; 34 }
 170  0047 81            	ret
 199                     ; 39 main()
 199                     ; 40 {
 200                     	switch	.text
 201  0048               _main:
 205                     ; 41 	memset((u8*)&Sys,0,sizeof(SYS));
 207  0048 ae0035        	ldw	x,#53
 208  004b               L41:
 209  004b 6fff          	clr	(_Sys-1,x)
 210  004d 5a            	decw	x
 211  004e 26fb          	jrne	L41
 212                     ; 42 	config_flash2ram();
 214  0050 cd0000        	call	_config_flash2ram
 216                     ; 43 	ALL_GpioInit();
 218  0053 adab          	call	_ALL_GpioInit
 220                     ; 44 	init_timer4();
 222  0055 ade0          	call	_init_timer4
 224                     ; 49 	enableInterrupts();
 227  0057 9a            rim
 229  0058               L15:
 230                     ; 50 	while (1);
 232  0058 20fe          	jra	L15
 267                     ; 56 void assert_failed(u8* file, u32 line)  
 267                     ; 57 {  
 268                     	switch	.text
 269  005a               _assert_failed:
 273  005a               L37:
 274  005a 20fe          	jra	L37
 503                     	xdef	_main
 504                     	xdef	_init_timer4
 505                     	xdef	_IWDG_Config
 506                     	xdef	_ALL_GpioInit
 507                     	switch	.ubsct
 508  0000               _Sys:
 509  0000 000000000000  	ds.b	53
 510                     	xdef	_Sys
 511                     	xref	_config_flash2ram
 512                     	xref	_GPIO_Init
 513                     	xdef	_assert_failed
 533                     	end
