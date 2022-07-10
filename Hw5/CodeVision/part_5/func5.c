#include <var.h>
#include <mega16.h>
#include <stdio.h>
#include <alcd.h>


void func5(void){
    if (rpm<=100){
        if (dir == 1 ){ 
            if (temp == 1) {
                PORTB.4 = 1; 
                PORTB.5 = 0;  
                PORTB.6 = 0;  
                PORTB.7 = 0;  
                temp ++ ;
            }
            if (temp == 2) {
                PORTB.4 = 0;  
                PORTB.5 = 1;  
                PORTB.6 = 0;  
                PORTB.7 = 0;   
                temp ++ ;
            }
            if (temp == 3) {
                PORTB.4 = 0;  
                PORTB.5 = 0;  
                PORTB.6 = 1;  
                PORTB.7 = 0;  
                temp ++ ;
            }
            if (temp == 4) {
                PORTB.4 = 0;  
                PORTB.5 = 0;  
                PORTB.6 = 0;  
                PORTB.7 = 1;  
                temp ++ ;
            } 
                
            if (temp > 4){
                temp=1;
            }
        }
        rpm++;  
    }
        
        
    if (rpm==100){ 
           PORTB.4 = 0;  
           PORTB.5 = 0;  
           PORTB.6 = 0;  
           PORTB.7 = 0;  
           dir=0;
       
           rpm++;
    }
         
    if (rpm >100 &&  rpm<=200){ 
        if (dir == 0 ){ 
            if (temp == 1) {
                PORTB.4 = 0;  
                PORTB.5 = 0;  
                PORTB.6 = 0; 
                PORTB.7 = 1;
                temp ++ ;
            }
            if (temp == 2) {
                PORTB.4 = 0; 
                PORTB.5 = 0;
                PORTB.6 = 1;
                PORTB.7 = 0;
                temp ++ ;
            }
            if (temp == 3) {
                PORTB.4 = 0;  
                PORTB.5 = 1;  
                PORTB.6 = 0;  
                PORTB.7 = 0;  
                temp ++ ;
            }
            if (temp == 4) {
                PORTB.4 = 1;  
                PORTB.5 = 0;  
                PORTB.6 = 0;  
                PORTB.7 = 0;  
                temp ++ ;
            }
                
            if (temp > 4){
                temp=1;
            }
                
        }
        rpm++; 
    }
          
    if (rpm>200){
        rpm=0; 
        dir=1;
    }       
    
    speed = 1/(0.01*4)*70;
    sprintf(lcd_str, "%d", speed);
    lcd_gotoxy(0, 0);
    lcd_puts(lcd_str);
    lcd_gotoxy(6, 0);
    lcd_puts("RPM:");
}