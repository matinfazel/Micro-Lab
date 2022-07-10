#include <myheaders.h>

void func6(void)
{
  func1(portA);
  delay_ms(1000);
  
  func2(portB,0x55);
  delay_ms(1000);
  
  func3(12,500);
  delay_ms(1000);
  
  func4();
  delay_ms(1000);
  
  seven_seg_display(1234,portC,portA);
  delay_ms(1000);
  
}                     