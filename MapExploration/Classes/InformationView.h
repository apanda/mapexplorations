//
//  InformationView.h
//  MapExploration
//
//  Created by Aurojit Panda on 2/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PinAnnotation.h"

@class PinAnnotation;

@interface InformationView : UITableViewController {
	PinAnnotation* m_annotation;
}

@property (nonatomic, retain)PinAnnotation* currentAnnotation;
@end
