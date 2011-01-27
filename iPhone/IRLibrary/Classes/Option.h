#import <CoreData/CoreData.h>

@class Model;

@interface Option :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * Description;
@property (nonatomic, retain) NSNumber * Length;
@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSString * Code;
@property (nonatomic, retain) Model * OptionToModel;

@end



