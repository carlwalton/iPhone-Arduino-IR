//
//  SendSimpleMessageAppDelegate.h
//  SendSimpleMessage
//
//  Created by Carl Walton on 03/12/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SendSimpleMessageAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}


- (IBAction)ChannelUp;
- (IBAction)ChannelDown;
- (IBAction)VolumeUp;
- (IBAction)VolumeDown;
- (IBAction)Num1;
- (IBAction)Num2;
- (IBAction)Num3;
- (IBAction)Num4;
- (IBAction)Num5;
- (IBAction)Num6;
- (IBAction)Num7;
- (IBAction)Num8;
- (IBAction)Num9;
- (IBAction)Num0;
- (IBAction)UpArrow;
- (IBAction)LeftArrow;
- (IBAction)DownArrow;
- (IBAction)RightArrow;
- (IBAction)XBoxOn;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

