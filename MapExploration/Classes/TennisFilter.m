//
//  TennisFilter.m
//  MapExploration
//
//  Created by Aurojit Panda on 4/6/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TennisFilter.h"


@implementation TennisFilter
@synthesize lights = m_lights;
@synthesize numberOfCourts = m_numberOfCourts;
@synthesize backboard = m_backboard;
@synthesize rating = m_rating;
@synthesize indoor = m_indoor;

- (id) init
{
	self = [super init];
	self.lights = false;
	/*self.numberOfCourts = 0;
	self.backboard = false;
	self.rating = 0;
	self.indoor = false;*/
	return self;
}

- (NSString*) whereClause
{
	NSString *stringToReturn = @"";
	/*NSString *joinClause = @"where";
	if (self.lights) {
		stringToReturn = [stringToReturn stringByAppendingFormat:@"%@ lights = 1", joinClause];
		joinClause = @" and";
	}
	if (self.numberOfCourts > 0) {
		stringToReturn = [stringToReturn stringByAppendingFormat:@"%@ courts >= %d", joinClause, self.numberOfCourts];
		joinClause = @" and";
	}
	if (self.rating > 0) {
		stringToReturn = [stringToReturn stringByAppendingFormat:@"%@ rating >= %d", joinClause, self.rating];
		joinClause = @" and";
	}
	if (self.backboard) {
		stringToReturn = [stringToReturn stringByAppendingFormat:@"%@ backboard = 1", joinClause];
		joinClause = @" and";
	}
	if (self.indoor) {
		stringToReturn = [stringToReturn stringByAppendingFormat:@"%@ indoor = 1", joinClause];
		joinClause = @" and";
	}*/
	return stringToReturn;
}

@end
