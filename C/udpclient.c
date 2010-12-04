#include <stdio.h>      /* for printf() and fprintf() */
#include <sys/socket.h> /* for socket(), connect(), sendto(), and recvfrom() */
#include <arpa/inet.h>  /* for sockaddr_in and inet_addr() */
#include <stdlib.h>     /* for atoi() and exit() */
#include <string.h>     /* for memset() */
#include <unistd.h>     /* for close() */

#define ECHOMAX 255     /* Longest string to echo */

void DieWithError(char *errorMessage);  /* External error handling function */

int main(int argc, char *argv[])
{
    int sock;                        /* Socket descriptor */
    struct sockaddr_in echoServAddr; /* Echo server address */
    unsigned short echoServPort;     /* Echo server port */
    char *servIP;                    /* IP address of server */
    //char *echoString;                /* String to send to echo server *
	char *echoCode;

	

    int echoStringLen = ECHOMAX;               /* Length of string to echo */
	
    if ((argc < 3) || (argc > 4))    /* Test for correct number of arguments */
    {
        fprintf(stderr,"Usage: %s <Server IP> <Echo Code> [<Echo Port>]\n", argv[0]);
        exit(1);
    }
	
    servIP = argv[1];           /* First arg: server IP address (dotted quad) */
    echoCode = argv[2]; /* Second arg: string to echo */
		
   // if ((echoStringLen = strlen(*echoCode)) > ECHOMAX)  /* Check input length */
       // DieWithError("Echo word too long");
	
    if (argc == 4)
        echoServPort = atoi(argv[3]);  /* Use given port, if any */
    else
        echoServPort = 8888;  /* port 8888 defined on arduino */
	
    /* Create a datagram/UDP socket */
	

		
    if ((sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_UDP)) < 0)
        DieWithError("socket() failed");
	
    /* Construct the server address structure */
    memset(&echoServAddr, 0, sizeof(echoServAddr));    /* Zero out structure */
    echoServAddr.sin_family = AF_INET;                 /* Internet addr family */
    echoServAddr.sin_addr.s_addr = inet_addr(servIP);  /* Server IP address */
    echoServAddr.sin_port   = htons(echoServPort);     /* Server port */
	
    /* Send the string to the server */
				if (sendto(sock, echoCode, echoStringLen, 0, (struct sockaddr *) 
						   &echoServAddr, sizeof(echoServAddr)) != echoStringLen)
					DieWithError("sendto() sent a different number of bytes than expected");

		
	
     close(sock);

    exit(0);
}