//
//  PBFilterView.m
//  MapExploration
//
//  Created by Itay Neeman on 4/7/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBFilterView.h"


@implementation PBFilterView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      // Initialization code
      TTTableView* tableView = [[[TTTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) 
                                                             style:UITableViewStyleGrouped] autorelease];
      
      m_indoor = [[[UISwitch alloc] init] retain];
      m_backboard = [[[UISwitch alloc] init] retain];
      m_lights = [[[UISwitch alloc] init] retain];
      
      [TTStyleSheet setGlobalStyleSheet:[[TTDefaultStyleSheet alloc] init]];
      TTTableControlItem *lightControl = [TTTableControlItem itemWithCaption:@"Lights" control:m_lights];
      TTTableControlItem *indoorControl = [TTTableControlItem itemWithCaption:@"Indoor" control:m_indoor];
      TTTableControlItem *backboardControl = [TTTableControlItem itemWithCaption:@"Backboard" control:m_backboard];
      tableView.dataSource = [TTListDataSource dataSourceWithObjects:
                         lightControl,
                         indoorControl,
                         backboardControl,
                         nil];
      
      self.backgroundColor = [UIColor clearColor];
      [self addSubview:tableView];
    }
    return self;
}

- (void)dealloc {
  [m_indoor release];
  [m_backboard release];
  [m_lights release];
  
  [super dealloc];
}

#pragma mark Star Rating Delegate Methods

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating
{
  
}

- (void)ratingView:(SCRatingView *)ratingView didChangeRatingFrom:(CGFloat)previousRating to:(CGFloat)rating
{
}

@end
