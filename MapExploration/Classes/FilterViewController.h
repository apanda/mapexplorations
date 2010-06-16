//
//  FilterView.h
//  MapExploration
//
//  Created by Aurojit Panda on 4/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Three20/Three20.h>
#import "MapExplorationAppDelegate.h"


@class MapExplorationAppDelegate;
@interface FilterViewController : TTTableViewController {
    UISwitch *m_lights;
    UISwitch *m_backboard;
    UISwitch *m_indoor;
    UISlider *m_courts;
    UISlider *m_rating;
    MapExplorationAppDelegate *m_delegate;
}
@property (nonatomic, readonly) bool lights;

-(id)initWithAppDelegate: (MapExplorationAppDelegate*) delegate;//WithStyle:(UITableViewStyle)style withAppDelegate:(MapExplorationAppDelegate*)delegate;

@end
