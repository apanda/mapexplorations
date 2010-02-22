//
//  MapExplorationAppDelegate.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//
#import "MapView.h"
#import "LocationDelegate.h"

@class MapView;
@class LocationDelegate;
@interface MapExplorationAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;

    UIWindow *window;
	MapView *mapView;
	LocationDelegate *locationDelegate;
	NSString *m_dbFilePath;
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

@end
