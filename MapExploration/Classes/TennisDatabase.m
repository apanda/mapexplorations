//
//  TennisDatabase.m
//  MapExploration
//
//  Created by Aurojit Panda on 4/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TennisDatabase.h"


@implementation TennisDatabase

- (id) initWithWritableDbWithAppDelegate: (MapExplorationAppDelegate*) delegate
{
    self = [super init];
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSLog(@"%@",delegate.writableDbFilePath);
    success = [fileManager fileExistsAtPath:delegate.writableDbFilePath];
    if (!success)
    {
        NSLog(@"No file");
        // The writable database does not exist, so copy the default to the appropriate location.
        success = [fileManager copyItemAtPath:delegate.dbFilePath toPath:delegate.writableDbFilePath error:&error];
        if (!success) {
            NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
        }
    }
    
    const char *dbName = [delegate.writableDbFilePath UTF8String];
    int dbrc = sqlite3_open(dbName, &m_db);
    assert (dbrc == SQLITE_OK);
    return self;
    
}

- (NSArray*) getAnnotationsWithFilter: (TennisFilter*) filter
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    sqlite3_stmt *sqlite_stmt;
    NSString* sqlstatement = @"select courtname, address, latitude, longitude, courts, city, rating, key, neighborhood, lights from tenniscourts";
    NSString* whereClause = [filter whereClause];
    NSLog(@"where clause: %@", whereClause);
    sqlstatement = [sqlstatement stringByAppendingFormat:@" %@", whereClause];
    int dbrc = sqlite3_prepare_v2(m_db, [sqlstatement UTF8String], -1, &sqlite_stmt, NULL);
    NSLog(@"dbrc = %d SQLITE_OK = %d", dbrc, SQLITE_OK);
    assert (dbrc == SQLITE_OK);
    while ((dbrc = sqlite3_step(sqlite_stmt)) == SQLITE_ROW) {
        
        NSString *name = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(sqlite_stmt, 0)];
        NSString *address = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 1)];
        NSString *city = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 5)];
        char *neighborhoodAsChar = (char*)sqlite3_column_text(sqlite_stmt, 8);
        NSString *neighborhood;
        if(neighborhoodAsChar != NULL) {
            neighborhood = [NSString stringWithCString:neighborhoodAsChar encoding:NSUTF8StringEncoding];
        }
        else {
            neighborhood = @"";
        }

        int courts = sqlite3_column_int(sqlite_stmt, 4);
        int rating = sqlite3_column_int(sqlite_stmt, 6);
        int key = sqlite3_column_int(sqlite_stmt, 7);
        int lights = sqlite3_column_int(sqlite_stmt, 9);
        CLLocationCoordinate2D coordinate;
        coordinate.latitude = sqlite3_column_double(sqlite_stmt, 2);
        coordinate.longitude = sqlite3_column_double(sqlite_stmt, 3);
        
        PinAnnotation *pinAnnotation =[[[PinAnnotation alloc] initWithCoordinate:coordinate 
                                                                             key: key 
                                                                            name: name 
                                                                         address: address 
                                                                            city: city 
                                                                       numCourts: courts
                                                                    neighborhood: neighborhood
                                                                          rating: rating
                                                                          lights: lights] autorelease];
        [name release];
        [address release];
        [city release];
        [array addObject:pinAnnotation];
    }
    NSLog(@"dbrc = %d SQLITE_OK = %d", dbrc, SQLITE_OK);
    sqlite3_finalize(sqlite_stmt);
    return array;
}


- (void) dealloc
{
    sqlite3_close(m_db);
    [super dealloc];
}

- (void) updateRatingsForAnnotation:(PinAnnotation*) annotation
{
    sqlite3_stmt *sqlite_stmt;
    NSString* sqlstatement = [NSString stringWithFormat:@"update tenniscourts set rating=%d where key=%d", annotation.rating, annotation.key];
    NSLog(@"%@", sqlstatement);
    int dbrc = sqlite3_prepare_v2(m_db, [sqlstatement UTF8String], -1, &sqlite_stmt, NULL);
    NSLog(@"dbrc = %d SQLITE_OK = %d", dbrc, SQLITE_OK);
    assert (dbrc == SQLITE_OK);
    int err = sqlite3_exec(m_db, [sqlstatement UTF8String], NULL, NULL, NULL);
    NSLog(@"dbrc = %d SQLITE_OK = %d", err, SQLITE_OK);
}

- (int) MaxCourts
{
    return 14;
}

- (int) MinCourts
{
    return 1;
}
@end
