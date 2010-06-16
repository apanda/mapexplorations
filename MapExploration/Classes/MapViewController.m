//
//  MapView.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

static NSString* const GMAP_ANNOTATION_SELECTED = @"gMapAnnontationSelected";

@implementation MapViewController

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

- (id) initWithAppDelegate:(MapExplorationAppDelegate *)appDelegate tennisDatabase: (TennisDatabase*) database{
	self = [super initWithNibName:nil bundle:nil];
	m_appDelegate = appDelegate;
	m_database = [database retain];
	
	UIImage *target = [UIImage imageNamed:@"target_on.png"];
	UIImage *gear = [UIImage imageNamed:@"settings_off.png"];
	UIBarButtonItem *targetButton = [[[UIBarButtonItem alloc] initWithImage:target style:UIBarButtonItemStylePlain target:self 
																	 action:@selector(targetClicked)] autorelease];
    targetButton.title = @"Locate";
	UIBarButtonItem *space = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil] autorelease];
	UIBarButtonItem *gearButton = [[[UIBarButtonItem alloc] initWithImage:gear style:UIBarButtonItemStylePlain target:self 
																   action:@selector(gearClicked)] autorelease];
    gearButton.title = @"Filter";
	NSArray *buttonArray = [[NSArray arrayWithObjects:targetButton, space, gearButton, nil] autorelease];
	[self setToolbarItems:buttonArray];
	m_filter = [[TennisFilter alloc] init];
	self.title = @"Map View";
	m_annotations = nil;
	
	return self;
}
-(void) gearClicked
{
	//[m_appDelegate showFilterSelector];
    
    if (m_filterToast.hidden) {
        [m_filterToast show];
        
        // Now, we have to deselect all annotations and hide the info toast
        [m_infoToast hide];
        [self deselectAnnotations];
    } else {
        [m_filterToast hide];
    }
}

- (void) targetClicked
{
	if (m_appDelegate.location != nil) {
		[self setNewLocation: m_appDelegate.location];
	}
}

-(void)deselectAnnotations
{
    for(PinAnnotation* annotation in m_mapView.selectedAnnotations) {
        [m_mapView deselectAnnotation:annotation animated:NO];
    }
}

- (NSArray*) currentAnnotations {
	return m_annotations;
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[m_appDelegate hideNavigationBar];
	[m_appDelegate showToolbar];
    
    
	CGRect rect = [UIScreen mainScreen].applicationFrame;
	self.view = [[UIView alloc] initWithFrame:rect];
	self.view.autoresizesSubviews = YES;
    
	float screenHeight = [UIScreen mainScreen].applicationFrame.size.height;
	float toolbarHeight = self.navigationController.toolbarHidden ? 0 : self.navigationController.toolbar.frame.size.height;
	float navBarHeight = self.navigationController.navigationBarHidden ? 0 : self.navigationController.navigationBar.frame.size.height;
	
	m_mapViewDelegate = [[MapViewDelegate alloc] initWithMapView:self appDelegate: m_appDelegate];
	
	
	m_mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight - toolbarHeight - navBarHeight)];
	m_mapView.showsUserLocation = YES;
	m_mapView.zoomEnabled = YES;
	m_mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	m_mapView.scrollEnabled = YES;
	[m_mapView setDelegate:m_mapViewDelegate];
	self.changeView = true;
    
	// Filter toast
	float toastHeight = 145;
    
	float filterToastHiddenY = screenHeight;
	float filterToastVisibleY = screenHeight - navBarHeight - toolbarHeight - toastHeight;
	CGRect filterToastHiddenFrame = CGRectMake(0, filterToastHiddenY, 320, toastHeight);
	CGRect filterToastVisibleFrame = CGRectMake(0, filterToastVisibleY, 320, toastHeight);
	m_filterToast = [[[PBToastView alloc] initWithHiddenFrame:filterToastHiddenFrame visibleFrame:filterToastVisibleFrame] autorelease];
	m_filterToast.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
	
	float infoToastHeight = 130;
	float infoToastHiddenY = -infoToastHeight;
	float infoToastVisibleY = 0 + navBarHeight;
	CGRect infoToastHiddenFrame = CGRectMake(0, infoToastHiddenY, 320, infoToastHeight);
	CGRect infoToastVisibleFrame = CGRectMake(0, infoToastVisibleY, 320, infoToastHeight);
	m_infoToast = [[[PBToastView alloc] initWithHiddenFrame:infoToastHiddenFrame visibleFrame:infoToastVisibleFrame] autorelease];
	m_infoToast.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.75];
	
	// Filter view
	m_filterView = [[PBFilterViewController2 alloc] initWithFilter:m_filter];
	m_filterView.mapView = self;
    m_filterView.view.frame = CGRectMake(0, 0, 320, toastHeight);
	[m_filterToast addSubview:m_filterView.view];
    
	// Information view
	m_informationView = [[PBInformationViewController2 alloc] init];
	m_informationView.view.frame = CGRectMake(0, 0, 320, infoToastHeight);
	[m_infoToast addSubview:m_informationView.view];
	
	[self createPinsFromDB];
    
	PBTouchOverlayView* touchView = [[PBTouchOverlayView alloc] initWithFrame:CGRectMake(0, 0, 320, screenHeight - toolbarHeight - navBarHeight)];
	touchView.delegate = self;
	[touchView addSubview:m_mapView];
    
	[self.view addSubview:touchView];
    
	[self.view addSubview:m_filterToast];
	[self.view addSubview:m_infoToast];
    
	[self.view sendSubviewToBack:touchView];
    
	[touchView release];
}

- (void)viewWillAppear:(BOOL)animated {
	[m_appDelegate hideNavigationBar];
	[m_appDelegate showToolbar];
    
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
	if (m_annotations != nil) {
		[m_mapView removeAnnotations: m_annotations];
		[m_annotations release];
	}
	m_annotations = [m_database getAnnotationsWithFilter:m_filter];
	[m_mapView addAnnotations: m_annotations];
}

- (void) recalculateFilter {
	m_filter.rating = m_filterView.rating;
	m_filter.numberOfCourts = m_filterView.courts;
	m_filter.lights = m_filterView.lights;
	m_filter.backboard = m_filterView.backboard;
	[m_filter save];
    [self deselectAnnotations];
	[self createPinsFromDB];
}

- (void)overlayTouched
{
	if (!m_filterToast.hidden) {
		[m_filterToast hide];
	}
}

- (void)annotationTouched
{
	m_annotationTouched = YES;
}

- (void) selectedAnnotation:(id)annotation
{
	[m_mapViewDelegate refreshAnnotation: annotation];
    MKAnnotationView* annotationView = [m_mapView viewForAnnotation:annotation];
    [self showDetailsForAnnotation:annotationView.annotation];
    [m_infoToast show];
    
    m_annotationTouched = NO;
}

- (void) deselectedAnnotation:(id)annotation
{
	[m_mapViewDelegate refreshAnnotation: annotation];
    if (!m_annotationTouched) {
        NSLog(@"Hiding info toast");
        [m_infoToast hide]; 
    }
    
    m_annotationTouched = NO;
}

- (void) showDetailsForAnnotation: (PinAnnotation*) annotation
{
	m_informationView.currentAnnotation = annotation;
	[m_informationView viewWillAppear:NO];
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
