#import "Manufacturer.h"
#import	"CoreDataHelper.h"
#import "DetailsViewController.h"
#import "Option.h"

@interface RootViewController : UITableViewController {
	NSManagedObjectContext *managedObjectContext;
	NSMutableArray *entityArray;
	NSString *entityName;
	NSPredicate *entitySearchPredicate;
}
-(void) loadLibrary;

@property (nonatomic, retain) NSPredicate *entitySearchPredicate;
@property (nonatomic, retain) NSString *entityName;
@property (nonatomic, retain) NSMutableArray *entityArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
