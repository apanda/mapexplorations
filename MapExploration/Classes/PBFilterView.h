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

@interface PBFilterView : UIView <UITableViewDelegate> {
	UISwitch *m_lights;
	UISwitch *m_backboard;
	UISwitch *m_indoor;
}

@end
