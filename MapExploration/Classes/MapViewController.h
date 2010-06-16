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
#import "PBFilterViewController2.h"
#import "PBTouchOverlayView.h"
#import "PBInformationViewController2.h"
#import "PBPinAnnotationView.h"

@class PBFilterViewController2;
@class MapExplorationAppDelegate;
@class MapViewDelegate;
@class TennisDatabase;
@class TennisFilter;
@class PBInformationViewController2;
@interface MapViewController : UIViewController <PBTouchOverlayDelegate> {
    MKMapView *m_mapView;
    MapExplorationAppDelegate *m_appDelegate;
    MapViewDelegate *m_mapViewDelegate;
    bool m_changeView;
    TennisDatabase *m_database;
    TennisFilter *m_filter;
    PBToastView* m_filterToast;
    PBToastView* m_infoToast;
    PBFilterViewController2* m_filterView;
    PBInformationViewController2* m_informationView;
    NSArray* m_annotations;
  
    BOOL m_annotationTouched;
}

- (id) initWithAppDelegate: (MapExplorationAppDelegate*) appDelegate tennisDatabase: (TennisDatabase*) database;
- (void) setNewLocation: (CLLocation*) location;
- (void) createPinsFromDB;
- (void) viewWillAppear:(BOOL)animated;
- (void) gearClicked;
- (void) targetClicked;
- (void) recalculateFilter;
- (void) annotationTouched;
- (void) showDetailsForAnnotation: (PinAnnotation*) annotation;
- (void) deselectAnnotations;
- (void) selectedAnnotation:(id)annotation;
- (void) deselectedAnnotation:(id)annotation;
@property (nonatomic, retain) MKMapView *mapView;
@property (nonatomic) bool changeView;
@property (nonatomic, readonly) NSArray *currentAnnotations;
@end
