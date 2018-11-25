
#include "stm8s_it.h"
#include "hardware.h"
unsigned char t2ms=0;
unsigned char t10ms=0;
unsigned char t1s=0;
#if defined(HS3121B)
extern unsigned char OutputSwitch;
extern u16 DimCounter1;
#elif defined(HS3122A)
extern CMD_QUEUE cmdq[2];
extern volatile unsigned char keep_run_flag;
extern volatile unsigned char need_stop_shutter;
extern unsigned char out_status;
#endif
extern unsigned char press_lock;
//unsigned char t4ms = 0;

void out(unsigned char val);
void t1s_service(void);
void t1m_service(void);

void TIM2_SetCounter(uint16_t Counter)
{
  TIM2->CNTRH = (uint8_t)(Counter >> 8);
  TIM2->CNTRL = (uint8_t)(Counter);
}
uint16_t TIM2_GetCounter(void)
{
  uint16_t tmpcntr = 0;
  tmpcntr =  ((uint16_t)TIM2->CNTRH << 8);
  return (uint16_t)( tmpcntr| (uint16_t)(TIM2->CNTRL));
}
void TIM2_SetCompare1(uint16_t Compare1)
{
  TIM2->CCR1H = (uint8_t)(Compare1 >> 8);
  TIM2->CCR1L = (uint8_t)(Compare1);
}
ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
{
  ITStatus bitstatus = RESET;
  uint8_t TIM2_itStatus = 0, TIM2_itEnable = 0;
  assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
  TIM2_itStatus = (uint8_t)(TIM2->SR1 & TIM2_IT);
  TIM2_itEnable = (uint8_t)(TIM2->IER & TIM2_IT);
  if ((TIM2_itStatus != (uint8_t)RESET ) && (TIM2_itEnable != (uint8_t)RESET ))
  {
    bitstatus = SET;
  }
  else
  {
    bitstatus = RESET;
  }
  return (ITStatus)(bitstatus);
}

#ifdef _COSMIC_
INTERRUPT_HANDLER(NonHandledInterrupt, 25)
{
}
#endif
INTERRUPT_HANDLER_TRAP(TRAP_IRQHandler)
{
}
INTERRUPT_HANDLER(TLI_IRQHandler, 0)
{
}
INTERRUPT_HANDLER(AWU_IRQHandler, 1)
{
}
INTERRUPT_HANDLER(CLK_IRQHandler, 2)
{
}
INTERRUPT_HANDLER(EXTI_PORTA_IRQHandler, 3)
{
	#if defined(HS1121D)
	if(ZERO_PORT->IDR&(ZERO_PIN))
	{
		return;
	}
	//LEDB_PORT->ODR ^= (uint8_t)(LEDB_PIN);
	if(OutputSwitch&0x01)
	{
		OUT_PORT->ODR &= (uint8_t)(~OUT_PIN);
		TIM2_SetCounter(DimCounter1);
		TIM2->SR1 = (uint8_t)~TIM2_IT_UPDATE;
		TIM2->IER |= TIM2_IT_UPDATE;
		TIM1->CNTRH = 0xd8;
		TIM1->CNTRL = 0xef;
		TIM1->SR1 = (uint8_t)~TIM1_IT_UPDATE;
		TIM1->IER |= TIM1_IT_UPDATE;
	}
	#endif
}
INTERRUPT_HANDLER(EXTI_PORTB_IRQHandler, 4)
{
}
INTERRUPT_HANDLER(EXTI_PORTC_IRQHandler, 5)
{
	#if defined(HS3121B)
	//LEDB_PORT->ODR ^= (uint8_t)(LEDB_PIN);
	if(OutputSwitch&0x01)
	{
		TIM2_SetCounter(0);
		TIM2_SetCompare1(DimCounter1);
		TIM2->SR1 = (uint8_t)~TIM2_IT_CC1;
		TIM2->IER |= TIM2_IT_CC1;
	}
	#elif defined(HS3121A)
	out(lamp_status);
	ZERO_PORT->CR2 &= ~ZERO_PIN;
	#elif defined(HS3124A)
	if(out_status & 0x01)
	{
		OUT1_PORT->ODR |= (uint8_t)OUT1_PIN;
	}
	else
	{
		OUT1_PORT->ODR &= (uint8_t)(~OUT1_PIN);
	}
	if(out_status & 0x02)
	{
		OUT2_PORT->ODR |= (uint8_t)OUT2_PIN;
	}
	else
	{
		OUT2_PORT->ODR &= (uint8_t)(~OUT2_PIN);
	}
	ZERO_PORT->CR2 &= ~ZERO_PIN;
	#endif
}
INTERRUPT_HANDLER(EXTI_PORTD_IRQHandler, 6)
{
}
INTERRUPT_HANDLER(EXTI_PORTE_IRQHandler, 7)
{
}
INTERRUPT_HANDLER(SPI_IRQHandler, 10)
{
}
INTERRUPT_HANDLER(TIM1_UPD_OVF_TRG_BRK_IRQHandler, 11)
{
	TIM1->CNTRH = 0xFF;//定时 200us,手动加载
	TIM1->CNTRL = 0x9b + 3;
}
INTERRUPT_HANDLER(TIM1_CAP_COM_IRQHandler, 12)
{
}
INTERRUPT_HANDLER(TIM2_UPD_OVF_BRK_IRQHandler, 13)
{
	TIM2->SR1 = (uint8_t)~TIM2_IT_UPDATE;
}
INTERRUPT_HANDLER(TIM2_CAP_COM_IRQHandler, 14)
{
	#if defined(HS3121B)
	u16 dimc;
	static unsigned char delay_flag1 = 0;
	if(TIM2_GetITStatus(TIM2_IT_CC1))
	{
		if(delay_flag1)
		{
			delay_flag1 = 0;
			out(0);
			TIM2->IER &= (uint8_t)~TIM2_IT_CC1;
		}
		else
		{
			delay_flag1 = 1;
			out(1);
			TIM2_SetCounter(0);
			dimc = 1000;
			TIM2_SetCompare1(dimc);
			TIM2->IER |= TIM2_IT_CC1;
		}
		TIM2->SR1 = (uint8_t)~TIM2_IT_CC1;
	}
	#endif
}
INTERRUPT_HANDLER(TIM3_UPD_OVF_BRK_IRQHandler, 15)
{
}
INTERRUPT_HANDLER(TIM3_CAP_COM_IRQHandler, 16)
{
}
INTERRUPT_HANDLER(UART1_TX_IRQHandler, 17)
{
}
INTERRUPT_HANDLER(UART1_RX_IRQHandler, 18)
{
}
INTERRUPT_HANDLER(I2C_IRQHandler, 19)
{
}
INTERRUPT_HANDLER(ADC1_IRQHandler, 22)
{
}

void t1s_loop(void)
{
	if(t10ms > 99)	// 1 second
	{
		t10ms = 0;
		t1s++;
	//	t1s_service();
		if(t1s > 59)	// 1 minute
		{
			t1s = 0;
	//		t1m_service();
		}
	}
	else if(t10ms > 49)	// 0.5 second
	{
		
	}
}

INTERRUPT_HANDLER(TIM4_UPD_OVF_IRQHandler, 23)
{
	t2ms++;
	if(t2ms > 4)
	{
		t2ms = 0;
		t10ms++;
		key_service();
	}
	TIM4->SR1 = (uint8_t)~0x01;
}
INTERRUPT_HANDLER(EEPROM_EEC_IRQHandler, 24)
{
}
