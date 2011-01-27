#import <CoreData/CoreData.h>

@class Model;

@interface Manufacturer :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * Name;
@property (nonatomic, retain) NSSet* ManufacturerToModel;

@end


@interface Manufacturer (CoreDataGeneratedAccessors)
- (void)addManufacturerToModelObject:(Model *)value;
- (void)removeManufacturerToModelObject:(Model *)value;
- (void)addManufacturerToModel:(NSSet *)value;
- (void)removeManufacturerToModel:(NSSet *)value;

@end

