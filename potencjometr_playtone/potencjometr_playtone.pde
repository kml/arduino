
int speakerPin = 9;
int ledPin = 13; // choose the pin for the LED
int analogPotentiometerInput = 2;

int value = 0;     // variable for reading the pin status
int tempo = 300;

int tone = 0;

void setup() {
  pinMode(speakerPin, OUTPUT);
  pinMode(ledPin, OUTPUT);  // declare LED as output
  pinMode(analogPotentiometerInput, INPUT);
}

void loop(){
  value = analogRead(analogPotentiometerInput);
  if (value) {
    // play between 956 C (excluded) and 1915 c
    // 1915 - 956 = 959
    //
    // value is between 0 and 1023
    //
    // value - 1023
    // tone - 959
    //
    tone = 959 * value / 1023 + 956;
    playTone(tone, 2 * tempo);
  }
  delay(1000);
}

void playTone(int tone, int duration) {
  for (long i = 0; i < duration * 1000L; i += tone * 2) {
    digitalWrite(speakerPin, HIGH);
    delayMicroseconds(tone);
    digitalWrite(speakerPin, LOW);
    delayMicroseconds(tone);
  }
}

void playNote(char note, int duration) {
  char names[] = { 'c', 'd', 'e', 'f', 'g', 'a', 'b', 'C' };
  int tones[] = { 1915, 1700, 1519, 1432, 1275, 1136, 1014, 956 };

  // play the tone corresponding to the note name
  for (int i = 0; i < 8; i++) {
    if (names[i] == note) {
      playTone(tones[i], duration);
    }
  }
}
