//
//  PBInformationView2.m
//  MapExploration
//
//  Created by Itay Neeman on 6/12/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBInformationView2.h"


@implementation PBInformationView2

@synthesize currentAnnotation = m_currentAnnotation;

#pragma mark Creation Functions

- (void)createInfoLabelsWithParentView:(UIView*)parentView
{
    m_nameLabel = [[TTLabel alloc] initWithFrame:CGRectMake(10, 8, 250, 37)];
    m_addressLabel = [[TTLabel alloc] initWithFrame:CGRectMake(10, 43, 160, 16)];
    m_cityLabel = [[TTLabel alloc] initWithFrame:CGRectMake(10, 57, 160, 16)];
    
    m_nameLabel.text = @"Cowen Park";
    m_addressLabel.text = @"5849 15th Ave. NE";
    m_cityLabel.text = @"Seattle, WA";
    
    m_nameLabel.backgroundColor = [UIColor clearColor];       
    CGSize tightSize = [m_nameLabel.text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(250, 35)];
    m_nameLabel.size = CGSizeMake(250, tightSize.height);
    m_nameLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:17] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:17 
                                       shadowColor:[UIColor clearColor] 
                                      shadowOffset:CGSizeMake(0, 0) 
                                     textAlignment:UITextAlignmentLeft 
                                 verticalAlignment:UIControlContentVerticalAlignmentTop 
                                     lineBreakMode:UILineBreakModeTailTruncation 
                                     numberOfLines:1 
                                              next:nil];
    
    m_addressLabel.backgroundColor = [UIColor clearColor];       
    m_addressLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:12] 
                                                color:[UIColor whiteColor] 
                                      minimumFontSize:12 
                                          shadowColor:[UIColor clearColor] 
                                         shadowOffset:CGSizeMake(0, 0) 
                                        textAlignment:UITextAlignmentLeft 
                                    verticalAlignment:UIControlContentVerticalAlignmentTop 
                                        lineBreakMode:UILineBreakModeTailTruncation 
                                        numberOfLines:1 
                                                 next:nil];
    
    m_cityLabel.backgroundColor = [UIColor clearColor];       
    m_cityLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:12] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:12 
                                       shadowColor:[UIColor clearColor] 
                                      shadowOffset:CGSizeMake(0, 0) 
                                     textAlignment:UITextAlignmentLeft 
                                 verticalAlignment:UIControlContentVerticalAlignmentTop 
                                     lineBreakMode:UILineBreakModeTailTruncation 
                                     numberOfLines:1 
                                              next:nil];
    
    [parentView addSubview:m_nameLabel];
    [parentView addSubview:m_addressLabel];
    [parentView addSubview:m_cityLabel];
}

- (void)createLightsInfoWithParentView:(UIView*)parentView
{    
    m_lightView = [[TTView alloc] initWithFrame:CGRectMake(180, 45, 55, 50)];
    m_lightView.backgroundColor = [UIColor clearColor];
    m_lightView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:10 topRight:0 bottomRight:0 bottomLeft:10] next:
                         [TTLinearGradientFillStyle styleWithColor1:[UIColor darkGrayColor] color2:[UIColor clearColor] next:nil]];
    
    m_lightOnImage = [[UIImage imageNamed:@"light_on.png"] retain];
    m_lightOffImage = [[UIImage imageNamed:@"light_off.png"] retain];
    m_lightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                                     CGRectGetMidX(m_lightView.bounds) - m_lightOnImage.size.width / 2.0, 
                                                                     8, 
                                                                     m_lightOnImage.size.width, 
                                                                     m_lightOnImage.size.height)];
    m_lightImageView.image = m_lightOnImage;
    [m_lightView addSubview:m_lightImageView];
    
    m_lightInfoLabel = [[TTLabel alloc] initWithFrame:CGRectMake(0, 35, 55, 18)];
    m_lightInfoLabel.text = @"Lights";
    m_lightInfoLabel.backgroundColor = [UIColor clearColor];       
    m_lightInfoLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:10] 
                                                  color:[UIColor whiteColor] 
                                        minimumFontSize:10 
                                            shadowColor:[UIColor clearColor] 
                                           shadowOffset:CGSizeMake(0, 0) 
                                          textAlignment:UITextAlignmentCenter
                                      verticalAlignment:UIControlContentVerticalAlignmentTop 
                                          lineBreakMode:UILineBreakModeTailTruncation 
                                          numberOfLines:1 
                                                   next:nil];
    [m_lightView addSubview:m_lightInfoLabel];
    
    
    [parentView addSubview:m_lightView];
}

