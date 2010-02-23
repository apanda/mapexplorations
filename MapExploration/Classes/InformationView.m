//
//  InformationView.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InformationView.h"


@implementation InformationView
@synthesize currentAnnotation = m_annotation;

- (id)initWithStyle:(UITableViewStyle)style appDelegate: (MapExplorationAppDelegate*) appDelegate {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
	m_appDelegate = appDelegate;
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
	
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
	// self.navigationItem.leftBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.tableView reloadData];
	self.tableView.editing = NO;
	self.title = self.currentAnnotation.name;
	[m_appDelegate showNavigationBar];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	int index = [indexPath indexAtPosition:1];
    if (index == 0) {
		cell.textLabel.text = @"Name";
		cell.detailTextLabel.text = self.currentAnnotation.name;
	}
	else if (index == 1){
		cell.textLabel.text = @"Address";
		cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.detailTextLabel.numberOfLines = 5;
		cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
		cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@\n%@, WA", self.currentAnnotation.address, self.currentAnnotation.city];
	}
	else if (index == 2) {
		cell.textLabel.text = @"Courts";
		cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d", self.currentAnnotation.numCourts];
	}
    // Set up the cell...
	
	
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
	// return [super tableView: tableView heightForRowAtIndexPath: indexPath];
	if ([indexPath indexAtPosition:1] != 1) {
		return tableView.rowHeight;
	
	}
	CGSize maxSize;
	float height = 2009;
	float width = CGRectGetWidth(tableView.frame) - 200;
	maxSize = CGSizeMake(width, height);
	CGSize size = [self.currentAnnotation.address sizeWithFont:[UIFont systemFontOfSize: [UIFont systemFontSize]] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	CGSize size2 = [self.currentAnnotation.city sizeWithFont:[UIFont systemFontOfSize: [UIFont systemFontSize]] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
	return size.height + size2.height + 5.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


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
    [super dealloc];
}


@end

