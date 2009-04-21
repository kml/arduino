int analogInput = 2;
int value = 0;
   
void setup(){
  pinMode(analogInput, INPUT);  
  Serial.begin(9600);
}

void loop(){
  // read the value on analog input
  value = analogRead(analogInput);
  Serial.println(value);
  // wait for a bit to not overload the port
  delay(50);	
}
