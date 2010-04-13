//
//  PBPinAnnotationView.h
//  MapExploration
//
//  Created by Itay Neeman on 4/8/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"
#import "PinAnnotation.h"

@class PinAnnotation;
@interface PBPinAnnotationView : MKAnnotationView {
	MapViewController* m_delegate;
	PinAnnotation* m_annotation;
}

- (id)initWithAnnotation:(PinAnnotation*)annotation reuseIdentifier:(NSString *)reuseIdentifier delegate:(MapViewController*)delegate;
@end
