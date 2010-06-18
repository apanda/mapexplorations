//
//  PBRoundedRectView.h
//  MapExploration
//
//  Created by Itay Neeman on 6/17/10. Adapted from Jeff LaMarche's RoundedRectView.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDefaultStrokeColor         [UIColor whiteColor]
#define kDefaultRectColor           [UIColor whiteColor]
#define kDefaultStrokeWidth         0.0
#define kDefaultCornerRadius        10.0

@interface PBRoundedRectView : UIView {
    UIColor     *strokeColor;
    UIColor     *rectColor;
    CGFloat     strokeWidth;
    CGFloat     cornerRadius;
}

@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic, retain) UIColor *rectColor;
@property CGFloat strokeWidth;
@property CGFloat cornerRadius;

@end