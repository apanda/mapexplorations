//
//  PinAnnotation.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PinAnnotation.h"


@implementation PinAnnotation
//@synthesize coordinate = m_coordinate;
- (CLLocationCoordinate2D) coordinate {
	return m_coordinate;
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate {
	self = [super init];
	m_coordinate = coordinate;
	return self;
}


@end
