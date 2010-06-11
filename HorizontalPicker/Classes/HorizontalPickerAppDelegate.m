//
//  HorizontalPickerAppDelegate.m
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/8/10.
//  Copyright Mighty Panda 2010. All rights reserved.
//

#import "HorizontalPickerAppDelegate.h"
#import "HorizontalPickerViewController.h"

@implementation HorizontalPickerAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
