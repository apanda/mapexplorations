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
	
	m_fewPin = [[UIImage imageNamed:@"smallball.png"] retain];
	m_mediumPin = [[UIImage imageNamed:@"smallball3.png"] retain];
	m_manyPin = [[UIImage imageNamed:@"smallball4.png"] retain];
	m_fewPinLarge = [[UIImage imageNamed:@"smallball_large.png"] retain];
	m_mediumPinLarge = [[UIImage imageNamed:@"smallball3_large.png"] retain];
	m_manyPinLarge = [[UIImage imageNamed:@"smallball4_large.png"] retain];
	m_largePins = false;
	
	return self;
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
	PBPinAnnotationView *annotationView = nil;
	if ([annotation isKindOfClass: [PinAnnotation class]]) {
		PinAnnotation* pinAnnotation = (PinAnnotation*) annotation;
		annotationView = (PBPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"pin"];
		if (annotationView == nil) {
			annotationView = [[[PBPinAnnotationView alloc] initWithAnnotation:annotation 
                                                        reuseIdentifier:@"pin"
                                                               delegate:m_mapView] autorelease];
			UIButton* button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
			button.frame = CGRectMake(0,0,23,23);
			annotationView.rightCalloutAccessoryView = button;
			
		}
		UIImage *annotationImage;
		if (m_largePins) {
			if (pinAnnotation.numCourts > 7) {
				annotationImage = m_manyPinLarge;
			}
			else if (pinAnnotation.numCourts > 3) {
				annotationImage = m_mediumPinLarge;
			}
			else {
				annotationImage = m_fewPinLarge;
			}
			
		}
		else {
			if (pinAnnotation.numCourts > 7) {
				annotationImage = m_manyPin;
			}
			else if (pinAnnotation.numCourts > 3) {
				annotationImage = m_mediumPin;
			}
			else {
				annotationImage = m_fewPin;
			}
		}

		
		annotationView.image = annotationImage;
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
- (UIImage*) pinForAnnotation: (PinAnnotation*) annotation {
	
	UIImage *annotationImage;
	if (m_largePins) {
		if (annotation.numCourts > 7) {
			annotationImage = m_manyPinLarge;
		}
		else if (annotation.numCourts > 3) {
			annotationImage = m_mediumPinLarge;
		}
		else {
			annotationImage = m_fewPinLarge;
		}
		
	}
	else {
		if (annotation.numCourts > 7) {
			annotationImage = m_manyPin;
		}
		else if (annotation.numCourts > 3) {
			annotationImage = m_mediumPin;
		}
		else {
			annotationImage = m_fewPin;
		}
	}
	return annotationImage;
	
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	PinAnnotation* annotation = (PinAnnotation*) view.annotation;
	//[m_appDelegate showDetailsForAnnotation:annotation];
  [m_mapView showDetailsForAnnotation:annotation];
	NSLog(@"Clicked on  %@, at address %@, in %@ with %d courts", 
		  annotation.name,
		  annotation.address,
		  annotation.city,
		  annotation.numCourts);
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
	NSLog(@"New region latitude %f", mapView.region.span.latitudeDelta);
	NSLog(@"New region longitude %f", mapView.region.span.longitudeDelta);
	
	if (m_largePins && mapView.region.span.latitudeDelta > 0.08 && mapView.region.span.longitudeDelta > 0.08) {
		m_largePins = FALSE;
		//[m_mapView refreshAnnotations];
		[m_mapView deselectAnnotations];
		[m_mapView recalculateFilter];
	}
	else if (!m_largePins && mapView.region.span.latitudeDelta <= 0.08 && mapView.region.span.longitudeDelta <= 0.08) {
		m_largePins = TRUE;
		//[m_mapView refreshAnnotations];
		[m_mapView deselectAnnotations];
		[m_mapView recalculateFilter];
	}
	//m_mapView.changeView = false;
}

- (void) dealloc {
	[m_fewPin release];
	[m_mediumPin release];
	[m_manyPin release];
	[m_fewPinLarge release]; 
	[m_mediumPinLarge release];
	[m_manyPinLarge release];
	[super dealloc];
}
@end
