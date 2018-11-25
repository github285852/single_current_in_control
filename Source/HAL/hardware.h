
#ifndef	_HARDWARE_H_
#define	_HARDWARE_H_



#include "delay.h"
#include "key.h"

#define	ConfigAddr		0


#define MAX_REMOTE		8
#define ID_BYTES 3

#define	PWM_PORT			GPIOA
#define	PWM_PIN				GPIO_Pin_0
#define	PWM_EXTI_PIN	EXTI_Pin_0

typedef	enum
{
	Normal=0,			//Õý³£
	Study,
	Pair,
	DELOB,
	RESTO,		
	CLOSING
}WORK_MODE;

typedef struct SYS
{
	WORK_MODE work_mode;
	unsigned char ready_buf[ID_BYTES];
	unsigned char ready_ch;
	unsigned char is_ready;
	struct
	{
		struct
		{
			unsigned char id[ID_BYTES];
			unsigned char cmd;
		}Device[MAX_REMOTE];
		unsigned char DevIndex;
	}Config;
	struct
	{
		u8 rxok;
		u8 rxbits;
		u8 rxlen;
		u8 rxbuf[10];
		u8 cmd;
		//u32 id;
	}rf433;
}SYS;

extern SYS Sys;


#endif



