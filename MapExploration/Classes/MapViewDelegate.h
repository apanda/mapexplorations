//
//  MapViewDelegate.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/21/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapViewController.h"
#import "PinAnnotation.h"
#import "MapExplorationAppDelegate.h"

@class MapViewController;
@class PinAnnotation;
@class MapExplorationAppDelegate;
@interface MapViewDelegate : NSObject <MKMapViewDelegate> {
    MapViewController *m_mapView;
    MapExplorationAppDelegate *m_appDelegate;
    NSArray *m_unselectedPins;
    NSArray *m_selectedPins;
    bool m_largePins;
}

- (UIImage*) pinForAnnotation: (PinAnnotation*) annotation;
- (id) initWithMapView: (MapViewController*) mapView appDelegate: (MapExplorationAppDelegate*)appDelegate;
- (void) refreshAnnotations;
- (void) refreshAnnotation: (PinAnnotation*) annotation;
// This method may be called for all or some of the added annotations.
// For MapKit provided annotations (eg. MKUserLocation) return nil to use the MapKit provided annotation view.

// mapView:didAddAnnotationViews: is called after the annotation views have been added and positioned in the map.
// The delegate can implement this method to animate the adding of the annotations views.
// Use the current positions of the annotation views as the destinations of the animation.
//- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views;
//
//// mapView:annotationView:calloutAccessoryControlTapped: is called when the user taps on left & right callout accessory UIControls.
//- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control;

@end
