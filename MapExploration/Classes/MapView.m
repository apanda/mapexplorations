//
//  MapView.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"


@implementation MapView

@synthesize mapView = m_mapView;
@synthesize changeView = m_changeView;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

- (id) initWithAppDelegate:(MapExplorationAppDelegate *)appDelegate {
	self = [super initWithNibName:nil bundle:nil];
	m_appDelegate = appDelegate;
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	CGRect rect = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.autoresizesSubviews = YES;
	
	m_mapViewDelegate = [[MapViewDelegate alloc] initWithMapView:self];
	
	
	m_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 470)];
	m_mapView.showsUserLocation = YES;
	m_mapView.zoomEnabled = YES;
	m_mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	m_mapView.scrollEnabled = YES;
	[m_mapView setDelegate:m_mapViewDelegate];
	self.changeView = true;
	
	[self createPinsFromDB];
	[self.view addSubview:m_mapView];
	
}

#pragma mark location stuff

- (void) setNewLocation:(CLLocation *)location {
	if (!self.changeView) {
		return;
	}
	MKCoordinateRegion region;
	region.center = location.coordinate;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.01;
	span.longitudeDelta = 0.01;
	region.span = span;
	[m_mapView setRegion:region animated:NO];
	//self.changeView = FALSE;
	
}

- (void) createPinsFromDB {
	const char *dbName = [m_appDelegate.dbFilePath UTF8String];
	sqlite3 *db;
	int dbrc = sqlite3_open(dbName, &db);
	assert (dbrc == SQLITE_OK);
	sqlite3_stmt *sqlite_stmt;
	NSString* sqlstatement = @"select courtname, address, latitude, longitude, courts, city from tenniscourts";
	dbrc = sqlite3_prepare_v2(db, [sqlstatement UTF8String], -1, &sqlite_stmt, NULL);
	NSLog(@"dbrc = %d SQLITE_OK = %d", dbrc, SQLITE_OK);
	assert (dbrc == SQLITE_OK);
	while ((dbrc = sqlite3_step(sqlite_stmt)) == SQLITE_ROW) {
		
		NSString *name = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(sqlite_stmt, 0)];
		NSString *address = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 1)];
		NSString *city = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 5)];
		int courts = sqlite3_column_int(sqlite_stmt, 4);
		
		CLLocationCoordinate2D coordinate;
		coordinate.latitude = sqlite3_column_double(sqlite_stmt, 2);
		coordinate.longitude = sqlite3_column_double(sqlite_stmt, 3);
		
		PinAnnotation *pinAnnotation =[[[PinAnnotation alloc] initWithCoordinate:coordinate name:name address:address city:city numCourts:courts] autorelease];
		[m_mapView addAnnotation: pinAnnotation];
	}
	NSLog(@"dbrc = %d SQLITE_OK = %d", dbrc, SQLITE_OK);
	sqlite3_finalize(sqlite_stmt);
	sqlite3_close(db);
	
}
#pragma mark -


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
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


- (void)dealloc {
    [super dealloc];
}


@end
