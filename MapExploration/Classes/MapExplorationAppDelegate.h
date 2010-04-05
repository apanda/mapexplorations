//
//  MapExplorationAppDelegate.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "MapView.h"
#import "LocationDelegate.h"
#import "PinAnnotation.h"
#import "InformationView.h"

@class InformationView;
@class MapView;
@class LocationDelegate;
@class PinAnnotation;
@interface MapExplorationAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	UINavigationController *m_navigationCountroller;
    UIWindow *window;
	MapView *mapView;
	LocationDelegate *locationDelegate;
	NSString *m_dbFilePath;
	InformationView *m_informationView;
	bool m_locationSet;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) MapView *mapView;
@property (nonatomic, retain, readonly) NSString *dbFilePath;

- (NSString *)applicationDocumentsDirectory;
- (void) updateLocation: (CLLocation*) location;
- (void) setDbFilePath;
- (void) showDetailsForAnnotation: (PinAnnotation*) annotation;
- (void) hideNavigationBar;
- (void) showNavigationBar;

@end

