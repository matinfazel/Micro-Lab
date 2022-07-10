

#include <mega16.h>

// Graphic Display functions
#include <glcd.h>

// Font used for displaying text
// on the graphic display
#include <font5x7.h>
#include <delay.h>
// Declare your global variables here
const unsigned short data[] = {
        0xFF, 0x07, 0x1C, 0x70, 0xE0, 0x3C, 0x06, 0xFF,  // Code for char  
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // Code for char !   
        
        };    
        

    int r = 0;
    int c = 0;
    int x = 8;
    int y = 0;         
void writing();        
         void question1();
void main(void)
{
// Declare your local variables here
// Variable used to store graphic display
// controller initialization data
GLCDINIT_t glcd_init_data;

// Input/Output Ports initialization
// Port A initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

// Port B initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRB=(0<<DDB7) | (0<<DDB6) | (0<<DDB5) | (0<<DDB4) | (0<<DDB3) | (0<<DDB2) | (0<<DDB1) | (0<<DDB0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

// Port C initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
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
// /CS1 - PORTD Bit 5
// /CS2 - PORTD Bit 4

// Specify the current font for displaying text
glcd_init_data.font=font5x7;
// No function is used for reading
// image data from external memory
glcd_init_data.readxmem=NULL;
// No function is used for writing
// image data to external memory
glcd_init_data.writexmem=NULL;

glcd_init(&glcd_init_data);


DDRA = 0xff;
DDRB = 0xff;
while (1)
      {
      // Place your code here

                    //question1(); 
               PORTB = data[5];
               PORTA = data[5];
      }
}                        




 void question1(){   

    int i=0;
      
    while(1){
        for(i=0;i<100;i++){

             writing()   ;
          } 
                 
          if (x == 248)
          {
            x = 8;
            y = 0;
            r=0;
            c=0;
          }
                 
          else
          { 
             x =  x + 8;
             y = y + 8;
          }

    }        
}

void writing()
{

                PORTD = 0x80;
                PORTB = data[r];
                PORTA = 1<<c;

                delay_ms(2);

                PORTD = 0x00;
                PORTB = data[r+8];
                PORTA = 1<<c;

                r++;
                if (r == x)
                {
                    r = y;   
                }
                c = (c+1)%8;
                delay_ms(2);

}