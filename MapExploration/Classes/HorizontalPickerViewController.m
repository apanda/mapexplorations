//
//  HorizontalPickerViewController.m
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/8/10.
//  Copyright Mighty Panda 2010. All rights reserved.
//

#import "HorizontalPickerViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PBHorizontalPicker.h"

@implementation PBTennisStyleSheet

- (TTStyle*)filterButton:(UIControlState)state {
    return
    [TTPartStyle styleWithName:@"image" style:TTSTYLESTATE(filterButtonImage:, state) next:
     [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(10, 0, 0, 0) next:
      [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] color:[UIColor whiteColor]
                 minimumFontSize:11 shadowColor:nil
                    shadowOffset:CGSizeZero next:nil]]];
}

- (TTStyle*)filterButtonImage:(UIControlState)state {
    TTStyle* style =
    [TTBoxStyle styleWithMargin:UIEdgeInsetsMake(-7, 0, 11, 0) next:
     [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeCenter
                                 size:CGSizeZero next:nil]];
    
    if (state == UIControlStateHighlighted || state == UIControlStateSelected) {
        [style addStyle:
         [TTBlendStyle styleWithBlend:kCGBlendModeSourceAtop next:
          [TTSolidFillStyle styleWithColor:RGBACOLOR(0,0,0,0.5) next:nil]]];
    }
    
    return style;
}

@end


@implementation HorizontalPickerViewController

- (void)createRatingViewWithParentView:(UIView*)parentView
{
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 141, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithRight:[UIColor grayColor] width:1.0 next:nil];
    
    UIImage* selectedStar = [UIImage imageNamed:@"star_large_on.png"];
    UIImage* nonselectedStar = [UIImage imageNamed:@"star_large_off.png"];
    
    SCRatingView* ratingView = [[[SCRatingView alloc] initWithFrame:CGRectMake(9, 10, selectedStar.size.width * 5, selectedStar.size.height)] autorelease];
    [ratingView setStarImage:selectedStar forState:kSCRatingViewSelected];
    [ratingView setStarImage:selectedStar forState:kSCRatingViewUserSelected];
    [ratingView setStarImage:selectedStar forState:kSCRatingViewHot];
    [ratingView setStarImage:nonselectedStar forState:kSCRatingViewNonSelected];
    
    ratingView.userRating = 2;
    ratingView.delegate = self;
    
    [containerView addSubview:ratingView];
    
    TTLabel* ratingLabel = [[[TTLabel alloc] initWithFrame:CGRectZero] autorelease];
    ratingLabel.backgroundColor = [UIColor clearColor];
    ratingLabel.text = @"Minimum Rating";
    ratingLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:11 
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
    int pickerWidth = 290;
    int pickerHeight = 48;
    
    m_pickerSelections = [[NSArray arrayWithObjects:
                          [NSNumber numberWithInt:1],
                          [NSNumber numberWithInt:2],
                          [NSNumber numberWithInt:4],
                          [NSNumber numberWithInt:8],
                          [NSNumber numberWithInt:11],
                          [NSNumber numberWithInt:16],
                          [NSNumber numberWithInt:20],
                          nil] retain];
    
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
        label.font = [UIFont fontWithName:@"Verdana" size:20];
        label.textAlignment = UITextAlignmentCenter;
        
        [labels addObject:label];
    }
    
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(0, 65, 300, 60)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithTop:[UIColor grayColor] width:1.0 next:nil];
    
    PBHorizontalPicker* picker = [[PBHorizontalPicker alloc] initWithFrame:CGRectMake(5, 6, pickerWidth, pickerHeight) labels:labels];
    picker.layer.borderWidth = 1;
    [containerView addSubview:picker];
    
    TTLabel* courtsLabel = [[[TTLabel alloc] initWithFrame:CGRectZero] autorelease];
    courtsLabel.backgroundColor = [UIColor clearColor];
    courtsLabel.text = @"Courts";
    courtsLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] 
                                                  color:[UIColor whiteColor] 
                                        minimumFontSize:11 
                                            shadowColor:[UIColor clearColor] 
                                           shadowOffset:CGSizeMake(0, 0) 
                                          textAlignment:UITextAlignmentCenter
                                      verticalAlignment:UIControlContentVerticalAlignmentTop 
                                          lineBreakMode:UILineBreakModeTailTruncation 
                                          numberOfLines:1 
                                                   next:nil];
    [courtsLabel sizeToFit];
    courtsLabel.origin = CGPointMake(CGRectGetMidX(picker.bounds) - courtsLabel.size.width / 2, CGRectGetMaxY(picker.bounds) - courtsLabel.size.height);
    [picker addSubview:courtsLabel];
    
    picker.delegate = self;
    
    [parentView addSubview:containerView];
}

