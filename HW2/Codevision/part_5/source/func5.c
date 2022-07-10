#include <myheaders.h>

void seven_seg_display (int data, int data_port, int enable_data)
{ char data_in;
 unsigned char digit[] = {0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,
                                 0x7F,0x6F};   
   

  data_in = func1(enable_data);
  
  func2(portD,0b00001110|(data_in &0b1));
  func2(portC,digit[data/1000]);
  delay_ms(200);
  
  func2(portD,0b00001101| (data_in &0b10));
  func2(portC,digit[(data/100)%10]);

  delay_ms(200); 
  
  func2(portD,0b00001011 | (data_in &0b100));
  func2(portC,digit[(data/10)%10]);

  delay_ms(200);
  
  func2(portD,0b00000111 | (data_in &0b1000));
  func2(portC,digit[data%10]);
  delay_ms(200);
  

return;
}