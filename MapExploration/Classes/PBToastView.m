//
//  PBToastView.m
//  MapCallouts
//
//  Created by Itay Neeman on 4/7/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBToastView.h"

static NSString* kToastHideAnimationId = @"ToastHideAnimation";
static NSString* kToastShowAnimationId = @"ToastShowAnimation";

@implementation PBToastView

@synthesize hidden = m_currentlyHidden;

- (id)initWithHiddenFrame:(CGRect)hiddenFrame visibleFrame:(CGRect)visibleFrame
{
  self = [super initWithFrame:hiddenFrame];
  if (self) {
    m_hiddenFrame = hiddenFrame;
    m_visibleFrame = visibleFrame;
    
    m_currentlyHidden = YES;
  }
  
  return self;
}

- (void)hide
{
  if (!m_currentlyHidden) {
    [UIView beginAnimations:kToastHideAnimationId context:self];
    self.frame = m_hiddenFrame;
    [UIView commitAnimations];
    
    m_currentlyHidden = YES;
  }
}

- (void)show
{
  if (m_currentlyHidden) {
    [UIView beginAnimations:kToastShowAnimationId context:self];
    self.frame = m_visibleFrame;
    [UIView commitAnimations];
    
    m_currentlyHidden = NO;
  }
}

@end
