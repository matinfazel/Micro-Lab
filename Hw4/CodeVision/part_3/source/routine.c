#include <headers.h>
void routine(void){

if (PINA == 0x08){
    TCNT1H=0xFFFF >> 8;
    TCNT1L=0xFFFF & 0xff;    
}

else if (PINA== 0x01){
    TCNT1H=0xFFFF >> 8;
    TCNT1L=0xFFF8 & 0xff;
}


}