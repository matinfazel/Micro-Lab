/*******************************************************
This program was created by the
CodeWizardAVR V3.12 Advanced
Automatic Program Generator
© Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
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
#include <stdio.h>
#include <math.h>
// Alphanumeric LCD functions
#include <alcd.h>
#include <headers.h>
//int duty_cycle  =0;
// Declare your global variables here


void main(void)
{
lcd_init(8);
init_timers_ports();
func2();


while (1)
      {
      // Place your code here

      }
}
