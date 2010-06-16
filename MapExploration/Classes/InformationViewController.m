//
//  InformationView.m
//  MapExploration
//
//  Created by Aurojit Panda on 2/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InformationViewController.h"


@implementation InformationViewController
@synthesize currentAnnotation = m_annotation;

- (id)initWithStyle:(UITableViewStyle)style appDelegate: (MapExplorationAppDelegate*) appDelegate {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    self = [super initWithStyle:style];
    [TTStyleSheet setGlobalStyleSheet:[[TTDefaultStyleSheet alloc] init]];
    m_appDelegate = appDelegate;
    
        
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.tableView.editing = NO;
    self.title = self.currentAnnotation.name;
    [m_appDelegate showNavigationBar];
    [m_appDelegate hideToolbar];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
        static NSString *CellIdentifier = @"Cell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
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
        }
    }
    else if (section == 1) {
        static NSString *CellIdentifier = @"RatingCell";
        
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
        //cell.textLabel.text = @"Rating";
        //cell.detailTextLabel.text = [[NSString alloc] initWithFormat:@"%d", self.currentAnnotation.rating];
        
    }
    // Set up the cell...
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    // return [super tableView: tableView heightForRowAtIndexPath: indexPath];
    if ([indexPath indexAtPosition:1] != 1) {
        return tableView.rowHeight;
    
    }
    CGSize maxSize;
    float height = 2009;
    float width = CGRectGetWidth(tableView.frame) - 200;
    maxSize = CGSizeMake(width, height);
    CGSize size = [self.currentAnnotation.address sizeWithFont:[UIFont systemFontOfSize: [UIFont systemFontSize]] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    CGSize size2 = [self.currentAnnotation.city sizeWithFont:[UIFont systemFontOfSize: [UIFont systemFontSize]] constrainedToSize:maxSize lineBreakMode:UILineBreakModeWordWrap];
    return size.height + size2.height + 5.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    int section = [indexPath indexAtPosition:0];
    int index = [indexPath indexAtPosition:1];
    
    if (section == 0 && index == 1) {
        UIApplication *app = [UIApplication sharedApplication];
        
        NSString *address;
        
        address = [NSString stringWithFormat:@"%@ %@ %@, WA", 
                             self.currentAnnotation.address, 
                             self.currentAnnotation.neighborhood
                             ,self.currentAnnotation.city];
        
        NSString* encodedAddress = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                           (CFStringRef)address,
                                                           NULL,
                                                           (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                          kCFStringEncodingUTF8);
        
        NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", 
                               encodedAddress];
        
        [app openURL:[NSURL URLWithString: urlString]];
    }
}

- (void)dealloc {
    [super dealloc];
}

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating
{
    //NSLog(@"New rating %d\n", userRating);
    self.currentAnnotation.rating = userRating;
    [m_appDelegate updateRatingForAnnotation:self.currentAnnotation];
}

- (void)ratingView:(SCRatingView *)ratingView didChangeRatingFrom:(CGFloat)previousRating to:(CGFloat)rating
{
}
@end

