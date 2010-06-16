//
//  PBFilterViewController2.m
//  MapExploration
//
//  Created by Itay Neeman on 6/12/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBFilterViewController2.h"


@implementation PBFilterViewController2

@synthesize mapView = m_mapView;

#pragma mark Private Functions

- (void)createRatingViewWithParentView:(UIView*)parentView
{
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 136, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithRight:[UIColor grayColor] width:1.0 next:nil];
    
    UIImage* selectedStar = [UIImage imageNamed:@"star_large_on.png"];
    UIImage* nonselectedStar = [UIImage imageNamed:@"star_large_off.png"];
    
    m_ratingView = [[SCRatingView alloc] initWithFrame:CGRectMake(containerView.width / 2 - selectedStar.size.width * 5 / 2, 10, selectedStar.size.width * 5, selectedStar.size.height)];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewSelected];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewUserSelected];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewHot];
    [m_ratingView setStarImage:nonselectedStar forState:kSCRatingViewNonSelected];
    
    m_ratingView.userRating = 1;
    m_ratingView.delegate = self;
    
    [containerView addSubview:m_ratingView];
    
    TTLabel* ratingLabel = [[[TTLabel alloc] initWithFrame:CGRectZero] autorelease];
    ratingLabel.backgroundColor = [UIColor clearColor];
    ratingLabel.text = @"Minimum Rating";
    ratingLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:12] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:12 
                                       shadowColor:[UIColor clearColor] 
                                      shadowOffset:CGSizeMake(0, 0) 
                                     textAlignment:UITextAlignmentCenter
                                 verticalAlignment:UIControlContentVerticalAlignmentTop 
                                     lineBreakMode:UILineBreakModeTailTruncation 
                                     numberOfLines:1 
                                              next:nil];
    [ratingLabel sizeToFit];
    ratingLabel.size = CGSizeMake(141, ratingLabel.size.height);
    ratingLabel.origin = CGPointMake(0, CGRectGetMaxY(containerView.frame) - 10 - ratingLabel.size.height);
    
    [containerView addSubview:ratingLabel];
    
    [parentView addSubview:containerView];
}


- (void)createPickerWithParentView:(UIView*)parentView
{
    int pickerWidth = 298;
    int pickerHeight = 48;
    
    MapExplorationAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    
    int minCourts = appDelegate.database.MinCourts;
    int maxCourts = appDelegate.database.MaxCourts;
     
    NSMutableArray* pickerSelections = [[[NSMutableArray alloc] init] autorelease];
    
    [pickerSelections addObject:[NSNumber numberWithInt:minCourts]];
    [pickerSelections addObject:[NSNumber numberWithInt:minCourts+1]];
    
    int curNumCourts = minCourts+1 + 4;
    while (curNumCourts < maxCourts) {
        [pickerSelections addObject:[NSNumber numberWithInt:curNumCourts]];
        
        curNumCourts += 4;
    }
    
    [pickerSelections addObject:[NSNumber numberWithInt:maxCourts]];
    
    
    m_pickerSelections = [[NSArray arrayWithArray:pickerSelections] retain];
    
    NSMutableArray* strings = [[[NSMutableArray alloc] initWithCapacity:[m_pickerSelections count]] autorelease];
    [strings addObject:[NSString stringWithFormat:@"%d+", [[m_pickerSelections objectAtIndex:0] intValue]]];
    for(int i = 1; i < [m_pickerSelections count]; i++) {
        NSString* string;
        if (i == ([m_pickerSelections count] - 1)) {
            string = [NSString stringWithFormat:@"%d+", [[m_pickerSelections objectAtIndex:i] intValue]];
        }
        else {
            string = [NSString stringWithFormat:@"%d-%d", [[m_pickerSelections objectAtIndex:i] intValue], [[m_pickerSelections objectAtIndex:i+1] intValue]];
        }
        
        [strings addObject:string];
    }
    
    NSMutableArray* labels = [[NSMutableArray alloc] initWithCapacity:[strings count]];
    for(int i = 0; i < [strings count]; i++) {
        NSString* string = [strings objectAtIndex:i];
        UILabel* label = [[UILabel alloc] init];
        label.text = string;
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:20];
        label.textAlignment = UITextAlignmentCenter;
        
        [labels addObject:label];
    }
    
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(0, 65, 300, 60)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithTop:[UIColor grayColor] width:1.0 next:nil];
    
    m_courtsPicker = [[PBHorizontalPicker alloc] initWithFrame:CGRectMake(0, 0, pickerWidth, pickerHeight) labels:labels];
    
    TTView* pickerContainerView = [[[TTView alloc] initWithFrame:CGRectMake(1, 3, pickerWidth, pickerHeight)] autorelease];
    pickerContainerView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:10] next:
                                 [TTSolidFillStyle styleWithColor:[UIColor clearColor] next:
                                  [TTFourBorderStyle styleWithBottom:[UIColor darkGrayColor] width:1 next:nil]]];
    pickerContainerView.backgroundColor = [UIColor clearColor];
    
    [pickerContainerView addSubview:m_courtsPicker];
    
    [containerView addSubview:pickerContainerView];
    
    TTLabel* courtsLabel = [[[TTLabel alloc] initWithFrame:CGRectZero] autorelease];
    courtsLabel.backgroundColor = [UIColor clearColor];
    courtsLabel.text = @"Courts";
    courtsLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:12] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:12 
                                       shadowColor:[UIColor clearColor] 
                                      shadowOffset:CGSizeMake(0, 0) 
                                     textAlignment:UITextAlignmentCenter
                                 verticalAlignment:UIControlContentVerticalAlignmentTop 
                                     lineBreakMode:UILineBreakModeTailTruncation 
                                     numberOfLines:1 
                                              next:nil];
    [courtsLabel sizeToFit];
    courtsLabel.origin = CGPointMake(CGRectGetMidX(m_courtsPicker.bounds) - courtsLabel.size.width / 2, CGRectGetMaxY(m_courtsPicker.bounds) - courtsLabel.size.height - 1);
    [m_courtsPicker addSubview:courtsLabel];
    
    m_courtsPicker.delegate = self;
    
    [parentView addSubview:containerView];
}

