#include <LiquidCrystal.h>

// LiquidCrystal(rs, rw, enable, d4, d5, d6, d7) 
LiquidCrystal lcd(13, 12, 11, 10, 9, 8, 7);

void setup() {
 lcd.begin(16, 2);
 lcd.print("Bieduino 1.0");
 lcd.setCursor(0, 1);
 lcd.print("kml.jogger.pl");
}

void loop() {
}
