#import "XMLParser.h"

@implementation XMLParser
@synthesize managedObjectContext;

-(id) initWithContext: (NSManagedObjectContext *) managedObjContext
{
	self = [super init];
	[self setManagedObjectContext:managedObjContext];
	
	return self;
}


- (BOOL)parseXMLFileAtURL:(NSURL *)URL parseError:(NSError **)error
{
	BOOL result = YES;
	
	// /Applications/MyExample.app/MyFile.xml
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
   [parser setDelegate:self];
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
    [parser parse];
    
    NSError *parseError = [parser parserError];
    if (parseError && error) {
        *error = parseError;
		result = NO;
    }
    
    [parser release];
	
	return result;
}

-(void) emptyDataContext
{
	// List all available manufacturers, this is the first screen the user will see
	NSMutableArray* mutableFetchResults = [CoreDataHelper getObjectsFromContext:@"Manufacturer" :@"Name" :NO :managedObjectContext];

	// Remove all manufacturers.
	for (int i = 0; i < [mutableFetchResults count]; i++) {
		[managedObjectContext deleteObject:[mutableFetchResults objectAtIndex:i]];
		
	}

	
	// Update the data model effectivly removing the objects we removed above.
	NSError *error;
	if (![managedObjectContext save:&error]) {
		
		// Handle the error.
		NSLog(@"%@", [error domain]);
	}
}


- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if (qName) {
        elementName = qName;
    }
	
	// If it's the start of the XML, remove everything we've stored so far
	if([elementName isEqualToString:@"loc"])
	{
		[self emptyDataContext];
		return;
	}
    
	// Create a new Manufacturer
    if ([elementName isEqualToString:@"manufacturer"]) 
	{
        currentManufacturer = (Manufacturer *)[NSEntityDescription insertNewObjectForEntityForName:@"Manufacturer" inManagedObjectContext:managedObjectContext];
		[currentManufacturer setName:[attributeDict objectForKey:@"name"]];
		
        return;
    }
	// Create a new Model
	else if ([elementName isEqualToString:@"model"])
	{
		currentModel = (Model *)[NSEntityDescription insertNewObjectForEntityForName:@"Model" inManagedObjectContext:managedObjectContext];
		[currentModel setName:[attributeDict objectForKey:@"name"]];
		
		// Add the model as a child to the current manufacturer
		[currentManufacturer addManufacturerToModelObject:currentModel];
    } 
	else if([elementName isEqualToString:@"option"])
	{
		Option *o = (Option *)[NSEntityDescription insertNewObjectForEntityForName:@"Option" inManagedObjectContext:managedObjectContext];
		[o setName:[attributeDict objectForKey:@"name"]];
		[o setDescription:[attributeDict objectForKey:@"desc"]];
		[o setLength:[NSNumber numberWithInt:[[attributeDict objectForKey:@"length"] intValue]]];
		[o setCode:[attributeDict objectForKey:@"code"]];

		[currentModel addModelToOptionObject:o];

	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
    if (qName) {
        elementName = qName;
    }
    
	// If we're at the end of a manufacturer. Save changes to object model
	if ([elementName isEqualToString:@"manufacturer"]) 
	{
		// Sanity check
		if(currentManufacturer != nil)
		{
			NSError *error;
			
			// Store what we imported already
			if (![managedObjectContext save:&error]) {
				
				// Handle the error.
				NSLog(@"%@", [error domain]);
			}
		}
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	// We're not reading any text-element data.
}

-(void)dealloc
{
	[managedObjectContext release];
	[super dealloc];
}



@end
