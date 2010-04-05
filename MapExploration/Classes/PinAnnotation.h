//
//  PinAnnotation.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PinAnnotation : NSObject <MKAnnotation> {
	CLLocationCoordinate2D m_coordinate;
	NSString* m_name;
	NSString* m_address;
	int m_numCourts;
	NSString* m_city;
	int m_rating;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) int numCourts;
@property (nonatomic, readonly) int rating;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* address;
@property (nonatomic, readonly) NSString* city;

- (id) initWithCoordinate: (CLLocationCoordinate2D) coordinate 
					name:(NSString*) name 
				    address:(NSString*) address
					 city: (NSString*) city
					numCourts: (int) numCourts
				    rating: (int) rating;

@end
