/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
? Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 10/04/2022
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

#include <headers.h>


int temp = 1;
int rpm = 0;
int dir = 1;               
int speed = 0;
char lcd_str[16];

int duty_cycle = 10;
int temp_counter = 1;
int rpm_counter = 0;
int direction = 1;               

char temp_str[17];
// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
// Place your code here
    func3_6();
}

// Timer2 overflow interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{
    // Reinitialize Timer2 value
    TCNT2=0xB2;
    // Place your code here
    func5_6();

}


// Declare your global variables here

void main(void)
{

init_timer_ports_6();
func4_1();
lcd_init(16);


while (1)
      {
      // Place your code here

      }
}
