#include <headers.h>

void start_timer(){
TCCR0=(0<<WGM00) | (0<<COM01) | (1<<COM00) | (0<<WGM01) | (1<<CS02) | (0<<CS01) | (1<<CS00);
TCNT0=0x00;
OCR0=0x00;

}

void interput_1(void){

    if(PINB.4 == 0)
         start_timer();
    else if (PINB.5 == 0 ){
        if (c == 0){
            TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
            c = 1;}   
        else{
            TCCR0=(0<<WGM00) | (0<<COM01) | (0<<COM00) | (0<<WGM01) | (0<<CS02) | (0<<CS01) | (0<<CS00);
            lcd_clear();
            lcd_puts("00:00:00:00");
            ms = 0;
            sec = 0;
            min = 0;
            hour = 0;
            c = 0;
        }
       

    }
}