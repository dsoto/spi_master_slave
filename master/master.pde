// inslude the SPI library:
#include <SPI.h>

// set pin 10 as the slave select for the digital pot:
const int slaveSelectPin = 10;

void setup() {
  // set the slaveSelectPin as an output:
  pinMode (slaveSelectPin, OUTPUT);
  // initialize SPI:
  SPI.begin(); 
  Serial.begin(9600);
}

void loop() {
  static int i=1;
  if (i==3) i=1;
  int reply = SPI_Write(i);
  Serial.print("request = ");
  Serial.println(i, HEX);
  Serial.print("reply   = ");
  Serial.println(reply, HEX);
  Serial.println();
  i++;
  delay(1000);
}

int SPI_Write(int request) {
  // take the SS pin low to select the chip:
  digitalWrite(slaveSelectPin,LOW);

  // send request to SPI
  SPI.transfer(request);
  
  // transfer dummy bits and get response
  int reply = SPI.transfer(0x00);
  
  // take the SS pin high to de-select the chip:
  digitalWrite(slaveSelectPin,HIGH);
  
  return reply; 
}