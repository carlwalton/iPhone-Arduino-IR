
#include <IRremote.h>

IRsend irsend;

void setup()
{
  Serial.begin(9600);
}

void loop() {
    for (int i = 0; i < 3; i++) {
      Serial.println("sent code");
      irsend.sendRC5(0x850, 12); // RC5 TV volume up button
      delay(100);
    }
}

