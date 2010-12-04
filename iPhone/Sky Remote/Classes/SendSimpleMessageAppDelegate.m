//
//  SendSimpleMessageAppDelegate.m
//  SendSimpleMessage
//
//  Created by Carl Walton on 03/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SendSimpleMessageAppDelegate.h"

#include <stdio.h>      /* for printf() and fprintf() */
#include <sys/socket.h> /* for socket(), connect(), sendto(), and recvfrom() */
#include <arpa/inet.h>  /* for sockaddr_in and inet_addr() */
#include <stdlib.h>     /* for atoi() and exit() */
#include <string.h>     /* for memset() */
#include <unistd.h>     /* for close() */

#define ECHOMAX 255     /* Longest string to echo */

int sock;                        /* Socket descriptor */
struct sockaddr_in echoServAddr; /* Echo server address */


const char *echoServIP;                   // IP address of server 
unsigned short echoServPort;     // Echo server port 
const char *echoCode;					//message to be sent via UDP

int echoStringLen = ECHOMAX;

@implementation SendSimpleMessageAppDelegate

@synthesize window;

void sendPacket(const char *echoServIP, unsigned short echoServPort, const char *echoCode)
{
	if ((sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0) //if the socket can't be created, error.
		return;
	
	
    memset(&echoServAddr, 0, sizeof(echoServAddr));    // Zero out structure 
    echoServAddr.sin_family = AF_INET;                 // Internet addr family 
    echoServAddr.sin_addr.s_addr = inet_addr(echoServIP);  // Server IP address 
    echoServAddr.sin_port   = htons(echoServPort);     // Server port
	
	
	if (sendto(sock, echoCode, echoStringLen, 0, (struct sockaddr *) //send the message (echoCode) out of the echoServer.
			   &echoServAddr, sizeof(echoServAddr)) != echoStringLen)
		return; //if sendto() fails, error.
	
	close(sock); //close the socket.	
	
	return;
	
}


/*
 echoCode definitions
 
 1 = RC5
 2 = RC6
 3 = NEC
 4 = SONY
 
 */


- (IBAction)ChannelUp
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C20";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}


- (IBAction)ChannelDown
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C21";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)Num1
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C01";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)Num2
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C02";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num3
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C03";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num4
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C04";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num5
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C05";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num6
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C06";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num7
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C07";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num8
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C08";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num9
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C09";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)Num0
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C00";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)VolumeUp
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "1";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0x850";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "12";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)VolumeDown
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "1";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0x851";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "12";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)UpArrow
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C58";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}
- (IBAction)LeftArrow
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C5A";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)DownArrow
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C59";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)RightArrow
{
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xC05C5B";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}

- (IBAction)XBoxOn
{
	
	//this doesn't work yet as I don't know how to convert the char array in the
	//arduino to a long long (echoCode)
	echoServIP = "192.168.1.169";
	echoServPort = 8888;
	echoCode = "2";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "0xc800f740cLL";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
	echoCode = "24";
	sendPacket(echoServIP,echoServPort,echoCode);
	[NSThread sleepForTimeInterval:0.1];
}


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
