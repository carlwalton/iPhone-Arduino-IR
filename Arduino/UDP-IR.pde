#include <SPI.h>         // needed for Arduino versions later than 0018
#include <Ethernet.h>     // standard Ethernet library
#include <Udp.h>         // UDP library from: bjoern@cs.stanford.edu 12/30/2008
#include <IRremote.h>    //IR Library

//***************DEFINE VARIABLES***********************
byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED}; //enter a meaningful MAC here, if you care.
byte ip[] = {192,168,1,169}; //enter an IP in your LAN.
unsigned int localPort = 8888; // local port to listen on, make sure your router/firewall doesn't block this.
IRsend irsend; //define irsend as being part of the IRsend library.
byte remoteIp[4];        // holds received packet's originating IP
unsigned int remotePort; // holds received packet's originating port
char echoStream[255] = "0";
int echoType = 0;
unsigned long long echoCode = 0;
int echoSize = 0;
int i = 1;
int s = 0;
//*************END OF VARIABLE DEFINITIONS**************

void setup() 
{
  Ethernet.begin(mac,ip);  // start the Ethernet
  Udp.begin(localPort);    // start UDP
}

void loop() 
{
  // if there's data available, read a packet
  int packetSize = Udp.available(); // note that this includes the UDP header
  
  if(packetSize)
  {
    packetSize = packetSize - 8;      // subtract the 8 byte header
    Udp.readPacket(echoStream,255, remoteIp, remotePort); //read the remaining packet
    
  switch (i) 
    {
	case 1:
          echoType = atoi(echoStream); //This should be 1,2,3 (RC5,RC6,NEC).
          i = 2;
          break;
          
        case 2:
           echoCode = strtol(echoStream,NULL,16); //This is the code itself.
           i = 3;
           break;
           
        case 3:
           echoSize = atoi(echoStream); //This is the size of the code to send.
           i = 1; //when program loops i starts from top again.
           s = 1; //all needed variables gathered, begin decoding/sending.
           break;
           
        default: //If error, reset all to 0. Start again.
         echoType = 0;
         echoCode = 0;
         echoSize = 0;
         i = 1;
        
    } //end of switch
  } //end of if statement. Packetsize analysis complete.

if (s == 1) //if 3 packets have been successfully read
{
  switch (echoType) 
  {
	case 1:
        irsend.sendRC5(echoCode,echoSize); //RC5 code output
        break;
        
        case 2:
        irsend.sendRC6(echoCode,echoSize); //RC6 code output
        break;
        
        case 3:
        irsend.sendNEC(echoCode,echoSize); //NEC output
        break;
        
        case 4:
        irsend.sendSony(echoCode,echoSize); //Sony output
        break;
        
        case 5:
        irsend.sendSharp(echoCode,echoSize); //Sharp output
        break;
        
        case 6:
        irsend.sendDISH(echoCode,echoSize); //Dish output
        break;
        
        default: //Unknown code.
        break;
        
    } //end of output options. Reset time.

  s = 0; //set s back to 0, stopping multi-send.
  }

} //time to loop.
