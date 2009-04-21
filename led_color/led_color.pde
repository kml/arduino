//int ledpin = 9;                           // light connected to digital pin 9 PWM

byte r = 9;
byte g = 10;
byte b = 11;

int hex2int(char c) 
{
  if(c >= '0' && c <= '9')
    return c - '0';
  if(c >= 'A' && c <= 'F')
    return c - 'A' + 10;
  if(c >= 'a' && c <= 'f')
    return c - 'a' + 10;
  return -1;
}

int color_value(char a, char b) {
   return hex2int(a)*16 + hex2int(b) ;
}

void rgb_led_on(char* color, byte r, byte g, byte b) {
  analogWrite(r, color_value(color[1], color[2]));
  analogWrite(g, color_value(color[3], color[4]));
  analogWrite(b, color_value(color[5], color[6]));  
}

void setup() 
{ 
  // nothing for setup 
} 

void loop() 
{ 
  rgb_led_on("#f0f310", r, g, b);
}
