#include <mega16.h>
#include <delay.h>
flash unsigned char digit[] = {0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,
                                 0x7F,0x6F};
void number9(void)
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

void main(void)
{

while (1)
      {
         number9();
      }
}
