//
//  CustomTabBarController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBarController.h"
#import "Utilities.h"

@implementation CustomTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *aView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlankTopbar.png"]];
    [aView setFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48)];
    
    UIView *anotherView = [[UIView alloc] init];
    [anotherView setBackgroundColor:[UIColor blackColor]];
    [anotherView setAlpha:0.22];
    [anotherView setFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 48)];
    
    [[self tabBar] addSubview:aView];
    [[self tabBar] addSubview:anotherView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
