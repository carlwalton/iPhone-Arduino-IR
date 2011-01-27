#import <CoreData/CoreData.h>

@class Option;
@class Manufacturer;

@interface Model :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSSet* ModelToOption;
@property (nonatomic, retain) Manufacturer * ModelToManufacturer;

@end


@interface Model (CoreDataGeneratedAccessors)
- (void)addModelToOptionObject:(Option *)value;
- (void)removeModelToOptionObject:(Option *)value;
- (void)addModelToOption:(NSSet *)value;
- (void)removeModelToOption:(NSSet *)value;

@end

