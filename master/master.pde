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
  static int i=2;
  if (i==3) i=2;
  int reply = SPI_Write(i);
  i++;
  delay(1000);
}

int SPI_Write(int request) {
  // take the SS pin low to select the chip
  digitalWrite(slaveSelectPin,LOW);

  // send request to SPI
  SPI.transfer(request);
  
  // wait for write on slave
  delay(100);
  
  // transfer dummy bits and get response
  int replyhigh = SPI.transfer(0x00);
  // have to stick in this janky delay to get good data reply from slave
  delay(100);
  int replylow = SPI.transfer(0x00);
  
  int reply = replyhigh * 256 + replylow;
  // take the SS pin high to de-select the chip:
  digitalWrite(slaveSelectPin, HIGH);

  Serial.print("request = ");
  Serial.println(request, HEX);
  Serial.print("reply   = ");
  Serial.println(replyhigh, HEX);
  Serial.print("reply   = ");
  Serial.println(replylow, HEX);
  Serial.print("reply   = ");
  Serial.println(reply, HEX);

  Serial.println();
  
  return replyhigh; 
}
