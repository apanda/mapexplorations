//
//  HorizontalPickerViewController.h
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/8/10.
//  Copyright Mighty Panda 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HorizontalPickerViewController : UIViewController <UIScrollViewDelegate> {
    UIScrollView* m_scrollView;
    NSArray* m_labels;
}

@end

