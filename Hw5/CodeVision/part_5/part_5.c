/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
� Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 03/04/2022
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

#include <mega16.h>
#include <headers.h>
// Alphanumeric LCD functions
#include <alcd.h>
int temp = 1;
int rpm = 0;
int dir = 1;               
int speed = 0;
char lcd_str[16];

interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
// Place your code here
    TCNT2=0xB2;
    
    // Place your code here
    func5();
}

void main(void)
{

lcd_init(16);
initial_ports_timers();
// Global enable interrupts
#asm("sei")

while (1)
      {
      

      }
}
