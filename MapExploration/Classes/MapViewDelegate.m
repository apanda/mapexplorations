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
		PinAnnotation* pinAnnotation = (PinAnnotation*) annotation;
		annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
		if (annotationView == nil) {
			annotationView = [[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"] autorelease];
			UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			button.frame = CGRectMake(0,0,23,23);
			annotationView.rightCalloutAccessoryView = button;
			MKPinAnnotationColor color;
			if (pinAnnotation.numCourts > 7) {
				color = MKPinAnnotationColorGreen;
			}
			else if (pinAnnotation.numCourts > 3) {
				color = MKPinAnnotationColorPurple;
			}
			else {
				color = MKPinAnnotationColorRed;
			}

			[annotationView setPinColor:color];
		}
		[annotationView setCanShowCallout: YES];
		[annotationView setEnabled:YES];
		return (MKAnnotationView*)annotationView;

	}
	else {
		return nil;
	}
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	PinAnnotation* annotation = (PinAnnotation*) view.annotation;
	NSLog(@"Clicked on  %@, at address %@, in %@ with %d courts", 
		  annotation.name,
		  annotation.address,
		  annotation.city,
		  annotation.numCourts);
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	//m_mapView.changeView = false;
}

@end
