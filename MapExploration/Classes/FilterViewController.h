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
@interface FilterViewController : UITableViewController {
	UISwitch *m_lights;
	UISwitch *m_backboard;
	UISwitch *m_indoor;
	MapExplorationAppDelegate *m_delegate;
}

-(id)initWithStyle:(UITableViewStyle)style withAppDelegate:(MapExplorationAppDelegate*)delegate;

@end
