#ifndef _header_INCLUDED_
#define _header_INCLUDED_

#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))
#include <mega16.h>
#include <stdio.h>
#include <delay.h>
#include <alcd.h>

//part 1 
unsigned int read_adc(unsigned char adc_input);
void init_acd();
void check_acds();


// part 2
#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 7

extern unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
extern unsigned int tmp_adc[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

interrupt [ADC_INT] void adc_isr(void);
void init_acd_interupt(void);
void func2_interupt(void);


// part 3
interrupt [TIM0_OVF] void timer0_ovf_isr(void);
void init_adc_timer(void);

extern int data;


#endif 