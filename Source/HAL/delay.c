
#include "stm8s.h"

void _delay_us(u16 n)
{
	while(n--)
	{
	}
}
void _delay_10us(u16 n)
{
	unsigned int i;
	while(n--)
	{
		for(i=0;i<10;i++)
		{
		}
	}
}
void _delay_ms(u16 n)
{
	unsigned int i;
	while(n--)
	{
		IWDG->KR = 0xaa;
		for(i=0;i<1120;i++)
		{
		}
	}
}
