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
	
	const char *dbName = [delegate.dbFilePath UTF8String];
	int dbrc = sqlite3_open(dbName, &m_db);
	assert (dbrc == SQLITE_OK);
	return self;
	
}

- (NSArray*) getAnnotations
{
	NSMutableArray *array = [[NSMutableArray alloc] init];
	sqlite3_stmt *sqlite_stmt;
	NSString* sqlstatement = @"select courtname, address, latitude, longitude, courts, city, rating, key, neighborhood from tenniscourts";
	int dbrc = sqlite3_prepare_v2(m_db, [sqlstatement UTF8String], -1, &sqlite_stmt, NULL);
	NSLog(@"dbrc = %d SQLITE_OK = %d", dbrc, SQLITE_OK);
	assert (dbrc == SQLITE_OK);
	while ((dbrc = sqlite3_step(sqlite_stmt)) == SQLITE_ROW) {
		
		NSString *name = [[NSString alloc] initWithUTF8String:(const char*) sqlite3_column_text(sqlite_stmt, 0)];
		NSString *address = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 1)];
		NSString *city = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 5)];
		NSString *neighborhood = [[NSString alloc] initWithUTF8String:(const char*)sqlite3_column_text(sqlite_stmt, 8)];
		int courts = sqlite3_column_int(sqlite_stmt, 4);
		int rating = sqlite3_column_int(sqlite_stmt, 6);
		int key = sqlite3_column_int(sqlite_stmt, 7);
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
																		  rating: rating] autorelease];
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
@end
