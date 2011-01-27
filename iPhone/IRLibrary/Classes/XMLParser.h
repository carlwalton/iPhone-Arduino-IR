#import <Foundation/Foundation.h>
#import	"CoreDataHelper.h"
#import "Manufacturer.h"
#import "Model.h"
#import "Option.h"

@interface XMLParser : NSObject {
	NSMutableString *contentsOfCurrentProperty;
	NSManagedObjectContext *managedObjectContext;
	Manufacturer *currentManufacturer;
	Model *currentModel;
	
}

@property (retain, nonatomic) NSManagedObjectContext *managedObjectContext;
-(id) initWithContext: (NSManagedObjectContext *) managedObjContext;
-(BOOL)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error;
-(void) emptyDataContext;
@end
