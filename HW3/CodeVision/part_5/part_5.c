
char data_key[] = {
'0','1','2','3',
'4','5','6','7',
'8','9','A','B',
'C','D','E','F'};
int flags = 0;
int inflags = 1;
char first_digit = -1;
char sec_digit = -1;

int row[4] = {0x10,0x20,0x40,0x80};

#include <mega16.h>
#include <delay.h>
#include <alcd.h>

char keypad(void)
{   char c;
    char r;
    char key=100;     
    
 
                               
     inflags =0; 
             
    for (r=0;r<4;r++)
    {
        PORTB=row[r];
        c=20;
        delay_ms(10);
        if (PINB.0==1) c=0;
        if (PINB.1==1) c=1;
        if (PINB.2==1) c=2;
        if (PINB.3==1) c=3;
        if (!(c==20)){
        key=(r*4)+c;
        PORTB=0xf0;
        while (PINB.0==1) {}
        while (PINB.1==1) {}
        while (PINB.2==1) {}
        while (PINB.3==1) {}
        }
        PORTB=0xf0;
    } 
         
     
    return key;
}

void speed();
void Time();
void W();
void Temp();


void main(void)
{
//char tmp;

DDRA=(0<<DDA7) | (0<<DDA6) | (0<<DDA5) | (0<<DDA4) | (0<<DDA3) | (0<<DDA2) | (0<<DDA1) | (0<<DDA0);
PORTA=(0<<PORTA7) | (0<<PORTA6) | (0<<PORTA5) | (0<<PORTA4) | (0<<PORTA3) | (0<<PORTA2) | (0<<PORTA1) | (0<<PORTA0);

DDRB=0xf0; // State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTB=(0<<PORTB7) | (0<<PORTB6) | (0<<PORTB5) | (0<<PORTB4) | (0<<PORTB3) | (0<<PORTB2) | (0<<PORTB1) | (0<<PORTB0);

DDRC=(0<<DDC7) | (0<<DDC6) | (0<<DDC5) | (0<<DDC4) | (0<<DDC3) | (0<<DDC2) | (0<<DDC1) | (0<<DDC0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTC=(0<<PORTC7) | (0<<PORTC6) | (0<<PORTC5) | (0<<PORTC4) | (0<<PORTC3) | (0<<PORTC2) | (0<<PORTC1) | (0<<PORTC0);

// Port D initialization
// Function: Bit7=In Bit6=In Bit5=In Bit4=In Bit3=In Bit2=In Bit1=In Bit0=In 
DDRD=(0<<DDD7) | (0<<DDD6) | (0<<DDD5) | (0<<DDD4) | (0<<DDD3) | (0<<DDD2) | (0<<DDD1) | (0<<DDD0);
// State: Bit7=T Bit6=T Bit5=T Bit4=T Bit3=T Bit2=T Bit1=T Bit0=T 
PORTD=(0<<PORTD7) | (0<<PORTD6) | (0<<PORTD5) | (0<<PORTD4) | (0<<PORTD3) | (0<<PORTD2) | (0<<PORTD1) | (0<<PORTD0);


GICR|=(1<<INT1) | (0<<INT0) | (0<<INT2);
MCUCR=(1<<ISC11) | (1<<ISC10) | (0<<ISC01) | (0<<ISC00);
MCUCSR=(0<<ISC2);
GIFR=(1<<INTF1) | (0<<INTF0) | (0<<INTF2);


lcd_init(16);



while (1)
      {
          speed();
          Time();
          W();
          Temp();


      }
}


void speed()
{   char tmp;
    while(1){
        lcd_gotoxy(0,0);
        lcd_puts("Speed:??(0-50r)");
        while(1)
        {
            tmp = keypad();
            if (tmp >=0 && tmp <=9){    
                lcd_gotoxy(0,1);
                first_digit = tmp;   
                lcd_putchar(data_key[tmp]);
                 
                break;        
            }
        
        }

        while(1)
        {
            tmp = keypad();
            if (tmp >=0 && tmp <=9){    
                //lcd_gotoxy(2,2);
                sec_digit = tmp;   
                lcd_putchar(data_key[tmp]);
                break;        
            }
        
        }
        
        if ( !(first_digit *10 + sec_digit <=50 )){
            lcd_puts("EE");
            delay_ms(2000);
            lcd_clear();
            }
 
        else{
            delay_ms(1000);
            lcd_clear();          
            return;
            
         } 
        }
}


      
void Time()
{   char tmp;
    while(1){
        lcd_gotoxy(0,0);
        lcd_puts("Time:??(0-99s)");
        while(1)
        {
            tmp = keypad();
            if (tmp >=0 && tmp <=9){    
                lcd_gotoxy(0,1);
                first_digit = tmp;   
                lcd_putchar(data_key[tmp]);
                 
                break;        
            }
        
        }

        while(1)
        {
            tmp = keypad();
            if (tmp >=0 && tmp <=9){    
                //lcd_gotoxy(2,2);
                sec_digit = tmp;   
                lcd_putchar(data_key[tmp]);
                break;        
            }
        
        }
        
        if ( !(first_digit *10 + sec_digit <=99 ) ){
            lcd_puts("EE");
            delay_ms(2000);
            lcd_clear();          
            }
  
        else{
            delay_ms(1000);
            lcd_clear();          
            return;
            
         } 
        
    }        
  

}

void W()
{   char tmp;
    while(1){
        lcd_gotoxy(0,0);
        lcd_puts("W:??(0-99kg)");
        while(1)
        {
            tmp = keypad();
            if (tmp >=0 && tmp <=9){    
                lcd_gotoxy(0,1);
                first_digit = tmp;   
                lcd_putchar(data_key[tmp]);
                 
                break;        
            }
        
        }

        while(1)
        {
            tmp = keypad();
            if (tmp >=0 && tmp <=9){    
                //lcd_gotoxy(2,2);
                sec_digit = tmp;   
                lcd_putchar(data_key[tmp]);
                break;        
            }
        
        }
        
        if (!(first_digit *10 + sec_digit <=99) ){
            lcd_puts("EE");
            delay_ms(2000);
            lcd_clear();             
               }

        else{
            delay_ms(1000);
            lcd_clear();          
            return;
            
         }      
        }        

}


void Temp()
{   char tmp;
    while(1){
    lcd_gotoxy(0,0);
    lcd_puts("Temp:??(20-80C)");
    while(1)
    {
        tmp = keypad();
        if (tmp >=0 && tmp <=9){    
            lcd_gotoxy(0,1);
            first_digit = tmp;   
            lcd_putchar(data_key[tmp]);
             
            break;        
        }
    
    }

    while(1)
    {
        tmp = keypad();
        if (tmp >=0 && tmp <=9){    
            //lcd_gotoxy(2,2);
            sec_digit = tmp;   
            lcd_putchar(data_key[tmp]);
            break;        
        }
    
    }
    
    if (!(first_digit *10 + sec_digit <=80 &&  first_digit *10 + sec_digit >=20))
      {
        lcd_puts("EE");
        delay_ms(2000);
        lcd_clear();
      } 
      
    else{   delay_ms(1000); 
            lcd_clear();
         
            return;
            
        
           } 
        
    
    }        

}