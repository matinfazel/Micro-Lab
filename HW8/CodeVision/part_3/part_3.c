#include <mega16.h>

// Graphic Display functions
#include <glcd.h>

// Font used for displaying text
// on the graphic display
#include <font5x7.h>
#include <delay.h>
#include <math.h>
// Declare your global variables here


int tmpx;
int tmpy;
int second = 0;
int minute = 40;
int hour = 5;

  void q3(void);

// Timer1 overflow interrupt service routine



void main(void)
{
// Declare your local variables here
// Variable used to store graphic display
// controller initialization data
GLCDINIT_t glcd_init_data;

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRA=(1<<DDA7) | (1<<DDA6) | (1<<DDA5) | (1<<DDA4) | (1<<DDA3) | (1<<DDA2) | (1<<DDA1) | (1<<DDA0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRB=(1<<DDB7) | (1<<DDB6) | (1<<DDB5) | (1<<DDB4) | (1<<DDB3) | (1<<DDB2) | (1<<DDB1) | (1<<DDB0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRC=(1<<DDC7) | (1<<DDC6) | (1<<DDC5) | (1<<DDC4) | (1<<DDC3) | (1<<DDC2) | (1<<DDC1) | (1<<DDC0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=Out Bit6=Out Bit5=Out Bit4=Out Bit3=Out Bit2=Out Bit1=Out Bit0=Out 
DDRD=(1<<DDD7) | (1<<DDD6) | (1<<DDD5) | (1<<DDD4) | (1<<DDD3) | (1<<DDD2) | (1<<DDD1) | (1<<DDD0);
// State: Bit7=0 Bit6=0 Bit5=0 Bit4=0 Bit3=0 Bit2=0 Bit1=0 Bit0=0 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);


// Graphic Display Controller initialization
// The KS0108 connections are specified in the
// Project|Configure|C Compiler|Libraries|Graphic Display menu:
// DB0 - PORTC Bit 0
// DB1 - PORTC Bit 1
// DB2 - PORTC Bit 2
// DB3 - PORTC Bit 3
// DB4 - PORTC Bit 4
// DB5 - PORTC Bit 5
// DB6 - PORTC Bit 6
// DB7 - PORTC Bit 7
// E - PORTD Bit 0
// RD /WR - PORTD Bit 1
// RS - PORTD Bit 2
// /RST - PORTD Bit 3
// CS1 - PORTD Bit 4
// CS2 - PORTD Bit 5

// Specify the current font for displaying text
glcd_init_data.font=font5x7;
// No function is used for reading
// image data from external memory
glcd_init_data.readxmem=NULL;
// No function is used for writing
// image data to external memory
glcd_init_data.writexmem=NULL;

glcd_init(&glcd_init_data);

// Global enable interrupts
#asm("sei")

while (1)
      {
      // Place your code here
       q3();
       delay_ms(400);
      }
}
void q3(){
    
    second++;
        if(second == 60)
        {
            minute++;
            second = 0;  
        }
        if(minute == 60){
            hour++;
            minute = 0;
        }if(hour == 12){
            hour = 0;  
        }
        
        glcd_clear();
       
        glcd_circle(60, 31, 30);
        glcd_setlinestyle(3,5);
        glcd_circle(60, 31, 2);
        glcd_setlinestyle(1,GLCD_LINE_SOLID); 

        tmpx = 25*cos(second*60/10);tmpy = 25*sin(second*60/10);
      
        glcd_line(60,31,tmpx+63,31-tmpy);tmpx = 20*cos(minute*60/10);
        tmpy = 20*sin(minute*60/10);
        
        glcd_line(60,31,tmpx+60,31-tmpy); 
        

        tmpy = 15*sin(hour*60/10);
        tmpx = 15*cos(hour*60/10);
        glcd_line(60,31,tmpx+60,31-tmpy);
    
   
}