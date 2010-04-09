//
//  PBTouchOverlayView.m
//  MapExploration
//
//  Created by Itay Neeman on 4/8/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBTouchOverlayView.h"


@implementation PBTouchOverlayView

@synthesize delegate = m_delegate;

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  
	
	UIView* returnMe =  [super hitTest:point withEvent:event];
  
  [m_delegate overlayTouched];
  
  return returnMe;
}

- (void) dealloc
{
  self.delegate = nil;
  [super dealloc];
}


@end
