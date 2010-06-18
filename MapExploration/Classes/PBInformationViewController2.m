//
//  PBInformationView2.m
//  MapExploration
//
//  Created by Itay Neeman on 6/12/10.
//  Copyright 2010 Mighty Panda. All rights reserved.
//

#import "PBInformationViewController2.h"


@implementation PBInformationViewController2

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
    CGSize tightSize = [m_nameLabel.text sizeWithFont:[UIFont fontWithName:@"Verdana" size:17] constrainedToSize:CGSizeMake(250, 35)];
    m_nameLabel.size = CGSizeMake(250, tightSize.height);
    m_nameLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:17] 
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
    m_addressLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] 
                                                color:[UIColor whiteColor] 
                                      minimumFontSize:11 
                                          shadowColor:[UIColor clearColor] 
                                         shadowOffset:CGSizeMake(0, 0) 
                                        textAlignment:UITextAlignmentLeft 
                                    verticalAlignment:UIControlContentVerticalAlignmentTop 
                                        lineBreakMode:UILineBreakModeTailTruncation 
                                        numberOfLines:1 
                                                 next:nil];
    
    m_cityLabel.backgroundColor = [UIColor clearColor];       
    m_cityLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:11] 
                                             color:[UIColor whiteColor] 
                                   minimumFontSize:11 
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
                         [TTLinearGradientFillStyle styleWithColor1:RGBACOLOR(60, 60, 60, 0.8) color2:RGBACOLOR(60, 60, 60, 0.1) next:nil]];
    
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
    m_lightInfoLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:10] 
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
                          [TTLinearGradientFillStyle styleWithColor1:RGBACOLOR(60, 60, 60, 0.8) color2:RGBACOLOR(60, 60, 60, 0.1) next:nil]];
    
    m_courtsImage = [[UIImage imageNamed:@"tennis_on.png"] retain];
    m_courtsImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(m_courtsView.bounds) - m_courtsImage.size.width / 2.0, 8, m_courtsImage.size.width, m_courtsImage.size.height)];
    m_courtsImageView.image = m_courtsImage;
    [m_courtsView addSubview:m_courtsImageView];
    
    m_courtsInfoLabel = [[TTLabel alloc] initWithFrame:CGRectMake(0, 35, 55, 18)];
    m_courtsInfoLabel.text = @"3 Courts";
    m_courtsInfoLabel.backgroundColor = [UIColor clearColor];       
    m_courtsInfoLabel.style = [TTTextStyle styleWithFont:[UIFont fontWithName:@"Verdana" size:10] 
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
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewUserSelected];
    [m_ratingView setStarImage:selectedStar forState:kSCRatingViewHot];
    
    [m_ratingView setDelegate:self];
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
    
    UIImage* meshImage = [UIImage imageNamed:@"mesh.png"];
    UIColor* meshColor = [[UIColor colorWithPatternImage:meshImage] colorWithAlphaComponent:0.8];
    
    PBRoundedRectView* parentView = [[[PBRoundedRectView alloc] initWithFrame:CGRectMake(10, 10, 300, 110)] autorelease];
    parentView.rectColor = [UIColor colorWithRed:0.1294 green:0.1294 blue:0.1294 alpha:1.0];
    
    PBRoundedRectView* meshBackgroundView = [[[PBRoundedRectView alloc] initWithFrame:CGRectMake(0, 0, parentView.size.width, parentView.size.height)] autorelease];
    meshBackgroundView.rectColor = meshColor;
    meshBackgroundView.strokeWidth = 0.0;
    
    [parentView addSubview:meshBackgroundView];
    
    CAGradientLayer* gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, meshBackgroundView.size.width, meshBackgroundView.size.height);
    gradient.startPoint = CGPointMake(0.0, 0.0);
    gradient.endPoint = CGPointMake(0.0, 1.0);
    gradient.colors = [NSArray arrayWithObjects:
                       (id)[UIColor clearColor].CGColor,
                       (id)[[UIColor blackColor] colorWithAlphaComponent:0.8].CGColor,
                       nil];
    gradient.locations = [NSArray arrayWithObjects:
                          [NSNumber numberWithFloat:0.0],
                          [NSNumber numberWithFloat:1.0],
                          nil];
    gradient.cornerRadius = 10;
    gradient.borderColor = [UIColor colorWithRed:0.1647 green:0.1647 blue:0.1647 alpha:1.0].CGColor;
    gradient.borderWidth = 1.5;
    
    
    [meshBackgroundView.layer addSublayer:gradient];   
    
    [self createInfoLabelsWithParentView:parentView];
    [self createDirectionsButtonWithParentView:parentView];
    [self createLightsInfoWithParentView:parentView];
    [self createCourtsInfoWithParentView:parentView];
    [self createRatingsInfoWithParentView:parentView];       
    
    [self.view addSubview:parentView];
}

- (void)viewWillAppear:(BOOL)animated
{
    m_nameLabel.text = m_currentAnnotation.name;
    m_addressLabel.text = m_currentAnnotation.address;
    m_cityLabel.text = [NSString stringWithFormat:@"%@, WA", m_currentAnnotation.city];
    
    m_ratingView.rating = m_currentAnnotation.rating;
    
    // Handle has lights/doesn't have lights
    if (m_currentAnnotation.lights) { 
        // has lights
        m_lightImageView.image = m_lightOnImage;
        m_lightInfoLabel.text = @"Lights";
        TTTextStyle* textStyle = (TTTextStyle*)m_lightInfoLabel.style;
        textStyle.color = [UIColor whiteColor];
    }
    else {
        // doesn't have lights
        m_lightImageView.image = m_lightOffImage;
        m_lightInfoLabel.text = @"No Lights";
        TTTextStyle* textStyle = (TTTextStyle*)m_lightInfoLabel.style;
        textStyle.color = [UIColor grayColor];
    }
    
    NSString* formatString = m_currentAnnotation.numCourts == 1 ? @"%d Court" : @"%d Courts";
    m_courtsInfoLabel.text = [NSString stringWithFormat:formatString, m_currentAnnotation.numCourts];
}

#pragma mark Callbacks

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

- (void)ratingView:(SCRatingView *)ratingView didChangeUserRatingFrom:(NSInteger)previousUserRating to:(NSInteger)userRating
{
    MapExplorationAppDelegate *delegate = (MapExplorationAppDelegate*)[UIApplication sharedApplication].delegate;
    self.currentAnnotation.rating = userRating;
    [delegate updateRatingForAnnotation:self.currentAnnotation];
}

- (void)ratingView:(SCRatingView *)ratingView didChangeRatingFrom:(CGFloat)previousRating to:(CGFloat)rating
{
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
