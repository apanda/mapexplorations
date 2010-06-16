//
//  PBInformationView.h
//  MapExploration
//
//  Created by Itay Neeman on 4/11/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinAnnotation.h"
#import "MapExplorationAppDelegate.h"
#import <SCRatingView.h>


@interface PBInformationView : UITableViewController <SCRatingDelegate> {
    PinAnnotation* m_annotation;
    MapExplorationAppDelegate *m_appDelegate;
    SCRatingView *m_ratingView;
}
@property (nonatomic, retain)PinAnnotation* currentAnnotation;

- (id)initWithStyle:(UITableViewStyle)style appDelegate: (MapExplorationAppDelegate*) appDelegate;
- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating;

@end
