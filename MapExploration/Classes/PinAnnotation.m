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

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate name:(NSString*) name address: (NSString*) address city: (NSString*) city numCourts: (int) numCourts {
	self = [super init];
	m_coordinate = coordinate;
	m_name = name;
	m_address = address;
	m_numCourts = numCourts;
	m_city = city;
	return self;
}

- (NSString*) title {
	return m_name;
}

-(NSString*) subtitle {
	return m_address;
}

- (int) numCourts {
	return m_numCourts;
}


- (NSString*) name {
	return m_name;
}

- (NSString*) address {
	return m_address;
}

- (NSString*) city {
	return m_city;
}
@end
