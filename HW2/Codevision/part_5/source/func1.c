#include <myheaders.h>

char func1(unsigned int port_in)
{
  char data;
  
  switch( port_in)
  {
        case portA:
        DDRA=0x00; 
        data=PINA;
        break ;
        case portB:
        DDRB=0x00; 
        data=PINB;
        break;
        case portC:
        DDRC=0x00; 
        data=PINC;
        break;
        case portD:
        DDRD=0x00; 
        data=PIND;
        break;
  }
 
return data; 

}