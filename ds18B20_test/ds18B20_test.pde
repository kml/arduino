/* ds18B20_test

  Test utility to configure resolution and read temp from the Dallas Semi 18B20 
  one-wire digital temp sensor.
  
  source:    http://www.netfluvia.org/code/ds18B20_test.pde
  datasheet: http://datasheets.maxim-ic.com/en/ds/DS18B20.pdf

  Derived from sample code at http://www.arduino.cc/playground/Learning/OneWire

*/

#include <OneWire.h>

#define BAUDRATE 9600
#define TEMPSENSOR 3  // arduino i/o port connected to the ds18B20
//#define DEBUG         // uncomment for verbose output

/* some defines to make more legible checks into data read from the device 
 *   (see the DS18B20 datasheet for more detail)
 */ 
#define TEMP_LSB 0
#define TEMP_MSB 1
#define TH_REG 2
#define USERBYTE_1 2
#define TL_REG 3
#define USERBYTE_2 3
#define CONFIG_REG 4
#define CRC 8

OneWire ds(TEMPSENSOR); 

void setup() {
  Serial.begin(BAUDRATE);
}

/* convert celsius to fahrenheit
 *
 *   takes: float
 * returns: float
 */
float c2f(float cel) {
  return (cel * (9.0/5.0)) + (float)32;
}

/* read temp from DS18B20 sensor using one-wire protocol */
void loop() {

  byte i;
  byte present = 0;
  byte data[12];
  byte addr[8];

  int temp_c_int;
  float temp_c_frac;
  float temp_c;
  float temp_f;
  int test_bit;
  int set_bit;
  int resolution_floor;
  float expon;
  
  if ( !ds.search(addr)) {
      ds.reset_search();
      return;
  }

  /* print the address - might be useful for non-debug mode if you have
   *   >1 devices on the bus
   */
#ifdef DEBUG
  Serial.print("R=");
  for( i = 0; i < 8; i++) {
    Serial.print(addr[i], HEX);
    Serial.print(" ");
  }
#endif

  if ( OneWire::crc8( addr, 7) != addr[7]) {
      Serial.print("CRC is not valid!\n");
      return;
  }

  if ( addr[0] != 0x28) {
      Serial.print("Device is not a DS18B20 family device.\n");
      return;
  }

  /* modify scratchpad register to set temp sampling resolution */
  ds.reset();
  ds.select(addr);    
  ds.write(0x4E);          // write scratchpad (starts at byte 2)
  // note:  set high/low temp alarms by changing the next two values 
  ds.write(0x4B);    // default value of TH reg (user byte 1)
  ds.write(0x46);    // default value of TL reg (user byte 2)
  // uncomment one of the following
  //ds.write(0x7F);    // 12-bit sampling resolution (default)
  //ds.write(0x5F);    // 11-bit
  //ds.write(0x3F);    // 10-bit
  ds.write(0x1F);    // 9-bit

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);    // start conversion, with parasite power on at the end

  delay(1000);     // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.

  present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE);          // Read Scratchpad

  if (!present) {
    Serial.print("ERROR: selected device not present\n");
    return;
  }
  
  for ( i = 0; i < 9; i++) {           // we need 9 bytes
    data[i] = ds.read();
#ifdef DEBUG
    Serial.print(data[i], HEX);
    Serial.print(" ");
#endif
  }

  if (data[8] != OneWire::crc8(data,8)) {
    Serial.print("ERROR: CRC didn't match\n");
    return;
  }
  
  /* print raw bytes from which we'll extract temp data */
#ifdef DEBUG 
  Serial.print("[MSB:");
  Serial.print(data[TEMP_MSB],BIN);
  Serial.print(" LSB:");
  Serial.print(data[TEMP_LSB],BIN);
  Serial.print("] ");
#endif
  
  /* compute the degrees in celcius / integer part */
  temp_c_int = 0;
  
  /* The measured temp is spread across two bytes of the returned data.
   *  The integer part of the temp value is spread across the least 3 significant
   *  bits of the most significant byte (MSB) and the most significant 4 of 
   *  the LSB.  Here we shift those 7 bits into their proper place in our
   *  result byte. 
   *
   * note: could do this with 2 bit-shift / mask operations, alternatively
   */
  set_bit = 6;
  for (test_bit = 2; test_bit >= 0; test_bit--) {
    temp_c_int |= ( ((data[TEMP_MSB] & (1 << test_bit)) >> test_bit) << set_bit );
    set_bit--;
  }
  for (test_bit = 7; test_bit >= 4; test_bit--) {
    temp_c_int |= ( ((data[TEMP_LSB] & (1 << test_bit)) >> test_bit) << set_bit );
    set_bit--;
  }

#ifdef DEBUG
  Serial.print(temp_c_int,DEC);
#endif

  /* compute the fractional part */

  /*  first figure out what resolution we're measuring in - varies between 1 and 4 bits
   *    after the decimal (based on the contents of the CONFIG_REG byte):
   *        bit 6 == 0 && bit 5 == 0 --> 9-bit resolution (ignore 3 least sig bits)
   *        bit 6 == 0 && bit 5 == 1 --> 10-bit resolution (ignore 2 least sig bits)
   *        bit 6 == 1 && bit 5 == 0 --> 11-bit resolution (ignore 1 least sig bits)
   *        bit 6 == 1 && bit 5 == 1 --> 12-bit resolution   
   */
  if ((data[CONFIG_REG] & (1 << 5)) > 0) {        
    if ((data[CONFIG_REG] & (1 << 4)) > 0) {      // bits 6 and 5 are set
      resolution_floor = 0;
    } else {                                      // bit 6 is set, 5 is clear
      resolution_floor = 1;
    }
  } else {
    if ((data[CONFIG_REG] & (1 << 4)) > 0) {      // bits 6 is clear, 5 is set
      resolution_floor = 2;
    } else {                                      // bit 6 and 5 are clear
      resolution_floor = 3;
    }
  }    

  temp_c_frac = 0;
  for (test_bit = 3; test_bit >= resolution_floor; test_bit--) {
    if ((data[TEMP_LSB] & (1 << test_bit)) > 0) {
      expon = test_bit - 4; // will be negative
      temp_c_frac += pow(2,expon);
    }
  }
#ifdef DEBUG
  Serial.print(" ");
  Serial.print(temp_c_frac * 10000,DEC);
#endif

  /* put it all together */
  temp_c = (float)temp_c_int + temp_c_frac;  

  if ((data[TEMP_MSB] & (1 << 7)) > 0) {   // the temp is negative
    temp_c *= -1;
  }

  temp_f = c2f(temp_c);
  
  Serial.print(" Cx10k=");
  Serial.print(temp_c * 10000,DEC); // Serial.print truncates after the decimal pt
  Serial.print(" Fx10k=");
  Serial.print(temp_f * 10000,DEC);
  
  Serial.print("\n");
  
  delay(5000);
}
