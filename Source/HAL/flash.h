
#ifndef __FLASH_EEPROM_H
#define __FLASH_EEPROM_H





void eeprom_write_nbyte(unsigned long addr,unsigned char * buf,unsigned int len);
void eeprom_read_nbyte(unsigned long addr,unsigned char * buf, unsigned int len);
void config_ram2flash(void);
void config_flash2ram(void);

#endif