- (void)createLightsButtonWithParentView:(UIView*)parentView
{
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(141, 0, 80, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithRight:[UIColor grayColor] width:1.0 next:nil];
    
    UIButton* lightsButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 65)] autorelease];;
    lightsButton.backgroundColor = [UIColor clearColor];
    
    m_lightsOnImage = [[UIImage imageNamed:@"light_on.png"] retain];
    m_lightsOffImage = [[UIImage imageNamed:@"light_off.png"] retain];
    m_lightsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(lightsButton.width / 2 - m_lightsOnImage.size.width / 2, 13, m_lightsOnImage.size.width, m_lightsOnImage.size.height)];
    m_lightsImageView.image = m_lightsOnImage;
    
    [lightsButton addSubview:m_lightsImageView];
    
    m_lightsLabel = [[TTLabel alloc] initWithFrame:CGRectZero];
    m_lightsLabel.backgroundColor = [UIColor clearColor];
    m_lightsLabel.text = @"Lights";
    m_lightsLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:11 
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
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(221, 0, 80, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    
    UIButton* backboardButton = [[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 65)] autorelease];;
    backboardButton.backgroundColor = [UIColor clearColor];
    
    m_backboardOnImage = [[UIImage imageNamed:@"backboard_on.png"] retain];
    m_backboardOffImage = [[UIImage imageNamed:@"backboard_off.png"] retain];
    m_backboardImageView = [[UIImageView alloc] initWithFrame:CGRectMake(backboardButton.width / 2 - m_backboardOnImage.size.width / 2, 13, m_backboardOnImage.size.width, m_backboardOnImage.size.height)];
    m_backboardImageView.image = m_backboardOnImage;
    
    [backboardButton addSubview:m_backboardImageView];
    
    m_backboardLabel = [[TTLabel alloc] initWithFrame:CGRectZero];
    m_backboardLabel.backgroundColor = [UIColor clearColor];
    m_backboardLabel.text = @"Backboard";
    m_backboardLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:11 
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

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating
{
    NSLog(@"Changed Rating From %d to %d", previousUserRating, userRating);
}  

- (void)picker:(PBHorizontalPicker*)picker didSelectItemWithIndex:(int)index
{
    NSLog(@"Changed selected court minimum: %d", [[m_pickerSelections objectAtIndex:index] intValue]);
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
}

- (void)createFilterView
{
    const int borderViewHeight = 145;
    
    UIView* borderView = [[[TTView alloc] initWithFrame:CGRectMake(0, 460 - borderViewHeight, 320, borderViewHeight)] autorelease];
    borderView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    TTView* parentView = [[[TTView alloc] initWithFrame:CGRectMake(10, 10, 300, 125)] autorelease];
    parentView.backgroundColor = [UIColor clearColor];
    parentView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:10.0 topRight:10.0 bottomRight:10.0 bottomLeft:10.0] next:
                           [TTLinearGradientFillStyle styleWithColor1:[UIColor darkGrayColor] color2:[UIColor blackColor] next:
                            [TTSolidBorderStyle styleWithColor:[UIColor grayColor] width:1.0 next:nil]]];
    
    //////
    
    [self createRatingViewWithParentView:parentView];
    [self createPickerWithParentView:parentView];
    [self createLightsButtonWithParentView:parentView];
    [self createBackboardButtonWithParentView:parentView];    
    //////
    
    [borderView addSubview:parentView];
    [self.view addSubview:borderView];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];

    [TTDefaultStyleSheet setGlobalStyleSheet:[[[PBTennisStyleSheet alloc] init] autorelease]];
    
    //[self createPicker];
    [self createFilterView];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
