#include <headers.h>
// Declare your global variables here

int ms = 0;
int sec = 0;
int min = 0;
int hour = 0;
int c = 0;


// External Interrupt 1 service routine
interrupt [EXT_INT1] void ext_int1_isr(void)
{
// Place your code here
interput_1();
    
}

// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)                                                          
{
interupt_0();
    

}

void main(void)
{
times_ports_init();
lcd_init(16);

// Global enable interrupts
#asm("sei")
DDRB = 0x00;
lcd_init(16);
lcd_puts("00:00:00:00");

while (1)
      {               

      }
}
