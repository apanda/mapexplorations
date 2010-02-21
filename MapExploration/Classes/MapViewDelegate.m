//
//  MapViewDelegate.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewDelegate.h"


@implementation MapViewDelegate

- (id) initWithMapView:(MapView *)mapView {
	self = [super init];
	m_mapView = [mapView retain];

	return self;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	MKPinAnnotationView *annotationView = nil;
	if ([annotation isKindOfClass: [PinAnnotation class]]) {
		annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
		if (annotationView == nil) {
			annotationView = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"] autorelease];
			[annotationView setPinColor:MKPinAnnotationColorPurple];
		}
		return (MKAnnotationView*)annotationView;

	}
	else {
		return nil;
	}
}

@end
