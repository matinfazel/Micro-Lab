#include <stdio.h>
#include <math.h>
#include <mega16.h>
void func2(){

    int duty_cycle = 0;
    DDRA = 0x00;
    duty_cycle = 45;
    duty_cycle = ((duty_cycle*90)/255) + 5;
    duty_cycle = floor((duty_cycle*255)/100);
    OCR0 = duty_cycle;



}