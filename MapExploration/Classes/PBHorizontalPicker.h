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

@interface PBHorizontalScrollView : UIScrollView {
    
}

@end

@class PBHorizontalPicker;
@protocol PBHorizontalPickerDelegate

- (void)picker:(PBHorizontalPicker*)picker didSelectItemWithIndex:(int)index;

@end

@interface PBHorizontalPicker : UIView <UIScrollViewDelegate> {
    PBHorizontalScrollView* m_scrollView;
    NSArray* m_labels;
    
    int m_labelWidth;
    CGPoint m_startDecelerationPoint;
    
    int m_selectedIndex;
    
    id<PBHorizontalPickerDelegate> m_delegate;
}

@property (nonatomic, assign, readonly) int selectedIndex;
@property (nonatomic, retain) id<PBHorizontalPickerDelegate> delegate;

- (id)initWithFrame:(CGRect)frame labels:(NSArray*)labels;
- (CGPoint)pointToScrollTo:(int)labelIndex;
- (int)labelIndexToScrollTo:(CGPoint)contentOffset;
- (CAGradientLayer*)selectionBoundaryLayerWithFrame:(CGRect)frame;
- (void)scrollToLabelIndex:(int)index;

@end


