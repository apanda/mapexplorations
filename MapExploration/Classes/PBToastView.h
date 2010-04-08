//
//  PBToastView.h
//  MapCallouts
//
//  Created by Itay Neeman on 4/7/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PBToastView : UIView {
  CGRect m_hiddenFrame;
  CGRect m_visibleFrame;
  
  BOOL m_currentlyHidden;
}

@property (nonatomic, readonly) BOOL hidden;

- (id)initWithHiddenFrame:(CGRect)hiddenFrame visibleFrame:(CGRect)visibleFrame;

- (void)hide;
- (void)show;

@end
