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
@synthesize rating=m_rating;
- (CLLocationCoordinate2D) coordinate {
	return m_coordinate;
}

- (id) initWithCoordinate:(CLLocationCoordinate2D)coordinate 
					  key: (int) key name:(NSString*) name 
				  address: (NSString*) address 
					 city: (NSString*) city 
				numCourts: (int) numCourts  
			 neighborhood: (NSString*) neighborhood 
				   rating: (int) rating{
	self = [super init];
	m_coordinate = coordinate;
	m_name = [name retain];
	m_address = [address retain];
	m_numCourts = numCourts;
	m_city = [city retain];
	m_rating = rating;
	m_key = key;
	m_neighborhood = neighborhood;
	return self;
}

- (NSString*) neighborhood {
	return m_neighborhood;
}

- (int) key {
	return m_key;
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

- (int) rating {
	return m_rating;
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
