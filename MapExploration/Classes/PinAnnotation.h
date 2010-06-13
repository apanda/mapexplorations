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
	int m_key;
	bool m_lights;
	bool m_selected;
	NSString* m_neighborhood;
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) int numCourts;
@property (nonatomic) int rating;
@property (nonatomic, readonly) NSString* name;
@property (nonatomic, readonly) NSString* address;
@property (nonatomic, readonly) NSString* city;
@property (nonatomic, readonly) NSString* neighborhood;
@property (nonatomic, readonly) int key;
@property (nonatomic, readonly) bool lights;
@property (nonatomic) bool selected;

- (id) initWithCoordinate: (CLLocationCoordinate2D) coordinate
					  key:(int) key 
					name:(NSString*) name 
				    address:(NSString*) address
					 city: (NSString*) city
					numCourts: (int) numCourts
			     neighborhood: (NSString*) neighborhood
				    rating: (int) rating
                    lights: (int) lights;

@end
