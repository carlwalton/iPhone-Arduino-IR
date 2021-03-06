#import "IRLibraryAppDelegate.h"

@implementation IRLibraryAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {
    
    // Override point for customization after app launch    
	NSManagedObjectContext *context = [self managedObjectContext];
	
	// We're not using undo. By setting it to nil we reduce the memory footprint of the app
	[context setUndoManager:nil];

	if (!context) {
        NSLog(@"Error initializing object model context");
		exit(-1);
    }
	
	// Get the url of the local xml document
	NSURL *xmlURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Data" ofType:@"xml"]];
	
	NSError *parseError = nil;
	
	// Parse the xml and store the results in our object model
	XMLParser *xmlParse = [[XMLParser alloc] initWithContext:context];
	[xmlParse parseXMLFileAtURL:xmlURL parseError:&parseError];
	[xmlParse release];
	

	// Create a table view controller
	RootViewController *rootViewController = [[RootViewController alloc]
											  initWithStyle:UITableViewStylePlain];
	
	rootViewController.managedObjectContext = context;
	rootViewController.entityName = @"Manufacturer";
	
	
	UINavigationController *aNavigationController = [[UINavigationController alloc]
													 initWithRootViewController:rootViewController];
	
    self.navigationController = aNavigationController;
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
	
	[rootViewController release];
    [aNavigationController release];
}


/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			// Handle error
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			exit(-1);  // Fail
        } 
    }
}


#pragma mark -
#pragma mark Saving

/**
 Performs the save action for the application, which is to send the save:
 message to the application's managed object context.
 */
- (IBAction)saveAction:(id)sender {
	
    NSError *error;
    if (![[self managedObjectContext] save:&error]) {
		// Handle error
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
	// Complete url to our database file
	NSString *databaseFilePath = [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"irlibrary.sqlite"];
	
	// if you make changes to your model and a database already exist in the app
	// you'll get a NSInternalInconsistencyException exception. When the model i updated 
	// the databasefile must be removed. I'll always remove the database here becuase it is simple.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager removeItemAtPath:databaseFilePath error:NULL];
	
	if([fileManager fileExistsAtPath:databaseFilePath])
	{
		[fileManager removeItemAtPath:databaseFilePath error:nil];
	}
	
    NSURL *storeUrl = [NSURL fileURLWithPath: databaseFilePath];
	
	NSError *error;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel: [self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        // Handle error
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's documents directory

/**
 Returns the path to the application's documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    return basePath;
}

#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
	
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

