/*
*  ap_ReadAnalog
*  
*  Reads an analog input from the input pin and sends the value 
*  followed by a line break over the serial port. 
* 
*  This file is part of the Arduino meets Processing Project:
*  For more information visit http://www.arduino.cc.
*
*  copyleft 2005 by Melvin Ochsmann for Malmš University
*
*/

// variables for input pin and control LED
  int analogInput = 2;
  int LEDpin = 13;
  
// variable to store the value 
  int value = 0;
  
// a threshold to decide when the LED turns on
  int threshold = 512;
  int second = 1000;
  int changes = 0;
  
  //int count = 0;
  int last  = 0;
  int now   = 0;
void setup(){

// declaration of pin modes
  pinMode(analogInput, INPUT);
  pinMode(LEDpin, OUTPUT);
  
  last = analogRead(analogInput);
  
// begin sending over serial port
  //beginSerial(9600);
}

void loop(){
  // read the value on analog input
  value = analogRead(analogInput);

  if (value < threshold) 
    now = 0;
  else
    now = 1;
  
  if (last == -1)
    last = now;
    
  if (last != now)
    changes += 1;
  
  if (changes % 3) {
    digitalWrite(LEDpin, LOW);
  } else {
    digitalWrite(LEDpin, HIGH);
    //delay(second * 2);
    //changes = 0;    
  }

  // print out value over the serial port
  //printInteger(value);

  // and a signal that serves as seperator between two values 
  //printByte(10);

  // wait for a bit to not overload the port
  
  last = now;
  delay(10);	
}
