#include <myheaders.h>

void func2(unsigned int port_out,unsigned data)
{
  
switch( port_out)
    {
    case portA:
        DDRA=0xFF; 
        PORTA=data;
    break ;
    case portB:
        DDRB=0xFF;
        PORTB=data;
    break;
    case portC:
        DDRC=0xFF;
        PORTC=data;
    break;
    case portD:
        DDRD=0xFF;
        PORTD=data;
    break;
}
 
return; 

}