- (void)createLightsButtonWithParentView:(UIView*)parentView
{
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(136, 0, 80, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithRight:[UIColor grayColor] width:1.0 next:nil];
    
    UIButton* lightsButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 65)] autorelease];;
    lightsButton.backgroundColor = [UIColor clearColor];
    
    m_lightsOnImage = [[UIImage imageNamed:@"light_on.png"] retain];
    m_lightsOffImage = [[UIImage imageNamed:@"light_off.png"] retain];
    m_lightsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lightsButton.width / 2 - m_lightsOffImage.size.width / 2, 13, m_lightsOffImage.size.width, m_lightsOffImage.size.height)];
    m_lightsImageView.image = m_lightsOffImage;
    
    [lightsButton addSubview:m_lightsImageView];
    
    m_lightsLabel = [[TTLabel alloc] initWithFrame:CGRectZero];
    m_lightsLabel.backgroundColor = [UIColor clearColor];
    m_lightsLabel.text = @"No Lights";
    m_lightsLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:12] 
                                               color:[UIColor darkGrayColor]  
                                     minimumFontSize:12 
                                         shadowColor:[UIColor clearColor] 
                                        shadowOffset:CGSizeMake(0, 0) 
                                       textAlignment:UITextAlignmentCenter
                                   verticalAlignment:UIControlContentVerticalAlignmentTop 
                                       lineBreakMode:UILineBreakModeTailTruncation 
                                       numberOfLines:1 
                                                next:nil];
    [m_lightsLabel sizeToFit];
    m_lightsLabel.size = CGSizeMake(lightsButton.width, m_lightsLabel.size.height);
    m_lightsLabel.origin = CGPointMake(0, CGRectGetMaxY(lightsButton.frame) - 10 - m_lightsLabel.size.height);
    
    [lightsButton addSubview:m_lightsLabel];
    
    [lightsButton addTarget:self action:@selector(lightsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView addSubview:lightsButton];
    
    [parentView addSubview:containerView];
}

