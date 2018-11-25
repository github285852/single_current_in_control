   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32 - 23 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  44                     ; 8 main()
  44                     ; 9 {
  46                     	switch	.text
  47  0000               _main:
  51  0000               L12:
  52                     ; 10 	while (1);
  54  0000 20fe          	jra	L12
  89                     ; 29 void assert_failed(u8* file, u32 line)  
  89                     ; 30 {  
  90                     	switch	.text
  91  0002               _assert_failed:
  95  0002               L34:
  96  0002 20fe          	jra	L34
 109                     	xdef	_main
 110                     	xdef	_assert_failed
 129                     	end
