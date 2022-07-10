#include <headers.h>
// Declare your global variables here
int total_car = 0;
// External Interrupt 0 service routine
interrupt [EXT_INT0] void ext_int0_isr(void)
{
interupt_0();        

}

void main(void)
{
init_ports_timers();
lcd_init(16);

// Global enable interrupts
#asm("sei")
DDRB = 0x00;
while (1)
      {
      // Place your code here

      }
}
