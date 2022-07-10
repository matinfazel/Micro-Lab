#ifndef _header_INCLUDED_
#define _header_INCLUDED_

#include <mega16.h>
#include <delay.h>
#include <alcd.h>
#include <stdio.h>

#define FIRST_ADC_INPUT 0
#define LAST_ADC_INPUT 7

#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))

extern unsigned int adc_data[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];
extern unsigned int tmp_adc[LAST_ADC_INPUT-FIRST_ADC_INPUT+1];

interrupt [ADC_INT] void adc_isr(void);
void init_acd_interupt(void);
void func2_interupt(void);

#endif
