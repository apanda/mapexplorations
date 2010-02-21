//
//  CoreLocationDelegate.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoreLocationDelegate.h"


@implementation CoreLocationDelegate

@synthesize locationManager = m_locationManager;

- (id) initWithAppDelegate:(MapExplorationAppDelegate *)appDelegate {
	self = [super init];
	m_applicationDelegate = appDelegate;
	
	// Allocate location manager
	m_locationManager = [[[CLLocationManager alloc] init] autorelease];
	// Receive updates always
	m_locationManager.distanceFilter = kCLDistanceFilterNone;
	// We don't need more acuracy than the 10s of meters
	m_locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
	// Set ourselves up as the delegate
	m_locationManager.delegate = self;
	[m_locationManager startUpdatingLocation];
	return self;
}

- (void) locationManager: (CLLocationManager*) manager
	 didUpdateToLocation: (CLLocation *) newLocation
			fromLocation: (CLLocation *) oldLocation {
	[m_applicationDelegate setNewLocation:newLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
	/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
												   message:[error description] delegate:nil
										 cancelButtonTitle:nil otherButtonTitles:nil];
	[alert show];*/
}


@end
