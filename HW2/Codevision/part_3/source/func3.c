#include <myheaders.h>

void func3(unsigned int times,unsigned int delay)
{int i;

   for (i=0;i<times;i++)
   {
        func2(portB,0xff);
        delay_ms(delay);
        func2(portB,0x00);
        delay_ms(delay);
   
   }


return;
}