//
//  HorizontalPickerAppDelegate.h
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/8/10.
//  Copyright Mighty Panda 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HorizontalPickerViewController;

@interface HorizontalPickerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HorizontalPickerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HorizontalPickerViewController *viewController;

@end

