//
//  PBInformationView2.h
//  MapExploration
//
//  Created by Itay Neeman on 6/12/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "SCRatingView.h"
#import "PinAnnotation.h"
#import "MapExplorationAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@class MapExplorationAppDelegate;

@interface PBInformationViewController2 : UIViewController <SCRatingDelegate> {
    
    // Info labels
    TTLabel* m_nameLabel;
    TTLabel* m_addressLabel;
    TTLabel* m_cityLabel;
    
    // Rating view
    SCRatingView* m_ratingView;
    
    // Court info
    TTView* m_courtsView;
    UIImage* m_courtsImage;
    UIImageView* m_courtsImageView;
    TTLabel* m_courtsInfoLabel;
    
    // Lights info
    TTView* m_lightView;
    UIImage* m_lightOnImage;
    UIImage* m_lightOffImage;
    UIImageView* m_lightImageView;
    TTLabel* m_lightInfoLabel;
    
    // Current annotation
    PinAnnotation* m_currentAnnotation;
}

@property (nonatomic, retain) PinAnnotation* currentAnnotation;

- (void)createInfoLabelsWithParentView:(UIView*)parentView;
- (void)createDirectionsButtonWithParentView:(UIView*)parentView;
- (void)createRatingsInfoWithParentView:(UIView*)parentView;
- (void)createLightsInfoWithParentView:(UIView*)parentView;
- (void)createCourtsInfoWithParentView:(UIView*)parentView;

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating;
- (void)ratingView:(SCRatingView *)ratingView didChangeRatingFrom:(CGFloat)previousRating to:(CGFloat)rating;

@end
