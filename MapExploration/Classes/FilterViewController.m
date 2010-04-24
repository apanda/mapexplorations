//
//  FilterView.m
//  MapExploration
//
//  Created by Aurojit Panda on 4/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FilterViewController.h"


@implementation FilterViewController


- (id)initWithAppDelegate: (MapExplorationAppDelegate*) delegate { //WithStyle:(UITableViewStyle)style withAppDelegate:(MapExplorationAppDelegate*)delegate{
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super init]) {//WithStyle:style]) {
		m_indoor = [[[UISwitch alloc] init] retain];
		m_backboard = [[[UISwitch alloc] init] retain];
		m_lights = [[[UISwitch alloc] init] retain];
		
		m_courts = [[[UISlider alloc] init] retain];
		m_courts.minimumValue = 0;
		m_courts.maximumValue = 10;
		
		m_rating = [[[UISlider alloc] init] retain];
		m_rating.minimumValue = 0;
		m_rating.maximumValue = 5;
		
		self.tableViewStyle = UITableViewStyleGrouped;
		self.autoresizesForKeyboard = YES;
		self.variableHeightRows = YES;
		[TTStyleSheet setGlobalStyleSheet:[[TTDefaultStyleSheet alloc] init]];
		TTTableControlItem *lightControl = [TTTableControlItem itemWithCaption:@"Lights" control:m_lights];
		//TTTableControlItem *indoorControl = [TTTableControlItem itemWithCaption:@"Indoor" control:m_indoor];
		TTTableControlItem *backboardControl = [TTTableControlItem itemWithCaption:@"Backboard" control:m_backboard];
		TTTableControlItem *courtsControl = [TTTableControlItem itemWithCaption:@"Courts" control:m_courts];
		TTTableControlItem *ratingControl = [TTTableControlItem itemWithCaption:@"Rating" control:m_rating];
		self.dataSource = [TTListDataSource dataSourceWithObjects:
						   lightControl,
						   //indoorControl,
						   backboardControl,
						   courtsControl,
						   ratingControl,
						   nil];
		m_delegate = delegate;
    }
    return self;
}

- (bool) lights {
	return m_lights.on;
}

- (bool) backboard {
	return m_backboard.on;
}

- (bool) indoor {
	return m_indoor.on;
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	self.tableView.editing = NO;
	self.title = @"Filter";
	[m_delegate showNavigationBar];
	[m_delegate hideToolbar];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
	UITableViewCell *cell;
	int index = [indexPath indexAtPosition:1];
	switch (index) {
		case 0:
			cell = [TTTableControlItem itemWithCaption:@"Lights" control:m_lights];
			break;
		case 1:
			cell = [TTTableControlItem itemWithCaption:@"Indoor" control:m_indoor];
			break;
		case 2:
			cell = [TTTableControlItem itemWithCaption:@"Indoor" control:m_backboard];
		default:
			break;
	}
    // Set up the cell...
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}

*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
	[m_indoor release];
	[m_lights release];
	[m_backboard release];
    [super dealloc];
}


@end

