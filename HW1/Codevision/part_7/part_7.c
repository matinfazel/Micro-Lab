#include <mega16.h>
#include <delay.h>

flash unsigned char digit[] = {0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,
                                 0x7F,0x6F};

void one(void);
void two(void);
void three(void);
void four(void);
void five(void);
void six(void);
                                     
void main(void)
{
one();
two();
four();
five();
while (1)
      {
        three();
        six();
        
      }
}


void one(void)
{
int i;
DDRB = 0xFF;
 for(i=0;i<4;i++)
 {
   PORTB = 0xFF;
   delay_ms(500);
   PORTB = 0x00;
   delay_ms(500);
 }
       
}


void two(void)
{
char i;
DDRB = 0xFF;

for(i =0;i<8;i++)
{
    PORTB = (1<<i);
    delay_ms(3000/8);
} 

}


void three(void)
{
 char data;
 DDRA = 0x00;
 DDRB = 0xFF;
 data = PINA;
 PORTB = data;

}


void four(void)
{
 int i;

 DDRC = 0xFF;
 DDRD = 0xFF;
                                                  
 PORTD = 0x00;

 for(i = 9;i>=0;i--)
 {
  PORTC = digit[i];
  delay_ms(1000);
 
 }
 
}

void five(void)
{
int data,i,j;
DDRA = 0x00;
DDRD = 0xff;

data = PINA;
data = data * 10;

for(i =data;i>=0;i--)
{
  PORTD = 0b00001110; 
  PORTC = digit[i/1000];
  delay_ms(200);
  
  PORTD = 0b00001101; 
  PORTC = digit[(i/100)%10];
  delay_ms(200); 
  
  PORTD = 0b00001011; 
  PORTC = digit[(i/10)%10] | 0b10000000;
  delay_ms(200);
  
  PORTD = 0b00000111; 
  PORTC = digit[i%10];
  delay_ms(200);
  
  i--;  
}

}


void six(void)
{
int data,i,j;
DDRA = 0x00;
DDRD = 0x0f;

data = PINA;
data = data * 10;

for(i =data;i>=0;i--)
{
  if (PIND.7 == 1)
    PORTD = 0b00001110; 
  PORTC = digit[i/1000];
  delay_ms(200);
  
  if (PIND.6 == 1)
    PORTD = 0b00001101; 
  PORTC = digit[(i/100)%10];
  delay_ms(200); 
  
  if (PIND.5 == 1)
    PORTD = 0b00001011; 
  PORTC = digit[(i/10)%10]| 0b10000000;
  delay_ms(200);
  
  if (PIND.4 == 1)
    PORTD = 0b00000111; 
  PORTC = digit[i%10];
  delay_ms(200);
  
  i--;  
}
}
