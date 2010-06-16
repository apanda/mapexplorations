//
//  TennisDatabase.h
//  MapExploration
//
//  Created by Aurojit Panda on 4/5/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "MapExplorationAppDelegate.h"
#import "PinAnnotation.h"
#import "TennisFilter.h"

@class MapExplorationAppDelegate;
@class PinAnnotation;
@class TennisFilter;
@interface TennisDatabase : NSObject {
	sqlite3 *m_db;
}
@property (readonly, nonatomic) int MinCourts;
@property (readonly, nonatomic) int MaxCourts;
- (id) initWithWritableDbWithAppDelegate: (MapExplorationAppDelegate*) delegate;
- (NSArray*) getAnnotationsWithFilter: (TennisFilter*) filter;
- (void) updateRatingsForAnnotation:(PinAnnotation*) annotation;
@end
