#include <mega16.h>
#include <delay.h>

void light(void)
{
char i;
DDRB = 0xFF;

for(i =0;i<8;i++)
{
    PORTB = (1<<i);
    delay_ms(3000/8);
} 

}

void main(void)
{

while (1)
      {
        light();
      }
}
