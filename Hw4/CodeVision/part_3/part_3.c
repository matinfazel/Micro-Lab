/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
? Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 31/03/2022
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

//#include <mega16.h>

// Alphanumeric LCD functions
//#include <alcd.h>
#include <headers.h>
// Declare your global variables here
// Timer1 overflow interrupt service routine
interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{

if (PINA == 0x08){
    TCNT1H=0xFFFF >> 8;
    TCNT1L=0xFFFF & 0xff;    
}

else if (PINA== 0x01){
    TCNT1H=0xFFFF >> 8;
    TCNT1L=0xFFF8 & 0xff;
}

}

void main(void)
{
init_port_timers();
    
while (1)
      {
      // Place your code here

      }
}
