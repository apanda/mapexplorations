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
	self.title = @"Map View";
	return self;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	CGRect rect = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.autoresizesSubviews = YES;
	
	m_mapViewDelegate = [[MapViewDelegate alloc] initWithMapView:self appDelegate: m_appDelegate];
	
	
	m_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, 470)];
	m_mapView.showsUserLocation = YES;
	m_mapView.zoomEnabled = YES;
	m_mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	m_mapView.scrollEnabled = YES;
	[m_mapView setDelegate:m_mapViewDelegate];
	self.changeView = true;
	
	
	m_database = [[TennisDatabase alloc]initWithWritableDbWithAppDelegate:m_appDelegate];
	[self createPinsFromDB];
	[self.view addSubview:m_mapView];
	
}

- (void)viewWillAppear:(BOOL)animated {
	[m_appDelegate hideNavigationBar];
}

#pragma mark location stuff

- (void) setNewLocation:(CLLocation *)location {
	if (!self.changeView) {
		return;
	}
	MKCoordinateRegion region;
	region.center = location.coordinate;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.03;
	span.longitudeDelta = 0.03;
	region.span = span;
	[m_mapView setRegion:region animated:NO];
	//self.changeView = FALSE;
	
}

- (void) createPinsFromDB {
	[m_mapView addAnnotations: [m_database getAnnotations]];
	
	
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
	[m_database release];
    [super dealloc];
}


@end
