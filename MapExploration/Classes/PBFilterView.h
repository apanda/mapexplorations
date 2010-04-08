//
//  PBFilterView.h
//  MapExploration
//
//  Created by Itay Neeman on 4/7/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SCRatingView.h>
#import "Three20/Three20.h"
#import "MapViewController.h"

@class MapViewController;
@interface PBFilterView : UIView <UITableViewDelegate> {
	UISwitch *m_lights;
	UISwitch *m_backboard;
	UISwitch *m_indoor;
	UISlider *m_courts;
	UISlider *m_rating;
	MapViewController *m_mapView;
}

@property (nonatomic, readonly) bool lights;
@property (nonatomic, readonly) bool backboard;
@property (nonatomic, readonly) bool indoor;
@property (nonatomic, readonly) int courts;
@property (nonatomic, readonly) int rating;
@property (nonatomic, retain) MapViewController *mapView;
- (void) changeFilter;

@end
