#include <mega16.h>
#include <delay.h>

flash unsigned char digit[] = {0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,
                                 0x7F,0x6F};
                                 
void number3(void)
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

void main(void)
{

while (1)
      {
         number3();
      }
}
