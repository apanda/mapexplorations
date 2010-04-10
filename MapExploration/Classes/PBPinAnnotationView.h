//
//  PBPinAnnotationView.h
//  MapExploration
//
//  Created by Itay Neeman on 4/8/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface PBPinAnnotationView : MKAnnotationView {
  MapViewController* m_delegate;
}

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier delegate:(MapViewController*)delegate;

@end
