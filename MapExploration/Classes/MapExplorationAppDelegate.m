//
//  MapExplorationAppDelegate.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/20/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "MapExplorationAppDelegate.h"


@implementation MapExplorationAppDelegate

@synthesize window;
@synthesize mapView;

- (NSString*) dbFilePath {
	return m_dbFilePath;
}

#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch
	[self setDbFilePath];
	locationDelegate = [[LocationDelegate alloc] initWithAppDelegate:self];	
	[locationDelegate retain];
	[locationDelegate.locationManager startUpdatingLocation];
	mapView = [[MapView alloc] initWithAppDelegate:self];

	[window addSubview:mapView.view];
	[window makeKeyAndVisible];
}

- (void) setDbFilePath {
	NSString *DB_FILE_NAME = @"tennis.db";
	NSString *DB_RESOURCE_NAME = @"tennis";
	NSString *DB_RESOURCE_TYPE = @"db";
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0]; 
	m_dbFilePath = [documentFolderPath stringByAppendingPathComponent: DB_FILE_NAME];
	
	
	
	if (! [[NSFileManager defaultManager] fileExistsAtPath: m_dbFilePath]) {
		// didn't find db, need to copy
		NSString *backupDbPath = [[NSBundle mainBundle]
								  pathForResource:DB_RESOURCE_NAME
								  ofType:DB_RESOURCE_TYPE];
		if (backupDbPath == nil) {
			// couldn't find backup db to copy, bail
			assert(FALSE);
		} else {
			BOOL copiedBackupDb = [[NSFileManager defaultManager]
								   copyItemAtPath:backupDbPath
								   toPath:m_dbFilePath
								   error:nil];
			assert(copiedBackupDb);
		}
	}
}

- (void) updateLocation:(CLLocation *)location {
	NSLog(@"New location");
	[mapView setNewLocation:location];
}
/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
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
    
	[window release];
	[super dealloc];
}


@end
