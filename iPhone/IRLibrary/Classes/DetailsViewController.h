#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MLUtils.h"


@interface DetailsViewController : UIViewController <MFMailComposeViewControllerDelegate>{
	IBOutlet UILabel *titleLabel;
	IBOutlet UILabel *inhabitantsLabel;
	IBOutlet UIButton *phoneButton;
	IBOutlet UILabel *descriptionLabel;
	IBOutlet UIScrollView *descriptionScrollView;
	NSString *OptionName;
	NSNumber *length;
	NSString *description;
	NSString *code;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *inhabitantsLabel;
@property (nonatomic, retain) UILabel *descriptionLabel;
@property (nonatomic, retain) UIButton *phoneButton;
@property (nonatomic, retain) UIScrollView *descriptionScrollView;

@property (nonatomic, retain) NSString *OptionName;
@property (nonatomic, retain) NSString *description;
@property (nonatomic, retain) NSNumber *length;
@property (nonatomic, retain) NSString *code;


-(IBAction) phoneButtonClicked:(id)sender;


@end
