/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
#include "hardware.h"

void ALL_GpioInit(void)
{
	//key gpio init
	GPIO_Init(KEY_SET_GPIO,KEY_SET_PIN,GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(KEY_DEC_GPIO,KEY_DEC_PIN,GPIO_MODE_IN_PU_NO_IT);
	GPIO_Init(KEY_INC_GPIO,KEY_INC_PIN,GPIO_MODE_IN_PU_NO_IT);
	
	// realy gpio
	GPIO_Init(RELAY_GPIO,REALY_PIN,GPIO_MODE_OUT_PP_LOW_FAST);
	
	
}

void IWDG_Config(void)
{
	IWDG->KR = 0xCC;
	IWDG->KR = 0x55;
	IWDG->PR = 0x06;
	IWDG->RLR= 0xff;
	IWDG->KR = 0xAA;
}


void init_timer4(void)
{
	TIM4->PSCR = 0x07;
  TIM4->ARR  = 250;// 2ms
	TIM4->IER |= 0x01;
	TIM4->CR1 |= 0x01;
}


SYS Sys;

main()
{
	memset((u8*)&Sys,0,sizeof(SYS));
	config_flash2ram();
	ALL_GpioInit();
	init_timer4();
	
	
	
//	IWDG_Config();
	enableInterrupts();
	while (1);
}


#ifdef  USE_FULL_ASSERT

void assert_failed(u8* file, u32 line)  
{  
  /* User can add his own implementation to report the file name and line number, 
     ex: printf(¡°Wrong parameters value: file %s on line %drn¡±, file, line) */  
  
  /* Infinite loop */  
  while (1)  
  {  
  }  
}  

#endif
