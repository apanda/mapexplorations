//
//  PBFilterViewController2.h
//  MapExploration
//
//  Created by Itay Neeman on 6/12/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Three20/Three20.h"
#import "SCRatingView.h"
#import "PBHorizontalPicker.h"
#import "MapViewController.h"

@interface PBFilterViewController2 : UIViewController <SCRatingDelegate, PBHorizontalPickerDelegate> 
{
    // Rating
    SCRatingView* m_ratingView;
    
    // Courts Picker
    PBHorizontalPicker* m_courtsPicker;
    
    // Light button
    UIImage* m_lightsOnImage;
    UIImage* m_lightsOffImage;
    UIImageView* m_lightsImageView;
    TTLabel* m_lightsLabel;
    
    // Backboard button
    UIImage* m_backboardOnImage;
    UIImage* m_backboardOffImage;
    UIImageView* m_backboardImageView;
    TTLabel* m_backboardLabel;
    
    // Picker
    NSArray* m_pickerSelections;
    
    // Delegate
	MapViewController* m_mapView;
}

@property (nonatomic, readonly) bool lights;
@property (nonatomic, readonly) bool backboard;
@property (nonatomic, readonly) int courts;
@property (nonatomic, readonly) int rating;
@property (nonatomic, retain) MapViewController *mapView;

- (void)createRatingViewWithParentView:(UIView*)parentView;
- (void)createPickerWithParentView:(UIView*)parentView;
- (void)createLightsButtonWithParentView:(UIView*)parentView;
- (void)createBackboardButtonWithParentView:(UIView*)parentView;
- (IBAction)lightsButtonPressed:(id)sender;
- (IBAction)backboardButtonPressed:(id)sender;
- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating;
- (void)picker:(PBHorizontalPicker*)picker didSelectItemWithIndex:(int)index;
- (void)updateFilter;

@end
