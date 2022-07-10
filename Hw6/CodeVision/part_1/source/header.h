#ifndef _headers_INCLUDED_
#define _headers_INCLUDED_

#include <mega16.h>
#include <stdio.h>
#include <delay.h>
#include <alcd.h>

#define ADC_VREF_TYPE ((0<<REFS1) | (1<<REFS0) | (0<<ADLAR))

unsigned int read_adc(unsigned char adc_input);
void init_acd();
void check_acds();
#endif 