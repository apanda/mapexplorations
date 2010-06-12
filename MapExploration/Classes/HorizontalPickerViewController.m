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

@implementation HorizontalPickerViewController

- (void)createRatingPickerWithParentView:(UIView*)parentView
{
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 141, 65)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTFourBorderStyle styleWithRight:[UIColor grayColor] width:1.0 next:nil];
    
    UIImage* selectedStar = [UIImage imageNamed:@"star_large_on.png"];
    UIImage* nonselectedStar = [UIImage imageNamed:@"star_large_off.png"];
    
    SCRatingView* m_ratingView = [[SCRatingView alloc] initWithFrame:CGRectMake(9, 10, selectedStar.size.width * 5, selectedStar.size.height)];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewSelected];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewUserSelected];
    [m_ratingView setStarImage:nonselectedStar forState:kSCRatingViewNonSelected];
    
    m_ratingView.userRating = 2;
    
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
    int pickerWidth = 290;
    int pickerHeight = 48;
    
    NSArray* strings = [NSArray arrayWithObjects:@"1+", @"2-4", @"4-8", @"8-12", @"12-16", @"16-20", @"20+", nil];
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
    
    PBHorizontalPicker* picker = [[PBHorizontalPicker alloc] initWithFrame:CGRectMake(5, 6, pickerWidth, pickerHeight) labels:labels];
    picker.layer.borderWidth = 1;
    [containerView addSubview:picker];
    
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
    courtsLabel.origin = CGPointMake(CGRectGetMidX(picker.bounds) - courtsLabel.size.width / 2, CGRectGetMaxY(picker.bounds) - courtsLabel.size.height);
    [picker addSubview:courtsLabel];
    
    [parentView addSubview:containerView];
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
    
    [self createRatingPickerWithParentView:parentView];
    [self createPickerWithParentView:parentView];
    //////
    
    [borderView addSubview:parentView];
    [self.view addSubview:borderView];
}

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];

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
