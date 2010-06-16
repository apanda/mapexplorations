//
//  TennisFilter.h
//  MapExploration
//
//  Created by Aurojit Panda on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TennisFilter : NSObject {
	bool m_lights;
	int m_numberOfCourts;
	bool m_backboard;
	int m_rating;
	bool m_indoor;
	NSUserDefaults *m_defaults;
}

@property (nonatomic) bool lights;
@property (nonatomic) int numberOfCourts;
@property (nonatomic) bool backboard;
@property (nonatomic) int rating;
@property (nonatomic) bool indoor;

- (NSString*) whereClause;
- (id) init;
- (void) loadSettings;
- (void) save;
@end
