/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 25/04/2022
Author  : 
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 8/000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*******************************************************/
#include <header.h>
// Declare your global variables here
unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
unsigned int tmp_adc[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

void main(void)
{
init_acd_interupt();
while (1)
      {
      // Place your code here 
            func2_interupt();

      }
}
