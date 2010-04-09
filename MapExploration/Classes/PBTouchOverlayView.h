//
//  PBTouchOverlayView.h
//  MapExploration
//
//  Created by Itay Neeman on 4/8/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PBTouchOverlayDelegate

- (void)overlayTouched;

@end


@interface PBTouchOverlayView : UIView {
  id<PBTouchOverlayDelegate> m_delegate;
}

@property (nonatomic, retain) id<PBTouchOverlayDelegate> delegate;

@end
