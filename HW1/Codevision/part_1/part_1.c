#include <mega16.h>
#include <delay.h>

void delay_500(void)
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
void main(void)
{
  delay_500();
  while(1)
  {
  
  
  }
      
}
