#include <mega16.h>
#include <stdio.h>
#include <alcd.h>
#include <delay.h>


extern int ms ;
extern int sec ;
extern int min ;
extern int hour;
extern int c;


void interput_1(void);
void interupt_0(void);
void start_timer();
void times_ports_init(void);