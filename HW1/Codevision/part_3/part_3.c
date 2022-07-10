#include <mega16.h>

void port_a(void)
{
 char data;
 DDRA = 0x00;
 DDRB = 0xFF;
 data = PINA;
 PORTB = data;

}
void main(void)
{

while (1)
      {
        port_a();

      }
}
