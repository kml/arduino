// (c) kml

// PWM outputs
byte r_pin = 9;
byte g_pin = 10;
byte b_pin = 11;

byte first_byte, byte1, byte2, byte3, byte4, byte5, byte6;

int hex2int(char c) 
{
  if(c >= '0' && c <= '9')
    return c - '0';
  if(c >= 'A' && c <= 'F')
    return c - 'A' + 10;
  if(c >= 'a' && c <= 'f')
    return c - 'a' + 10;
  return -1; // can use byte if not -1
}

int color_value(char a, char b) {
  return hex2int(a)*16 + hex2int(b) ;
}

void rgb_led_on(char r, char g, char b, byte r_pin, byte g_pin, byte b_pin) {
  analogWrite(r_pin, r);
  analogWrite(g_pin, g);
  analogWrite(b_pin, b);  
}

void setup() 
{ 
  Serial.begin(9600);
} 

void loop() 
{ 
  if (Serial.available() == 7) {
    first_byte = Serial.read();

    if (first_byte == '#') {
      byte1 = Serial.read();
      byte2 = Serial.read();
      byte3 = Serial.read();
      byte4 = Serial.read();
      byte5 = Serial.read();
      byte6 = Serial.read();

      rgb_led_on(color_value(byte1, byte2), color_value(byte3, byte4), color_value(byte5, byte6), r_pin, g_pin, b_pin);
    }
  }
}
