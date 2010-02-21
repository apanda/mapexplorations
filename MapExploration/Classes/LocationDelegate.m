//
//  LocationDelegate.m
//  StumbleApp
//
//  Created by Aurojit Panda on 1/23/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LocationDelegate.h"
#include <sys/time.h>
#include <time.h>

@implementation LocationDelegate
@synthesize locationManager = m_locationManager;

- (id) initWithAppDelegate:(MapExplorationAppDelegate*)appDelegate {
	self = [super init];
	m_appDelegate = appDelegate;
	// Allocate location manager
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	// Receive updates always
	self.locationManager.distanceFilter = kCLDistanceFilterNone;
	// We don't need more acuracy than the 10s of meters
	self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	// Set ourselves up as the delegate
	self.locationManager.delegate = self;
	return self;
}

- (void) locationManager: (CLLocationManager*) manager
	 didUpdateToLocation: (CLLocation *) newLocation
			fromLocation: (CLLocation *) oldLocation {
	
	// We receive new location, we update vew
	[m_appDelegate updateLocation:newLocation];
	time(NULL);
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:[error description] delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[alert show];
	[alert release];
}

@end
