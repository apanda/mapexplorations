//
//  PBHorizontalPicker.m
//  HorizontalPicker
//
//  Created by Itay Neeman on 6/10/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBHorizontalPicker.h"


@implementation PBHorizontalPicker


- (id)initWithFrame:(CGRect)frame labels:(NSArray*)labels 
{
    if (self = [super initWithFrame:frame]) {
        // First, get our size and height
        int viewWidth = frame.size.width;
        int viewHeight = frame.size.height;
        
        m_labels = [labels retain];
        
        self.backgroundColor = [UIColor blackColor];
        self.layer.borderColor = [UIColor grayColor].CGColor;
        self.layer.borderWidth = 1.8;
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = YES;
        //        self.layer.edgeAntialiasingMask = 0;
                        
        // Create the scroll view
        m_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, viewWidth, viewHeight)];        
        m_scrollView.pagingEnabled = NO;
        m_scrollView.showsHorizontalScrollIndicator = NO;
        m_scrollView.showsVerticalScrollIndicator = NO;
        m_scrollView.scrollsToTop = NO;
        m_scrollView.backgroundColor = [UIColor clearColor];
        m_scrollView.decelerationRate = 0.994;
        m_scrollView.delegate = self;    
        [self addSubview:m_scrollView]; 
                
        // Handle labels and add highlights and boundaries as necessary
        // Get the maximum label height we need
        m_labelWidth = 55;
        for(int i = 0; i < [m_labels count]; i++) {
            UILabel* label = [m_labels objectAtIndex:i];
            
            [label sizeToFit];
            m_labelWidth = MAX(m_labelWidth, label.frame.size.width);
        }
        
        // Calculate how much padding we need at the front and back to ensure enough scrolling space
        int contentPadding = (viewWidth / 2) - (kLabelItemSpacing + (m_labelWidth / 2));
        
        // Set all labels to be the same width, and position them correctly in the scroll view
        int currentLocationX = contentPadding + kLabelItemSpacing;
        for(int i = 0; i < [m_labels count]; i++) {
            UILabel* label = [m_labels objectAtIndex:i];
            
            label.frame = CGRectMake(currentLocationX, 0, m_labelWidth, viewHeight);
            currentLocationX += m_labelWidth + kLabelItemSpacing;
            
            label.backgroundColor = [UIColor clearColor];
            label.textColor = [UIColor colorWithRed:236.0/255.0 green:195.0/255.0 blue:28.0/255.0 alpha:1.0];
            label.textAlignment = UITextAlignmentCenter;
            
            // Add it to the scroll view
            [m_scrollView addSubview:label];
        }
        
        // Set the scroll view's content area
        m_scrollView.contentSize = CGSizeMake(currentLocationX + contentPadding, viewHeight);
        
        // Now that we know the widths, create the selection boundaries
        CGRect rightBoundaryFrame = CGRectMake(viewWidth / 2 - m_labelWidth / 2 - kLabelItemSpacing / 2, 0, 1, viewHeight);
        CGRect leftBoundaryFrame = CGRectMake(viewWidth / 2 + m_labelWidth / 2 + kLabelItemSpacing / 2, 0, 1, viewHeight);
        CAGradientLayer* rightBoundary = [self selectionBoundaryLayerWithFrame:rightBoundaryFrame];
        CAGradientLayer* leftBoundary = [self selectionBoundaryLayerWithFrame:leftBoundaryFrame];
        
        [self.layer addSublayer:rightBoundary];
        [self.layer addSublayer:leftBoundary];
        
        // Also, create the shadow layer to exactly "highlight" the selected label
        CAGradientLayer* shadowLayer = [CAGradientLayer layer];
        shadowLayer.frame = CGRectMake(0, 0, viewWidth, viewHeight);
        shadowLayer.startPoint = CGPointMake(0.0, 0);
        shadowLayer.endPoint = CGPointMake(1.0, 0);    
        shadowLayer.colors = [NSArray arrayWithObjects:
                              (id)[[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor,
                              (id)[[UIColor blackColor] colorWithAlphaComponent:0.25].CGColor,
                              (id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor,
                              (id)[[UIColor blackColor] colorWithAlphaComponent:0.0].CGColor,
                              (id)[[UIColor blackColor] colorWithAlphaComponent:0.25].CGColor,
                              (id)[[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor,
                              nil];
        
        float startHighlightFraction = rightBoundaryFrame.origin.x / viewWidth;
        float endHighlightFraction = leftBoundaryFrame.origin.x / viewWidth;
        shadowLayer.locations = [NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:0.0],
                                 [NSNumber numberWithFloat:startHighlightFraction - 0.01],
                                 [NSNumber numberWithFloat:startHighlightFraction],
                                 [NSNumber numberWithFloat:endHighlightFraction],
                                 [NSNumber numberWithFloat:endHighlightFraction + 0.01],
                                 [NSNumber numberWithFloat:1.0],
                                 nil];
        [self.layer addSublayer:shadowLayer];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(context);
    
    // Draw the selector    
    float Ax = self.frame.size.width / 2 - 7, Ay = 0;
    float Bx = self.frame.size.width / 2 + 7, By = 0;
    float Cx = self.frame.size.width / 2, Cy = 8;
    
    CGMutablePathRef trianglePath = CGPathCreateMutable();
    CGPathMoveToPoint(trianglePath, NULL, Ax, Ay);
    CGPathAddLineToPoint(trianglePath, NULL, Bx, By);
    CGPathAddLineToPoint(trianglePath, NULL, Cx, Cy);
    CGPathAddLineToPoint(trianglePath, NULL, Ax, Ay);
    
    CGContextAddPath(context, trianglePath);
    CGContextClosePath(context);
    CGContextClip(context);
        
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat colors[8] = {
        0.333, 0.333, 0.333, 0.3,
        1.000, 1.000, 1.000, 0.7
    };
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, NULL, 2);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(Cx, 0), CGPointMake(Cx, Cy), 0);
    
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
    CGPathRelease(trianglePath);
}

- (void)setLabels:(NSArray*)labels
{
    [m_labels release];
    m_labels = [labels retain];
}

#pragma mark Utility methods

- (CAGradientLayer*)selectionBoundaryLayerWithFrame:(CGRect)frame
{
    CAGradientLayer* layer = [CAGradientLayer layer];
    layer.frame = frame;
    
    layer.colors = [NSArray arrayWithObjects:
                    (id)[[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor,
                    (id)[[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor,
                    (id)[[UIColor blackColor] colorWithAlphaComponent:1.0].CGColor,
                    nil];
    
    layer.locations = [NSArray arrayWithObjects:
                       [NSNumber numberWithFloat:0.2],
                       [NSNumber numberWithFloat:0.5],
                       [NSNumber numberWithFloat:0.8],
                       nil];
    
    return layer;                    
}

- (int)labelIndexToScrollTo:(CGPoint)contentOffset
{
    float numerator = contentOffset.x + (m_labelWidth + kLabelItemSpacing) / 2;
    float denominator = (m_labelWidth + kLabelItemSpacing);
    
    int labelIndexToScrollTo = MIN(MAX(numerator / denominator, 0), [m_labels count] - 1);  
    
    return labelIndexToScrollTo;
}

- (CGPoint)pointToScrollTo:(int)labelIndex
{
    UILabel* labelToScrollTo = [m_labels objectAtIndex:labelIndex];
    CGPoint center = labelToScrollTo.center;
    
    return CGPointMake(center.x - self.frame.size.width / 2, 0);      
}

#pragma mark Scroll View Delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // First, get the label we would scroll to
    int labelIndexToScrollTo = [self labelIndexToScrollTo:scrollView.contentOffset];
    
    m_selectedLabel = [m_labels objectAtIndex:labelIndexToScrollTo];
    
    // Now, we want to find out if it is the same label if we had continued in the
    // same direction of the deceleration for just a little bit more
    CGPoint pointToScrollTo = [self pointToScrollTo:labelIndexToScrollTo];
    
    // UNCOMMENT THIS IF YOU WANT TO SNAP IN DIRECTION OF DECELERATION
    // Did we move left-to-right (positive) or right-to-left (negative)?
    /*if (scrollView.contentOffset.x > startDecelerationPoint.x) {
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
     }*/
    
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
        
        m_selectedLabel = [m_labels objectAtIndex:labelIndexToScrollTo];
        
        // snap us to the right place
        CGRect rectToScrollTo = scrollView.frame;
        rectToScrollTo.origin = pointToScrollTo;
        [scrollView scrollRectToVisible:rectToScrollTo animated:YES];
    }
    else {
        m_startDecelerationPoint = scrollView.contentOffset;
    }
}

- (void)dealloc {
    [m_labels release];
    [m_scrollView release];
    [super dealloc];
}


@end
