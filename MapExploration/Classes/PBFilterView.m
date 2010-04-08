//
//  PBFilterView.m
//  MapExploration
//
//  Created by Itay Neeman on 4/7/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBFilterView.h"


@implementation PBFilterView
@synthesize mapView = m_mapView;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
      // Initialization code
      TTTableView* tableView = [[[TTTableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) 
                                                             style:UITableViewStyleGrouped] autorelease];
	  
	  //m_mapController = controller;
      m_indoor = [[UISwitch alloc] init];
	  [m_indoor addTarget:self action:@selector(changeFilter) forControlEvents:UIControlEventValueChanged];
      m_backboard = [[UISwitch alloc] init];
	  [m_backboard addTarget:self action:@selector(changeFilter) forControlEvents:UIControlEventValueChanged];
      m_lights = [[UISwitch alloc] init];
	  [m_lights addTarget:self action:@selector(changeFilter) forControlEvents:UIControlEventValueChanged];
	  
	  m_courts = [[UISlider alloc] init];
	  m_courts.minimumValue = 0;
	  m_courts.maximumValue = 10;
	  [m_courts addTarget:self action:@selector(changeFilter) forControlEvents:UIControlEventValueChanged];
	  m_courts.continuous = NO;
		
	  m_rating = [[UISlider alloc] init];
	  m_rating.minimumValue = 0;
	  m_rating.maximumValue = 5;
	  [m_rating addTarget:self action:@selector(changeFilter) forControlEvents:UIControlEventValueChanged];
	  m_rating.continuous = NO;
		
      [TTStyleSheet setGlobalStyleSheet:[[TTDefaultStyleSheet alloc] init]];
      TTTableControlItem *lightControl = [TTTableControlItem itemWithCaption:@"Lights" control:m_lights];
      TTTableControlItem *indoorControl = [TTTableControlItem itemWithCaption:@"Indoor" control:m_indoor];
      TTTableControlItem *backboardControl = [TTTableControlItem itemWithCaption:@"Backboard" control:m_backboard];
	  TTTableControlItem *courtsControl = [TTTableControlItem itemWithCaption:@"Courts" control:m_courts];
	  TTTableControlItem *ratingControl = [TTTableControlItem itemWithCaption:@"Rating" control:m_rating];
      tableView.dataSource = [[TTListDataSource dataSourceWithObjects:
                         lightControl,
                         indoorControl,
                         backboardControl,
						 courtsControl,
						 ratingControl,
                         nil] retain];
      
      self.backgroundColor = [UIColor clearColor];
      [self addSubview:tableView];
    }
    return self;
}
	   
- (void) changeFilter {
	[m_mapView recalculateFilter];
	NSLog(@"Changed filter");
	
}

- (bool) lights {
	return m_lights.on;
}

- (bool) indoor {
	return m_indoor.on;
}

- (bool) backboard {
	return m_backboard.on;
}

- (int) rating {
	return m_rating.value;
}

- (int) courts {
	return m_courts.value;
}

- (void)dealloc {
	[m_indoor release];
	[m_backboard release];
	[m_lights release];
	[m_rating release];
	[m_courts release];
  
	[super dealloc];
}

@end
