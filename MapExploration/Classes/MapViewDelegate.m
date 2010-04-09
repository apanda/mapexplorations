//
//  MapViewDelegate.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewDelegate.h"
#import "PBPinAnnotationView.h"

static NSString* const GMAP_ANNOTATION_SELECTED = @"gMapAnnontationSelected";

@implementation MapViewDelegate

- (id) initWithMapView:(MapViewController *)mapView appDelegate: (MapExplorationAppDelegate*)appDelegate{
	self = [super init];
	m_mapView = [mapView retain];
	m_appDelegate = [appDelegate retain];
	return self;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	MKPinAnnotationView *annotationView = nil;
	if ([annotation isKindOfClass: [PinAnnotation class]]) {
		PinAnnotation* pinAnnotation = (PinAnnotation*) annotation;
		annotationView = (MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
		if (annotationView == nil) {
			annotationView = [[[PBPinAnnotationView alloc] initWithAnnotation:annotation 
                                                        reuseIdentifier:@"pin"
                                                               delegate:m_mapView] autorelease];
			UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			button.frame = CGRectMake(0,0,23,23);
			annotationView.rightCalloutAccessoryView = button;
			
		}
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
		[annotationView setCanShowCallout: YES];
		[annotationView setEnabled:YES];
    
    [annotationView addObserver:m_mapView
              forKeyPath:@"selected"
                 options:NSKeyValueObservingOptionNew
                 context:GMAP_ANNOTATION_SELECTED]; 
    annotationView.calloutOffset = CGPointMake(10000.0, 10000.0);
    
		return (MKAnnotationView*)annotationView;

	}
	else {
		return nil;
	}
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	PinAnnotation* annotation = (PinAnnotation*) view.annotation;
	[m_appDelegate showDetailsForAnnotation:annotation];
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
