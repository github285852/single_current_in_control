
#include "stm8s.h"

#define press_time_min	500			//  5s
#define press_time_max	1000		// 10s
#define click_time_min	2				// 0.03s
#define click_time_max	50			// 0.5s


#define KEY_DEC_GPIO	GPIOD
#define KEY_SET_GPIO	GPIOD
#define	KEY_INC_GPIO 	GPIOC

#define KEY_DEC_PIN	GPIO_PIN_3
#define	KEY_SET_PIN	GPIO_PIN_4
#define KEY_INC_PIN	GPIO_PIN_7


void key_service(void);

extern volatile unsigned char key_status; 
extern volatile unsigned int  key_press_time;

extern unsigned char key_value;
extern unsigned char key_status;


#define KEY_DEC_PRESS	(key_value&0x01)
#define KEY_SET_PRESS	(key_value&0x02)
#define KEY_INC_PRESS	(key_value&0x04)












