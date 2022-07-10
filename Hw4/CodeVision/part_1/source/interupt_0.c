#include <headers.h>

void interupt_0(void){

    char time[16];
    // Reinitialize Timer 0 value
    TCNT0=0xB2;
    // Place your code here

    if (ms >= 99){
        ms = 0;
        if (sec >= 59){
             sec = 0;
             if(min >= 59){
                  min = 0;
                  hour++;
             }
             else min++;
             
        }
        else
            sec++;
    }
    else
        ms++; 
    sprintf(time,"%d:%d:%d:%d",hour,min,sec,ms);
    lcd_clear();
    lcd_puts(time);


}