
#include "hardware.h"


#define press_time_min	500			//  5s
#define press_time_max	1000		// 10s
#define click_time_min	2				// 0.03s
#define click_time_max	50			// 0.5s


void key_service(void);
unsigned char key_scan2(void);
unsigned char key_scan3(void);

extern volatile unsigned char key_status; 
extern volatile unsigned int  key_press_time;
















