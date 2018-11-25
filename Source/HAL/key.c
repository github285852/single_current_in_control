#include "key.h"
unsigned int  key_press_time=0;
unsigned char key_push_lock=0;
unsigned char key_change=0;
unsigned char key_status;
unsigned char key_value;

void key_service(void)
{
	static unsigned char key_release_time=0;
	static unsigned char key_click=0;
	static unsigned char Continue=0;
	unsigned char ReadData=0;
	unsigned char Release;
	unsigned char Trigger;
	if(!(KEY_DEC_GPIO->IDR & KEY_DEC_PIN))
	{
		ReadData |= 0x01;
	}
	if(!(KEY_SET_GPIO->IDR & KEY_SET_PIN))
	{
		ReadData |= 0x02;
	}
	if(!(KEY_INC_GPIO->IDR & KEY_INC_PIN))
	{
		ReadData |= 0x04;
	}

	Trigger  = (uint8_t)(ReadData & (ReadData ^ Continue));
	Release  = (uint8_t)(ReadData ^ Trigger ^ Continue);
	Continue = ReadData;
	if (Trigger) key_press_time = 0; //在释放时清零
	if (Continue)
	{
		key_value = ReadData;
		if (key_press_time++ > press_time_min)//长按按下大5s
		{
		    key_status = 254; //长按操作正在按下
		}
	}
	if (Release)//按键抬起
	{
		if ((key_press_time > click_time_min) && (key_press_time <= click_time_max)) // 短按操作, 按下时间介于30ms到500ms
		{
	    key_click++;
		}
		else if ((key_press_time > click_time_max) && (key_press_time <= press_time_min)) //按下时间在0.5---5s
		{
	    key_click = 0;
		}
		else if (key_press_time > press_time_min) //长按按下大5s
		{
	    key_status = 255;//长按操作已经抬起
		}
		key_release_time = 0;
	}
	if (key_release_time++ > click_time_max)//按键抬起时间大于0.5s
	{
		if (key_click)
		{
	    key_status = key_click;
	    key_click = 0;
		}
	}
}
