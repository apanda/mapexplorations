//
//  PBPinAnnotationView.m
//  MapExploration
//
//  Created by Itay Neeman on 4/8/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBPinAnnotationView.h"


@implementation PBPinAnnotationView

- (id)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier delegate:(MapViewController*)delegate
{
  if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
    m_delegate = [delegate retain];
  }
  
  return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSLog(@"Touched!");
  [m_delegate annotationTouched];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  NSLog(@"Selected: %d", selected);
  [super setSelected:selected animated:animated];
}

- (void)dealloc
{
  [m_delegate release];
  [super dealloc];
}

@end