- (void)createCourtsInfoWithParentView:(UIView*)parentView
{    
    m_courtsView = [[TTView alloc] initWithFrame:CGRectMake(236, 45, 55, 50)];
    m_courtsView.backgroundColor = [UIColor clearColor];
    m_courtsView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:0 topRight:10 bottomRight:10 bottomLeft:0] next:
                          [TTLinearGradientFillStyle styleWithColor1:[UIColor darkGrayColor] color2:[UIColor clearColor] next:nil]];
    
    m_courtsImage = [[UIImage imageNamed:@"tennis_on.png"] retain];
    m_courtsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(m_courtsView.bounds) - m_courtsImage.size.width / 2.0, 8, m_courtsImage.size.width, m_courtsImage.size.height)];
    m_courtsImageView.image = m_courtsImage;
    [m_courtsView addSubview:m_courtsImageView];
    
    m_courtsInfoLabel = [[TTLabel alloc] initWithFrame:CGRectMake(0, 35, 55, 18)];
    m_courtsInfoLabel.text = @"3 Courts";
    m_courtsInfoLabel.backgroundColor = [UIColor clearColor];       
    m_courtsInfoLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Helvetica" size:10] 
                                                   color:[UIColor whiteColor] 
                                         minimumFontSize:10 
                                             shadowColor:[UIColor clearColor] 
                                            shadowOffset:CGSizeMake(0, 0) 
                                           textAlignment:UITextAlignmentCenter
                                       verticalAlignment:UIControlContentVerticalAlignmentTop 
                                           lineBreakMode:UILineBreakModeTailTruncation 
                                           numberOfLines:1 
                                                    next:nil];
    
    [m_courtsView addSubview:m_courtsInfoLabel];
    
    [parentView addSubview:m_courtsView];
}

- (void)createDirectionsButtonWithParentView:(UIView*)parentView
{
    UIImage* directionImage = [UIImage imageNamed:@"arrow.png"];
    
    UIButton* directionButton = [[[UIButton alloc] initWithFrame:CGRectZero] autorelease];
    directionButton.size = directionImage.size;
    directionButton.center = CGPointMake(266 + directionImage.size.width / 2, m_nameLabel.center.y + 2);
    [directionButton setImage:directionImage forState:UIControlStateNormal];
    
    [directionButton addTarget:self action:@selector(directionsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [parentView addSubview:directionButton];
}

- (void)createRatingsInfoWithParentView:(UIView*)parentView
{
    m_ratingView = [[SCRatingView alloc] initWithFrame:CGRectMake(8, CGRectGetMaxY(m_lightView.frame) - 19, 95, 19)];
    UIImage* selectedStar = [UIImage imageNamed:@"star_on.png"];
    UIImage* nonselectedStar = [UIImage imageNamed:@"star_off.png"];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewSelected];
    [m_ratingView setStarImage:nonselectedStar forState:kSCRatingViewNonSelected];
    
    m_ratingView.rating = 3;
    
    m_ratingView.userInteractionEnabled = NO;
    
    [parentView addSubview:m_ratingView];
}

#pragma UIViewController methods

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView 
{    
    self.view = [[[TTView alloc] initWithFrame:CGRectMake(0, 0, 320, 130)] autorelease];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    
    TTView* containerView = [[[TTView alloc] initWithFrame:CGRectMake(10, 10, 300, 110)] autorelease];
    containerView.backgroundColor = [UIColor clearColor];
    containerView.style = [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:10.0 topRight:10.0 bottomRight:10.0 bottomLeft:10.0] next:
                           [TTLinearGradientFillStyle styleWithColor1:[UIColor darkGrayColor] color2:[UIColor blackColor] next:nil]];
    
    
    [self createInfoLabelsWithParentView:containerView];
    [self createDirectionsButtonWithParentView:containerView];
    [self createLightsInfoWithParentView:containerView];
    [self createCourtsInfoWithParentView:containerView];
    [self createRatingsInfoWithParentView:containerView];       
    
    [self.view addSubview:containerView];
}

- (void)viewWillAppear:(BOOL)animated
{
    m_nameLabel.text = m_currentAnnotation.name;
    m_addressLabel.text = m_currentAnnotation.address;
    m_cityLabel.text = [NSString stringWithFormat:@"%@, WA", m_currentAnnotation.city];
    
    m_ratingView.rating = m_currentAnnotation.rating;
    
    // Handle has lights/doesn't have lights
    if (false) { 
        // has lights
        m_lightImageView.image = m_lightOnImage;
        m_lightInfoLabel.text = @"Lights";
    }
    else {
        // doesn't have lights
        m_lightImageView.image = m_lightOffImage;
        m_lightInfoLabel.text = @"No Lights";
    }
    
    m_courtsInfoLabel.text = [NSString stringWithFormat:@"%d Courts", m_currentAnnotation.numCourts];
}

#pragma mark Callacks

- (IBAction)directionsButtonPressed:(id)sender
{
    UIApplication *app = [UIApplication sharedApplication];
    
    NSString *address;
    
    address = [NSString stringWithFormat:@"%@ %@ %@, WA", 
               m_currentAnnotation.address, 
               m_currentAnnotation.neighborhood,
               m_currentAnnotation.city];
    
    NSString* encodedAddress = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                   (CFStringRef)address,
                                                                                   NULL,
                                                                                   (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                   kCFStringEncodingUTF8);
    
    NSString* urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", 
                           encodedAddress];
    
    [app openURL:[NSURL URLWithString: urlString]];
}

#pragma mark Deallocaiton Methods

- (void)viewDidUnload {
    [m_nameLabel release];
    [m_addressLabel release];
    [m_cityLabel release];
    [m_ratingView release];
    [m_courtsView release];
    [m_courtsImage release];
    [m_courtsImageView release];
    [m_courtsInfoLabel release];
    [m_lightView release];
    [m_lightOnImage release];
    [m_lightOffImage release];
    [m_lightImageView release];
    [m_lightInfoLabel release];
    [m_currentAnnotation release];
}

- (void)dealloc {
    [m_currentAnnotation release];
    [super dealloc];
}


@end
