//
//  MapExplorationAppDelegate.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "MapViewController.h"
#import "LocationDelegate.h"
#import "PinAnnotation.h"
#import "InformationViewController.h"
#import "TennisDatabase.h"
#import "TennisFilter.h"
#import "FilterViewController.h"
#include "TargetConditionals.h"

@class TennisDatabase;
@class InformationViewController;
@class MapViewController;
@class LocationDelegate;
@class PinAnnotation;
@class TennisFilter;
@class FilterViewController;
@interface MapExplorationAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	UINavigationController *m_navigationCountroller;
    UIWindow *window;
	MapViewController *mapView;
	LocationDelegate *locationDelegate;
	NSString *m_dbFilePath;
	NSString *m_writableDbFilePath;
	InformationViewController *m_informationView;
	FilterViewController *m_filterView;
	bool m_locationSet;
	TennisDatabase *m_database;
	TennisFilter *m_filter;
	CLLocation *m_currentLocation;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MapViewController *mapView;
@property (nonatomic, retain, readonly) NSString *dbFilePath;
@property (nonatomic, retain, readonly) NSString *writableDbFilePath;
@property (nonatomic, retain, readonly) TennisFilter *filter;
@property (nonatomic, retain, readonly) CLLocation *location;
@property (nonatomic, retain, readonly) TennisDatabase *database;

- (NSString *)applicationDocumentsDirectory;
- (void) updateLocation: (CLLocation*) location;
- (void) setDbFilePath;
- (void) setWritableDbFilePath;
- (void) showDetailsForAnnotation: (PinAnnotation*) annotation;
- (void) hideNavigationBar;
- (void) showNavigationBar;
- (void) showToolbar;
- (void) hideToolbar;
- (void) updateRatingForAnnotation: (PinAnnotation*) annotation;
- (void) showFilterSelector;

@end

