#include <LiquidCrystal.h>
#include <OneWire.h>

float temp, min = 150, max = -150;
int p = 0;

OneWire ds(0);

// LiquidCrystal(rs, rw, enable, d4, d5, d6, d7) 
LiquidCrystal lcd(13, 12, 11, 10, 9, 8, 7);

void setup() {
  lcd.begin(16, 2);

  lcd.print("PluszTermo 1.0");
  lcd.setCursor(0, 1);
  lcd.print("kml.jogger.pl");

  delay(5000);

  lcd.clear();
}

void loop(){ 
  int HighByte, LowByte, TReading, SignBit, Tc_100, Whole, Fract;

  byte i;
  byte present = 0;
  byte data[12];
  byte addr[8];

  if ( !ds.search(addr)) {
    //Serial.print("No more addresses.\n");
    ds.reset_search();
    return;
  }

  //Serial.print("R=");
  //for( i = 0; i < 8; i++) {
  //  Serial.print(addr[i], HEX);
  //  Serial.print(" ");
  //}

  if ( OneWire::crc8( addr, 7) != addr[7]) {
    lcd.clear();
    lcd.print("CRC != valid!\n");
    return;
  }

  if ( addr[0] != 0x28) {
    lcd.clear();
    lcd.print("Device != DS18S20.\n");
    return;
  }

  ds.reset();
  ds.select(addr);
  ds.write(0x44,1);         // start conversion, with parasite power on at the end

  delay(1000);     // maybe 750ms is enough, maybe not
  // we might do a ds.depower() here, but the reset will take care of it.

  present = ds.reset();
  ds.select(addr);    
  ds.write(0xBE);         // Read Scratchpad

  //Serial.print("P=");
  //Serial.print(present,HEX);
  //Serial.print(" ");
  for ( i = 0; i < 9; i++) {           // we need 9 bytes
    data[i] = ds.read();
    //Serial.print(data[i], HEX);
    //Serial.print(" ");
  }
  //Serial.print(" CRC=");
  //Serial.print( OneWire::crc8( data, 8), HEX);
  //Serial.println();


  LowByte = data[0];
  HighByte = data[1];
  TReading = (HighByte << 8) + LowByte;
  SignBit = TReading & 0x8000;  // test most sig bit
  if (SignBit) // negative
  {
    TReading = (TReading ^ 0xffff) + 1; // 2's comp
  }
  Tc_100 = (6 * TReading) + TReading / 4;    // multiply by (100 * 0.0625) or 6.25

  lcd.setCursor(0,0);
  lcd.print("T = "); // Cx100
  temp = (float)Tc_100 / 100;
  if (SignBit) // If its negative
  {
    temp *= -1;
  }  
  lcd.print(temp);
  lcd.write(0xDF);
  lcd.write('C'); 

  if(temp < min)
    min = temp;

  if(temp > max)
    max = temp;

  if(p < 3)
  {
    lcd.setCursor(0,1);
    lcd.print("Min = ");
    lcd.print(min);
    lcd.write(0xDF);
    lcd.write('C');
    p++;
  }
  else
  {
    lcd.setCursor(0,1);
    lcd.print("Max = ");
    lcd.print(max);
    lcd.write(0xDF);
    lcd.write('C');
    p++;
    if(p == 6)
      p = 0;
  }

  delay(3000);
}
