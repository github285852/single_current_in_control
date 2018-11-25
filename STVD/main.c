/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
//#include "hardware.h"
#include "stm8s_conf.h"

main()
{
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
