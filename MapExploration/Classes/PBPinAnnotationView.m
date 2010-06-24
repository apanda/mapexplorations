//
//  PBPinAnnotationView.m
//  MapExploration
//
//  Created by Itay Neeman on 4/8/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBPinAnnotationView.h"


@implementation PBPinAnnotationView

- (id)initWithAnnotation:(PinAnnotation*) annotation reuseIdentifier:(NSString *)reuseIdentifier delegate:(MapViewController*)delegate
{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        m_delegate = [delegate retain];
        m_annotation = annotation;
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    NSLog(@"[%x] Selected: %d", self.annotation, selected);
    
    [super setSelected:selected animated:animated];
    PinAnnotation* annotation = (PinAnnotation*)self.annotation;
    annotation.selected = selected;
    
    if (selected) {
        [m_delegate selectedAnnotation:self.annotation];
    } else {
        [m_delegate deselectedAnnotation:self.annotation];    
    }
}

- (void)dealloc
{
    [m_delegate release];
    [super dealloc];
}

@end
