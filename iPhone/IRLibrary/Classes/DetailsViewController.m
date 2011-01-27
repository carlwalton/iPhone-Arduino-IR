#import "DetailsViewController.h"

#include <stdio.h>      /* for printf() and fprintf() */
#include <sys/socket.h> /* for socket(), connect(), sendto(), and recvfrom() */
#include <arpa/inet.h>  /* for sockaddr_in and inet_addr() */
#include <stdlib.h>     /* for atoi() and exit() */
#include <string.h>     /* for memset() */
#include <unistd.h>     /* for close() */

#define ECHOMAX 255     /* Longest string to echo */

int sock;                        /* Socket descriptor */
struct sockaddr_in echoServAddr; /* Echo server address */


//const char *echoCode;					//message to be sent via UDP

int echoStringLen = ECHOMAX;


void sendPacket(const char *echoCode)
{
	
	const char *echoServIP = "192.168.0.109";                   // IP address of server 
	unsigned short echoServPort = 8888;     // Echo server port 
	
	
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

@implementation DetailsViewController
@synthesize titleLabel, descriptionLabel, inhabitantsLabel, descriptionScrollView, phoneButton;
@synthesize OptionName, length, description, code;



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

	[self.titleLabel setText:self.title];
	[self.inhabitantsLabel setText:[NSString stringWithFormat:@"Length: %@", length]];
	[self.descriptionLabel setText:self.description];
	
	float textHeight = [MLUtils calculateHeightOfTextFromWidth:self.description : descriptionLabel.font :descriptionLabel.frame.size.width :UILineBreakModeWordWrap];
	
	CGRect frame = descriptionLabel.frame;
	frame.size.height = textHeight;
	descriptionLabel.frame = frame;
	
	CGSize contentSize = descriptionScrollView.contentSize;
	contentSize.height = textHeight;
	descriptionScrollView.contentSize = contentSize;
	
	
	phoneButton.hidden = (self.code == nil || [self.code isEqualToString:@""] == YES);
}


-(IBAction) phoneButtonClicked:(id)sender
{

		//packets need to be sent in the following order: 
		//1. codeType(rc5,rc6) 
		//2. codeValue (0x12345) 
		//3. codeSize(24,32)
		
		const char *echoCode;
		
		//type
		echoCode = [code UTF8String];
		sendPacket(echoCode);
		//code
		echoCode = [description UTF8String]; 
		sendPacket(echoCode);
		//length
		NSString *buf = [length stringValue];
		echoCode = [buf UTF8String];
		sendPacket(echoCode);

}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[titleLabel release];
	[descriptionLabel release];
	[inhabitantsLabel release];
	[descriptionScrollView release];
	[phoneButton release];
	[OptionName release];
	[length release];
	[description release];
    [super dealloc];
}


@end
