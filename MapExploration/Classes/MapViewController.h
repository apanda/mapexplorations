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
#import "TennisDatabase.h"
#import "TennisFilter.h"
#import "PBToastView.h"

@class MapExplorationAppDelegate;
@class MapViewDelegate;
@class TennisDatabase;
@class TennisFilter;
@interface MapViewController : UIViewController {
	MKMapView *m_mapView;
	MapExplorationAppDelegate *m_appDelegate;
	MapViewDelegate *m_mapViewDelegate;
	bool m_changeView;
	TennisDatabase *m_database;
  
  PBToastView* m_filterToast;
}

- (id) initWithAppDelegate: (MapExplorationAppDelegate*) appDelegate tennisDatabase: (TennisDatabase*) database;
- (void) setNewLocation: (CLLocation*) location;
- (void) createPinsFromDB;
- (void)viewWillAppear:(BOOL)animated;
- (void) gearClicked;
- (void) targetClicked;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic) bool changeView;

@end
