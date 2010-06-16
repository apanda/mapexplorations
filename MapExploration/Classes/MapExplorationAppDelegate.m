//
//  MapExplorationAppDelegate.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MapExplorationAppDelegate.h"
#import "HorizontalPickerViewController.h"

@implementation MapExplorationAppDelegate

@synthesize window;
@synthesize mapView;

- (NSString*) dbFilePath {
    return m_dbFilePath;
}
- (NSString*) writableDbFilePath {
    return m_writableDbFilePath;
}
- (TennisFilter*) filter {
    return m_filter;
}
#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {        
    UIWindow *appWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window = appWindow;
    
    
    [self setDbFilePath];
    [self setWritableDbFilePath];
    m_filter = [[[TennisFilter alloc] init] retain];
    m_database = [[TennisDatabase alloc]initWithWritableDbWithAppDelegate:self];
    [appWindow release];
    
    // Override point for customization after app launch
    locationDelegate = [[LocationDelegate alloc] initWithAppDelegate:self];    
    [locationDelegate retain];
    [locationDelegate.locationManager startUpdatingLocation];
    mapView = [[MapViewController alloc] initWithAppDelegate:self tennisDatabase: m_database];
    m_informationView = [[InformationViewController alloc] initWithStyle:UITableViewStyleGrouped appDelegate: self];
    m_filterView = [[FilterViewController alloc] initWithAppDelegate: self];
    m_navigationCountroller = [[UINavigationController alloc] initWithRootViewController:mapView];
    m_locationSet = FALSE;
    m_currentLocation = nil;
    
    m_navigationCountroller.toolbar.barStyle = UIBarStyleBlack;
    
    [self.window addSubview:m_navigationCountroller.view];
    
    /*HorizontalPickerViewController* testViewController = [[HorizontalPickerViewController alloc] init];
    [self.window addSubview:testViewController.view];*/
    
    [self.window makeKeyAndVisible];
}

- (void) updateRatingForAnnotation:(PinAnnotation *)annotation {
    [m_database updateRatingsForAnnotation:annotation];
}

- (void) setDbFilePath {
    NSString *DB_RESOURCE_NAME = @"tennis";
    NSString *DB_RESOURCE_TYPE = @"db";
    m_dbFilePath = [[NSBundle mainBundle]
                    pathForResource:DB_RESOURCE_NAME
                    ofType:DB_RESOURCE_TYPE];
        
}

- (void) setWritableDbFilePath {
    NSString *DB_RESOURCE_NAME = @"tennis.1.db";
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    m_writableDbFilePath = [documentsDirectory stringByAppendingPathComponent:DB_RESOURCE_NAME];
    
}


- (void) updateLocation:(CLLocation *)location {
    if (m_currentLocation != nil) {
        [m_currentLocation release];
    }
    
#if TARGET_IPHONE_SIMULATOR
    location = [[CLLocation alloc] initWithLatitude:47.678839 longitude:-122.328837];
    m_currentLocation = location;
#else
    m_currentLocation = [location retain];
#endif
    
    NSLog(@"New location");
    if (m_locationSet) {
        return;
    }
    m_locationSet = TRUE;
    
    [mapView setNewLocation:location];
}

- (CLLocation*) location {
    return m_currentLocation;
}

- (TennisDatabase*) database {
    return m_database;
}


- (void) showDetailsForAnnotation: (PinAnnotation*) annotation {
    m_informationView.currentAnnotation = annotation;
    [m_navigationCountroller pushViewController:m_informationView animated:NO];
}

- (void) showFilterSelector {
    [m_navigationCountroller pushViewController:m_filterView animated:NO];
}

- (void) hideNavigationBar {
    m_navigationCountroller.navigationBarHidden = YES;
    
}

- (void) showNavigationBar {
    m_navigationCountroller.navigationBarHidden = NO;
}

- (void) hideToolbar {
    m_navigationCountroller.toolbarHidden = YES;
    
}

- (void) showToolbar {
    m_navigationCountroller.toolbarHidden = NO;
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
    
    NSError *error = nil;
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"MapExploration.sqlite"]];
    
    NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible
         * The schema for the persistent store is incompatible with current managed object model
         Check the error message to determine what the actual problem was.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }    
    
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
    
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    [m_database release];
    [m_filter release];
    [window release];
    [super dealloc];
}


@end

