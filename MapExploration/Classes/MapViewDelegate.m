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
    UIImage* unselectedImages[14];
    for (int i = 0; i < 14; i++)  {
        unselectedImages[i] = [UIImage imageNamed:[NSString stringWithFormat:@"pin_of_%d.png", (i+1)]];
    }
    m_unselectedPins = [[NSArray arrayWithObjects: unselectedImages count: 14] retain];
    
    UIImage* selectedImages[14];
    for (int i = 0; i < 14; i++)  {
        selectedImages[i] = [UIImage imageNamed:[NSString stringWithFormat:@"pin_on_%d.png", (i+1)]];
    }
    m_selectedPins = [[NSArray arrayWithObjects:selectedImages count: 14] retain];
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
        UIImage *annotationImage = [self pinForAnnotation:pinAnnotation];
        
        annotationView.image = annotationImage;
        [annotationView setCanShowCallout:NO];
        [annotationView setEnabled:YES];
    
        annotationView.calloutOffset = CGPointMake(10000.0, 10000.0);
    
        return (MKAnnotationView*)annotationView;

    }
    else {
        return nil;
    }
}
- (UIImage*) pinForAnnotation: (PinAnnotation*) annotation {
    
    UIImage *annotationImage;
    if (annotation.selected) {
        annotationImage = (UIImage*)[m_selectedPins objectAtIndex:(annotation.numCourts - 1)];
    }
    else {
        annotationImage = (UIImage*)[m_unselectedPins objectAtIndex:(annotation.numCourts - 1)];
    }
    return annotationImage;
    
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    PinAnnotation* annotation = (PinAnnotation*) view.annotation;
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
        [m_mapView deselectAnnotations];
        [self refreshAnnotations];
    }
    else if (!m_largePins && mapView.region.span.latitudeDelta <= 0.08 && mapView.region.span.longitudeDelta <= 0.08) {
        m_largePins = TRUE;
        [m_mapView deselectAnnotations];
        [self refreshAnnotations];
    }
}

- (void) refreshAnnotations {
    NSArray* annotations = m_mapView.currentAnnotations;
    for (PinAnnotation* annotation in annotations) {
        PBPinAnnotationView* annotationView = (PBPinAnnotationView*)[m_mapView.mapView viewForAnnotation: annotation];
        annotationView.image = [self pinForAnnotation:annotation];
    }
}

- (void) refreshAnnotation: (PinAnnotation*) annotation {
    PBPinAnnotationView* annotationView = (PBPinAnnotationView*)[m_mapView.mapView viewForAnnotation:annotation];
    annotationView.image = [self pinForAnnotation:annotation];
}

- (void) dealloc {
    [m_selectedPins release];
    [m_unselectedPins release];
    [super dealloc];
}
@end
