
#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>     // standard Ethernet library
#include <Udp.h>         // UDP library from: bjoern@cs.stanford.edu 12/30/2008
#include <IRremote.h>    //IR Library

byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
byte ip[] = {192,168,1,169};
unsigned int localPort = 8888;      // local port to listen on
IRsend irsend;
byte remoteIp[4];        // holds received packet's originating IP
unsigned int remotePort; // holds received packet's originating port
char echoType[255] = "0";
char echoStream[255] = "0";
unsigned long echoCode = 0;
int echoSize = 0;
int i = 1;
int s = 0;

void setup() {
  // start the Ethernet, UDP and serial comms
  Ethernet.begin(mac,ip);
  Udp.begin(localPort);
  Serial.begin(9600);
}

void loop() 
{
  // if there's data available, read a packet
  int packetSize = Udp.available(); // note that this includes the UDP header
  
  if(packetSize)
  {
    packetSize = packetSize - 8;      // subtract the 8 byte header
    Serial.print("Received packet of size ");
    Serial.println(packetSize);
    Udp.readPacket(echoStream,255, remoteIp, remotePort);
       
       if (i == 1)
        {
          strcpy(echoType, echoStream);
          i = 2;
          s = 0;
        }  
            else if (i == 2)
            {
                echoCode = strtol(echoStream,NULL,16);
                i = 3;
            }  
               else if (i == 3)
               {
                  echoSize = atoi(echoStream);
                  i = 1;
                  s = 1;
               }
   } //end of main if (packetsize)
  

if (s == 1) //if 3 packets have been successfully read
{
 irsend.sendNew(echoType,echoCode,echoSize); //output the code
 s = 0; //set s back to 0, resetting the unit
}

}
