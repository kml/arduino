// http://arduino.cc/en/Tutorial/Loop

int timer = 100;                   // The higher the number, the slower the timing.
//int pins[] = { 2, 3, 4, 5, 6, 7 }; // an array of pin numbers
int pins[] = { 12, 11, 7, 6, 5, 4, 3, 8 };
int num_pins = 8;                  // the number of pins (i.e. the length of the array)

int pushbuttonPin = 2;

//boolean cont = false;

int speakerPin = 9;
int val = 0;

volatile int state = LOW;

void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'h', 'C' };
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };

  // play the tone corresponding to the note name
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}

void cDurNth(int n, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'h', 'C' };
  playNote(names[n], duration);
}

void setup()
{
  int i;

  for (i = 0; i < num_pins; i++)   // the array elements are numbered from 0 to num_pins - 1
    pinMode(pins[i], OUTPUT);      // set each pin as an output
  pinMode(speakerPin, OUTPUT);
  //pinMode(pushbuttonPin, INPUT);    // declare pushbutton as input
  
  attachInterrupt(0, click, FALLING); // pushbutton at digital pin 2
}

void click()
{
  state = !state;
}

void loop()
{
  int i;
  
  //val = digitalRead(pushbuttonPin);  // read input value
  //if (val == LOW) {         // check if the input is HIGH (button released)
  //  cont = !cont;
  //}
  
  if (state == LOW) return;

  for (i = 0; i < num_pins; i++) { // loop through each pin...
    if (state == LOW) return;
    
    digitalWrite(pins[i], HIGH);   // turning it on,
    cDurNth(i, 300);
    delay(timer);                  // pausing,
    digitalWrite(pins[i], LOW);    // and turning it off.
  }
  for (i = num_pins - 1; i >= 0; i--) { 
    if (state == LOW) return;
    
    digitalWrite(pins[i], HIGH);
    cDurNth(i, 300);
    delay(timer);
    digitalWrite(pins[i], LOW);
  }
}
