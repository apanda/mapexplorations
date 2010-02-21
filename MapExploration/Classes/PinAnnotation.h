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
}

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id) initWithCoordinate: (CLLocationCoordinate2D) coordinate;

@end
