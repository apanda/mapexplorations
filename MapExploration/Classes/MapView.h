//
//  MapView.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "MapExplorationAppDelegate.h"
#import "MapViewDelegate.h"

@class MapExplorationAppDelegate;
@class MapViewDelegate;
@interface MapView : UIViewController {
	MKMapView *m_mapView;
	MapExplorationAppDelegate *m_appDelegate;
	MapViewDelegate *m_mapViewDelegate;
	bool m_changeView;
	
}

- (id) initWithAppDelegate: (MapExplorationAppDelegate*) appDelegate;
- (void) setNewLocation: (CLLocation*) location;
- (void) createPinsFromDB;
- (void)viewWillAppear:(BOOL)animated;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic) bool changeView;

@end
