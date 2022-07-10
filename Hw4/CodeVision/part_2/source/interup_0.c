#include <headers.h>

void interupt_0(void){
    char tmp[16];
    // Place your code here
    lcd_clear();
    if (PINB.7 ==0 )
        total_car++;        

    else if (PINB.3 == 0 && total_car > 0)
      total_car--;

    if (total_car == 1000)
            sprintf(tmp,"%s","CE:FULL");
    else
         sprintf(tmp,"\nCE:%d",1000 - total_car);
     lcd_puts(tmp);  
     
     }