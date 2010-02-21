//
//  LocationDelegate.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "MapExplorationAppDelegate.h"

@class MapExplorationAppDelegate;


@interface LocationDelegate : NSObject <CLLocationManagerDelegate> {
	CLLocationManager* m_locationManager;
	MapExplorationAppDelegate* m_appDelegate;
}

@property (nonatomic, retain) CLLocationManager* m_locationManager;

- (void) locationManager: (CLLocationManager*) manager
	 didUpdateToLocation: (CLLocation *) newLocation
			fromLocation: (CLLocation *) oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

- (id) initWithAppDelegate: (MapExplorationAppDelegate*) appDelegate;

@end
