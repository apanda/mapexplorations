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


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
    self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame] autorelease];

    [self createPicker];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)createPicker
{
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
    
    PBHorizontalPicker* picker = [[PBHorizontalPicker alloc] initWithFrame:CGRectMake(320 / 2 - pickerWidth / 2, 0, pickerWidth, pickerHeight) labels:labels];
    [self.view addSubview:picker];
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
