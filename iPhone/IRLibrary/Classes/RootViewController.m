#import "RootViewController.h"

@implementation RootViewController

@synthesize managedObjectContext, entityArray, entityName, entitySearchPredicate;


- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = self.entityName;
	
	// Load library if we havn't already done so
	if(self.entityArray == nil)
	{
		[self loadLibrary];
	}
}

-(void) loadLibrary{
	
	if(entitySearchPredicate == nil)
	{
		// Use the CoreDataHelper class to get all objects of the given
		// type sorted by the "Name" key
		NSMutableArray* mutableFetchResults = [CoreDataHelper getObjectsFromContext:self.entityName :@"Name" :YES :managedObjectContext];
		
		self.entityArray = mutableFetchResults;
	}
	else
	{
		// Use the CoreDataHelper class to search for objects using
		// a given predicate, the result is sorted by the "Name" key
		NSMutableArray* mutableFetchResults = [CoreDataHelper searchObjectsInContext:self.entityName :entitySearchPredicate :@"Name" :YES :managedObjectContext];
		self.entityArray = mutableFetchResults;
	}
}



- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
}

- (void)viewDidUnload {
	// Release anything that can be recreated in viewDidLoad or on demand.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [entityArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	NSManagedObject *object = (NSManagedObject *)[entityArray objectAtIndex:indexPath.row];
	
	NSString *CellIdentifier = @"Cell";
	int indicator = UITableViewCellAccessoryNone;
	
	// Check to see if the object has child elements
	if(self.entityName == @"Manufacturer")
	{
		if([[object valueForKey:@"ManufacturerToModel"] count] > 0)
		{
			indicator = UITableViewCellAccessoryDisclosureIndicator;
			CellIdentifier = @"CellWithDisclosure";
		}
	}
	else if(self.entityName == @"Model")
	{		
		if([[object valueForKey:@"ModelToOption"] count] > 0)
		{
			indicator = UITableViewCellAccessoryDisclosureIndicator;
			CellIdentifier = @"CellWithDisclosure";
		}
		
	}
	
	// Create a cell. It's important to differentiate between cells that have indicators and not. That's
	// why the CellIndentifier is changed if the cell has an indicator.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
	
	
	cell.accessoryType = indicator;
	cell.textLabel.text = [object valueForKey:@"Name"];
	
	
    return cell;
}




// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	
	
	if(self.entityName == @"Manufacturer" || self.entityName == @"Model")
	{
		// Get the object the user selected from the array
		NSManagedObject *selectedObject = [entityArray objectAtIndex:indexPath.row];
		
		// Create a new table view of this very same class.
		RootViewController *rootViewController = [[RootViewController alloc]
												  initWithStyle:UITableViewStylePlain];
		
		// Pass the managed object context
		rootViewController.managedObjectContext = self.managedObjectContext;
		NSPredicate *predicate = nil;
		
		
		if(self.entityName == @"Manufacturer")
		{
			rootViewController.entityName = @"Model";
			
			// Create a query predicate to find all child objects of the selected object. 
			predicate = [NSPredicate predicateWithFormat:@"(ModelToManufacturer == %@)", selectedObject];
			
		} 
		else if(self.entityName == @"Model")
		{
			rootViewController.entityName = @"Option";
			
			// Create a query predicate to find all child objects of the selected object.
			predicate = [NSPredicate predicateWithFormat:@"(OptionToModel == %@)", selectedObject];
		}
		
		[rootViewController setEntitySearchPredicate:predicate];
		
		//Push the new table view on the stack
		[self.navigationController pushViewController:rootViewController animated:YES];
		[RootViewController release];
	}
	else if(self.entityName == @"Option")
	{
		// Get the object the user selected from the array
		Option *selectedOption = [entityArray objectAtIndex:indexPath.row];
		
		DetailsViewController *detailsView = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:[NSBundle mainBundle]];
		
		
		detailsView.title = selectedOption.Name;
		detailsView.length = selectedOption.Length;
		detailsView.description = selectedOption.Description;
		detailsView.code = selectedOption.Code;
		
		
		//Push the new table view on the stack
		[self.navigationController pushViewController:detailsView animated:YES];
		[detailsView release];
	}
}
- (void)dealloc {
	if(entitySearchPredicate != nil)
	{
		[entitySearchPredicate release];
	}
	
	[entityName release];
	[managedObjectContext release];
	[entityArray release];
    [super dealloc];
}


@end
