#include <mega16.h>
#include <delay.h>
flash unsigned char array[] = {0x3f,0x06,0x5B,0x4f,0x66,0x6D,0x7D,0x07,
                                 0x7F,0x6F};
                                 
void number3_new(void)
{
int data,i,j,number;
int number=0;              
int temp = 0;
int sadghan=0;
int dahghan=0;
int yekan=0;
int decimal=0;  
int sadghan_tmp=0;
int dahghan_tmp=0;
int yekan_tmp=0;
int decimal_tmp=0;         
int number_tmp = 0;
DDRA = 0x00;
DDRD = 0x0f;

data = PINA;
data = data * 10;



for(i =data;i>=0;i= i-2)
{
      number = data;
      while(number > 0){ 
       
        number = temp;
        if(number >= 1000){
            decimal = number % 10;
            number = number / 10;
            yekan = number % 10;
            number = number / 10;
            dahghan = number % 10;
            number = number / 10;
            sadghan = number % 10;
        }                                           
        else if(number >=100) {
            decimal = number % 10;
            number = number / 10;
            yekan = number % 10;
            number = number / 10;
            dahghan = number % 10;
            sadghan = 0;        
        }  
        else if(number >= 10){
            decimal = number % 10;
            number = number / 10;
            yekan = number % 10;
            dahghan = 0;
            sadghan = 0;
        }     
        else{
            decimal = number % 10;
            yekan = 0;
            dahghan = 0;
            sadghan = 0;
                         
        }
          
  if (PIND.7 != 0)
    PORTD = 0b00001110; 
  PORTC = array[sadghan];
  delay_ms(200);
  
  if (PIND.6 != 0)
    PORTD = 0b00001101; 
  PORTC = array[dahghan];
  delay_ms(200); 
  
  if (PIND.5 != 0)
    PORTD = 0b00001011; 
  PORTC = array[yekan]| 0b10000000;
  delay_ms(200);
  
  if (PIND.4 != 0)
    PORTD = 0b00000111; 
  PORTC = array[decimal];
  delay_ms(200);
  
  
}
}

void main(void)
{

while (1)
      {
        number3_new();
      }
}
