//
//  PBHorizontalPicker.h
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/10/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#pragma once

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

static const int kLabelItemSpacing = 20;

@interface PBHorizontalPicker : UIView <UIScrollViewDelegate> {
    UIScrollView* m_scrollView;
    NSArray* m_labels;
    
    int m_labelWidth;
    CGPoint m_startDecelerationPoint;
    
    UILabel* m_selectedLabel;
}
- (id)initWithFrame:(CGRect)frame labels:(NSArray*)labels;
- (CGPoint)pointToScrollTo:(int)labelIndex;
- (int)labelIndexToScrollTo:(CGPoint)contentOffset;
- (CAGradientLayer*)selectionBoundaryLayerWithFrame:(CGRect)frame;

@end
