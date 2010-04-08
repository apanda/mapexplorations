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
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
    [super dealloc];
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 2;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (section == 0) {
		return 3;
	}
	else {
		return 1;
	}
  
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
	int section = [indexPath indexAtPosition:0];
	UITableViewCell *cell = nil;
	if (section == 0) {
		static NSString *CellIdentifier = @"FilterCell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			//cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
      cell = [[[TTTableControlCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		}
    /*
		cell.accessoryType = UITableViewCellAccessoryNone;
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		int index = [indexPath indexAtPosition:1];
		if (index == 0) {
			cell.textLabel.text = @"Name";
			cell.detailTextLabel.text = self.currentAnnotation.name;
		}
		else if (index == 1){
			cell.textLabel.text = @"Address";
			cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
			cell.detailTextLabel.numberOfLines = 5;
			cell.autoresizingMask = UIViewAutoresizingFlexibleHeight;
			cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%@\n%@, WA", self.currentAnnotation.address, self.currentAnnotation.city];
			cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		}
		else if (index == 2) {
			cell.textLabel.text = @"Courts";
			cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d", self.currentAnnotation.numCourts];
		}*/
	}
	else if (section == 1) {
    /*
		static NSString *CellIdentifier = @"RatingFilterCell";
		
		cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
			m_ratingView = [[SCRatingView alloc] initWithFrame: cell.frame];
			[m_ratingView setDelegate:self];
			m_ratingView.rating = 2;
			//m_ratingView.userInteractionEnabled = FALSE;
			[m_ratingView setStarImage:[UIImage imageNamed:@"star-halfselected.png"]
                        forState:kSCRatingViewHalfSelected];
			[m_ratingView setStarImage:[UIImage imageNamed:@"star-highlighted.png"]
                        forState:kSCRatingViewHighlighted];
			[m_ratingView setStarImage:[UIImage imageNamed:@"star-hot.png"]
                        forState:kSCRatingViewHot];
			[m_ratingView setStarImage:[UIImage imageNamed:@"star-nonselected.png"]
                        forState:kSCRatingViewNonSelected];
			[m_ratingView setStarImage:[UIImage imageNamed:@"star-selected.png"]
                        forState:kSCRatingViewSelected];
			[m_ratingView setStarImage:[UIImage imageNamed:@"star-userselected.png"]
                        forState:kSCRatingViewUserSelected];
			
			[cell.contentView addSubview:m_ratingView];
			UIView *transparentBackground = [[UIView alloc] initWithFrame:CGRectZero];
			transparentBackground.backgroundColor = [UIColor clearColor];
			cell.backgroundView = transparentBackground;
		}
		cell.selectionStyle = UITableViewCellSelectionStyleNone;	
		m_ratingView.rating = self.currentAnnotation.rating;
		*/
	}
  // Set up the cell...
	
	
  return cell;
}

#pragma mark Star Rating Delegate Methods

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating
{
  
}

- (void)ratingView:(SCRatingView *)ratingView didChangeRatingFrom:(CGFloat)previousRating to:(CGFloat)rating
{
}

@end
