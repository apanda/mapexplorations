//
//  HorizontalPickerViewController.h
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/8/10.
//  Copyright Mighty Panda 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Three20/Three20.h"
#import "SCRatingView.h"
#import "PBHorizontalPicker.h"

@interface PBTennisStyleSheet : TTDefaultStyleSheet
{
    
}



@end


@interface HorizontalPickerViewController : UIViewController <SCRatingDelegate, PBHorizontalPickerDelegate> 
{
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
}


- (void)createRatingViewWithParentView:(UIView*)parentView;
- (void)createPickerWithParentView:(UIView*)parentView;
- (void)createLightsButtonWithParentView:(UIView*)parentView;
- (void)createBackboardButtonWithParentView:(UIView*)parentView;    
- (IBAction)lightsButtonPressed:(id)sender;
- (IBAction)backboardButtonPressed:(id)sender;
- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating;
- (void)picker:(PBHorizontalPicker*)picker didSelectItemWithIndex:(int)index;

@end

