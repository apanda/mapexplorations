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

@class MapExplorationAppDelegate;
@class PinAnnotation;
@interface TennisDatabase : NSObject {
	sqlite3 *m_db;
}

- (id) initWithWritableDbWithAppDelegate: (MapExplorationAppDelegate*) delegate;
- (NSArray*) getAnnotations;
- (void) updateRatingsForAnnotation:(PinAnnotation*) annotation;
@end
