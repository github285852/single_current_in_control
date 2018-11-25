
#include "hardware.h"

void eeprom_write_nbyte(unsigned long addr,unsigned char * buf,unsigned int len)
{
	unsigned int i;
	FLASH->DUKR = 0xAE; /* Warning: keys are reversed on data memory !!! */
	FLASH->DUKR = 0x56;
  while (FLASH->IAPSR & FLASH_FLAG_DUL == RESET);
	for(i=0;i<len;i++)
	{
		*(PointerAttr uint8_t*)(MemoryAddressCast)(FLASH_DATA_START_PHYSICAL_ADDRESS + addr + i) = buf[i];
		while (FLASH->IAPSR & FLASH_FLAG_EOP == RESET);
		IWDG->KR = 0xaa;
	}
	FLASH->IAPSR &= 0xF7;
}
void eeprom_read_nbyte(unsigned long addr,unsigned char * buf, unsigned int len)
{
	unsigned int i;
	for(i=0;i<len;i++)
	{
		buf[i] = *(PointerAttr uint8_t *) (MemoryAddressCast)(FLASH_DATA_START_PHYSICAL_ADDRESS + addr + i);
	}
}
void config_ram2flash(void)
{
	eeprom_write_nbyte(ConfigAddr,(unsigned char *) &Sys.Config, sizeof (Sys.Config));
}
void config_flash2ram(void)
{
	eeprom_read_nbyte(ConfigAddr, (unsigned char *) &Sys.Config, sizeof (Sys.Config));
}