- (void)createBackboardButtonWithParentView:(UIView*)parentView
{
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(216, 0, 80, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    
    UIButton* backboardButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 65)] autorelease];;
    backboardButton.backgroundColor = [UIColor clearColor];
    
    m_backboardOnImage = [[UIImage imageNamed:@"backboard_on.png"] retain];
    m_backboardOffImage = [[UIImage imageNamed:@"backboard_off.png"] retain];
    m_backboardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backboardButton.width / 2 - m_backboardOffImage.size.width / 2, 13, m_backboardOffImage.size.width, m_backboardOffImage.size.height)];
    m_backboardImageView.image = m_backboardOffImage;
    
    [backboardButton addSubview:m_backboardImageView];
    
    m_backboardLabel = [[TTLabel alloc] initWithFrame:CGRectZero];
    m_backboardLabel.backgroundColor = [UIColor clearColor];
    m_backboardLabel.text = @"No Backboard";
    m_backboardLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:12] 
                                                  color:[UIColor darkGrayColor] 
                                        minimumFontSize:12 
                                            shadowColor:[UIColor clearColor] 
                                           shadowOffset:CGSizeMake(0, 0) 
                                          textAlignment:UITextAlignmentCenter
                                      verticalAlignment:UIControlContentVerticalAlignmentTop 
                                          lineBreakMode:UILineBreakModeTailTruncation 
                                          numberOfLines:1 
                                                   next:nil];
    [m_backboardLabel sizeToFit];
    m_backboardLabel.size = CGSizeMake(backboardButton.width, m_backboardLabel.size.height);
    m_backboardLabel.origin = CGPointMake(0, CGRectGetMaxY(backboardButton.frame) - 10 - m_backboardLabel.size.height);
    
    [backboardButton addSubview:m_backboardLabel];
    
    [backboardButton addTarget:self action:@selector(backboardButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [containerView addSubview:backboardButton];
    
    [parentView addSubview:containerView];
}

- (void)createFilterView
{    
    UIImage* meshImage = [UIImage imageNamed:@"mesh.png"];
    UIColor* meshColor = [[UIColor colorWithPatternImage:meshImage] colorWithAlphaComponent:0.8];
    
    UIView* parentView = [[[UIView alloc] initWithFrame:CGRectMake(10, 10, 300, 125)] autorelease];
    parentView.backgroundColor = [UIColor colorWithRed:0.1294 green:0.1294 blue:0.1294 alpha:1.0];
    parentView.layer.cornerRadius = 10;
    parentView.layer.masksToBounds = YES;
    parentView.layer.borderColor = [UIColor colorWithRed:0.1647 green:0.1647 blue:0.1647 alpha:1.0].CGColor;
    parentView.layer.borderWidth = 1.5;
    
    UIView* meshBackgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, parentView.size.width, parentView.size.height)] autorelease];
    meshBackgroundView.backgroundColor = meshColor;
    meshBackgroundView.opaque = NO;
    
    [parentView addSubview:meshBackgroundView];
    
    CAGradientLayer* gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, meshBackgroundView.size.width, meshBackgroundView.size.height);
    gradient.startPoint = CGPointMake(0.0, 0.0);
    gradient.endPoint = CGPointMake(0.0, 1.0);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor clearColor].CGColor,
                       (id)[[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor,
                       nil];
    gradient.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    gradient.opaque = NO;
    
    [meshBackgroundView.layer addSublayer:gradient];    
    
    //////
    
    [self createRatingViewWithParentView:parentView];
    [self createPickerWithParentView:parentView];
    [self createLightsButtonWithParentView:parentView];
    [self createBackboardButtonWithParentView:parentView];    
    //////
    
    [self.view addSubview:parentView];
}

#pragma mark Callbacks

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating
{
    [self updateFilter];
}  

- (void)picker:(PBHorizontalPicker*)picker didSelectItemWithIndex:(int)index
{
    [self updateFilter];
}

- (IBAction)lightsButtonPressed:(id)sender
{        
    // Handle toggle of lights
    if (m_lightsImageView.image == m_lightsOffImage) { // if it is currently off, set it as on
        m_lightsImageView.image = m_lightsOnImage;
        m_lightsLabel.text = @"Lights";
        TTTextStyle* textStyle = (TTTextStyle*)m_lightsLabel.style;
        textStyle.color = [UIColor whiteColor];
    }
    else { // if it is currently on, set it as off
           // doesn't have lights
        m_lightsImageView.image = m_lightsOffImage;
        m_lightsLabel.text = @"No Lights";
        TTTextStyle* textStyle = (TTTextStyle*)m_lightsLabel.style;
        textStyle.color = [UIColor darkGrayColor];
    }
    
    [self updateFilter];
}

- (IBAction)backboardButtonPressed:(id)sender
{    
    // Handle backboard of lights
    if (m_backboardImageView.image == m_backboardOffImage) { // if it is currently off, set it as on
        m_backboardImageView.image = m_backboardOnImage;
        m_backboardLabel.text = @"Backboard";
        TTTextStyle* textStyle = (TTTextStyle*)m_backboardLabel.style;
        textStyle.color = [UIColor whiteColor];
    }
    else { // if it is currently on, set it as off
           // doesn't have lights
        m_backboardImageView.image = m_backboardOffImage;
        m_backboardLabel.text = @"No Backboard";
        TTTextStyle* textStyle = (TTTextStyle*)m_backboardLabel.style;
        textStyle.color = [UIColor darkGrayColor];
    }
    
    [self updateFilter];
}

- (void) updateFilter 
{
	[m_mapView recalculateFilter];
	
}

#pragma mark Property Setters


- (bool) lights {
	return m_lightsImageView.image == m_lightsOnImage;
}

- (bool) backboard {
	return m_backboardImageView.image == m_backboardOnImage;
}

- (int) rating {
	return m_ratingView.userRating;
}

- (int) courts {
	return [[m_pickerSelections objectAtIndex:m_courtsPicker.selectedIndex] intValue];
}

#pragma mark UIViewController Functions

 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView 
{
    self.view = [[[UIView alloc] init] autorelease];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    [self createFilterView];
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


- (void)dealloc {
    [super dealloc];
}


@end
