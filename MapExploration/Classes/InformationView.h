//
//  InformationView.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinAnnotation.h"
#import "MapExplorationAppDelegate.h"
#import <SCRatingView.h>

@class PinAnnotation;
@class MapExplorationAppDelegate;

@interface InformationView : UITableViewController {
	PinAnnotation* m_annotation;
	MapExplorationAppDelegate *m_appDelegate;
	SCRatingView *m_ratingView;
}
- (id)initWithStyle:(UITableViewStyle)style appDelegate: (MapExplorationAppDelegate*) appDelegate;

@property (nonatomic, retain)PinAnnotation* currentAnnotation;
@end
