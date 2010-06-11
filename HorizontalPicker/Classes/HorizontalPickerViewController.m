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

/*
const int kLabelSpacing = 10;
const int kLabelWidth = 55;
const int scrollViewWidth = 260;
const int scrollViewHeight = 50;
*/
@implementation HorizontalPickerViewController


/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

///int contentPadding = 0;

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)] autorelease];
    
    int pickerWidth = 290;
    int pickerHeight = 48;
    
    NSArray* strings = [NSArray arrayWithObjects:@"1-4", @"4-8", @"8-12", @"12-16", @"16-20", @"8-12", @"12-16", @"16-20", @"8-12", @"12-16", @"16-20", nil];
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
    
    PBHorizontalPicker* picker = [[PBHorizontalPicker alloc] initWithFrame:CGRectMake(320 / 2 - pickerWidth / 2, 50, pickerWidth, pickerHeight) labels:labels];
    [self.view addSubview:picker];
    
    UIView* centerView = [[UIView alloc] initWithFrame:CGRectMake(pickerWidth / 2 - 1 + picker.frame.origin.x, picker.frame.origin.y, 2, pickerHeight)];
    centerView.backgroundColor = [UIColor blueColor];
    //[self.view addSubview:centerView];
    
    self.view.backgroundColor = [UIColor blackColor];
    
/*    contentPadding = (scrollViewWidth / 2) - ((kLabelWidth / 2) + kLabelSpacing);
    
    UIView* containerView = [[UIView alloc] initWithFrame:CGRectMake(30, 50, scrollViewWidth, scrollViewHeight)];
    
    
    CAGradientLayer* shadowLayer = [CAGradientLayer layer];
    shadowLayer.frame = CGRectMake(0, 0, scrollViewWidth, scrollViewHeight);
    shadowLayer.startPoint = CGPointMake(0.0, 0);
    shadowLayer.endPoint = CGPointMake(1.0, 0);    
    shadowLayer.colors = [NSArray arrayWithObjects:
                          (id)[[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor,
                          (id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor,
                          (id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor,
                          (id)[[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor,
                          nil];
    
    shadowLayer.locations = [NSArray arrayWithObjects:
                             [NSNumber numberWithFloat:0.0],
                             [NSNumber numberWithFloat:0.40],
                             [NSNumber numberWithFloat:0.60],
                             [NSNumber numberWithFloat:1.0],
                             nil];
                                 
    NSArray* strings = [NSArray arrayWithObjects:@"1-4", @"4-8", @"8-12", @"12-16", @"16-20", @"8-12", @"12-16", @"16-20", @"8-12", @"12-16", @"16-20", nil];
    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewWidth, scrollViewHeight)];
    [containerView addSubview:scrollView];
    [containerView.layer addSublayer:shadowLayer];
    
    int contentWidth = [strings count] * kLabelWidth + ([strings count] + 1) * kLabelSpacing;
    
    scrollView.pagingEnabled = NO;
    scrollView.contentSize = CGSizeMake(contentWidth + 2 * contentPadding, scrollViewHeight);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.backgroundColor = [UIColor blackColor];
    scrollView.delegate = self;    
    scrollView.decelerationRate = 0.994;
    NSLog(@"%f --- %f", UIScrollViewDecelerationRateNormal, UIScrollViewDecelerationRateFast);
    
    //int inset = (scrollViewWidth / 2) - ((kLabelWidth / 2) + kLabelSpacing);
    
    //scrollView.contentInset = UIEdgeInsetsMake(0, inset, 0, inset);
    
    NSMutableArray* labels = [[NSMutableArray alloc] initWithCapacity:[strings count]];
    for(int i = 0; i < [strings count]; i++) {
        NSString* string = [strings objectAtIndex:i];
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(contentPadding + kLabelSpacing * (i + 1) + i * kLabelWidth, 0, kLabelWidth, scrollViewHeight)];
        label.text = string;
        label.textColor = [UIColor orangeColor];
        label.backgroundColor = [UIColor blackColor];
        label.font = [UIFont fontWithName:@"Helvetica" size:20];
        label.textAlignment = UITextAlignmentCenter;
        
        [labels addObject:label];
        [scrollView addSubview:label];
        
        CGPoint center = label.center;
        NSLog(@"Center %d: (%f, %f)", i, center.x, center.y);
    }
    
    [self.view addSubview:containerView];
        
    UIView* centerView = [[UIView alloc] initWithFrame:CGRectMake(scrollViewWidth / 2 - 1 + scrollView.frame.origin.x, 0, 2, scrollViewHeight)];
    centerView.backgroundColor = [UIColor blueColor];
    
    //[containerView addSubview:centerView];
    
    m_scrollView = scrollView;
    m_labels = labels;
    [m_scrollView scrollRectToVisible:CGRectZero animated:NO];*/
}
/*
- (int)labelIndexToScrollTo:(CGPoint)contentOffset
{
    float numerator = contentOffset.x + (kLabelWidth + kLabelSpacing) / 2;
    float denominator = (kLabelWidth + kLabelSpacing);
    
    int labelIndexToScrollTo = MIN(MAX(numerator / denominator, 0), [m_labels count] - 1);  
    
    return labelIndexToScrollTo;
}

- (CGPoint)pointToScrollTo:(int)labelIndex
{
    UILabel* labelToScrollTo = [m_labels objectAtIndex:labelIndex];
    CGPoint center = labelToScrollTo.center;
    
    return CGPointMake(center.x - scrollViewWidth / 2, 0);      
}

CGPoint startDecelerationPoint;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // First, get the label we would scroll to
    int labelIndexToScrollTo = [self labelIndexToScrollTo:scrollView.contentOffset];
    
    // Now, we want to find out if it is the same label if we had continued in the
    // same direction of the deceleration for just a little bit more
    CGPoint pointToScrollTo = [self pointToScrollTo:labelIndexToScrollTo];
    
    // UNCOMMENT THIS IF YOU WANT TO SNAP IN DIRECTION OF DECELERATION
    // Did we move left-to-right (positive) or right-to-left (negative)?
    if (scrollView.contentOffset.x > startDecelerationPoint.x) {
        // We moved left to right, so we only need to make sure that we didn't
        // scroll beyond the label we snapped to on the right
        if (pointToScrollTo.x < scrollView.contentOffset.x) {
            pointToScrollTo = CGPointMake(pointToScrollTo.x + kLabelWidth + kLabelSpacing, 0);
        }
    }
    else {
        // We moved right to left, so we only need to make sure that we didn't
        // scroll beyond the label we snapped to on the left
        if (pointToScrollTo.x > scrollView.contentOffset.x) {
            pointToScrollTo = CGPointMake(pointToScrollTo.x - (kLabelWidth + kLabelSpacing), 0);
        }
    }
    
    // snap us to the right place
    CGRect rectToScrollTo = scrollView.frame;
    rectToScrollTo.origin = pointToScrollTo;
    [scrollView scrollRectToVisible:rectToScrollTo animated:YES];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        int labelIndexToScrollTo = [self labelIndexToScrollTo:scrollView.contentOffset];
        CGPoint pointToScrollTo = [self pointToScrollTo:labelIndexToScrollTo];
        
        // snap us to the right place
        CGRect rectToScrollTo = scrollView.frame;
        rectToScrollTo.origin = pointToScrollTo;
        [scrollView scrollRectToVisible:rectToScrollTo animated:YES];
    }
    else {
        startDecelerationPoint = scrollView.contentOffset;
    }
}*/

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

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
