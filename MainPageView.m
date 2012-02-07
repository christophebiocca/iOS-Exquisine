//
//  MainPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainPageView.h"
#import "IndicatorView.h"

@implementation MainPageView

// Important note: This is called createOrderButton
// as opposed to newOrderButton because it collides 
// with some dumb shit that xcode does with the 
// getters and setters

@synthesize createOrderButton;
@synthesize favoriteOrderButton;
@synthesize accountInfoButton;
@synthesize orderStatus;
@synthesize pendingOrderButton;
@synthesize logo;
@synthesize logoView;
@synthesize openIndicator;
@synthesize storeHours;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        createOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        favoriteOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        pendingOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        accountInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        orderStatus = [[UILabel alloc] init];
        openIndicator = [[IndicatorView alloc] init];
        storeHours = [[UILabel alloc] init];
        
        logo = [UIImage imageNamed:@"pfLogo"];
        logoView = [[UIImageView alloc] initWithImage:logo];
        
        [storeHours setText:@"Store hours:"];
        [storeHours setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        
        [createOrderButton setTitle:@"New Order" forState:UIControlStateNormal];
        [createOrderButton setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5] forState:UIControlStateDisabled];
        [createOrderButton setTitle:@"Fetching Menu..." forState:UIControlStateDisabled];
        
        [favoriteOrderButton setTitle:@"Favorites" forState:UIControlStateNormal];
        
        [accountInfoButton setTitle:@"Account Information" forState:UIControlStateNormal];
        
        [pendingOrderButton setTitle: @"Order status: No pending orders" forState:UIControlStateDisabled];
        [pendingOrderButton setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5] forState:UIControlStateDisabled];
        [pendingOrderButton setEnabled:NO];
        
        [createOrderButton setHidden:NO];
        [createOrderButton setEnabled:YES];
        
        [orderStatus setText:@"Order status: No pending orders"];
        
        
        [self addSubview:storeHours];
        [self addSubview:openIndicator];
        [self addSubview:createOrderButton];
        [self addSubview:favoriteOrderButton];
        [self addSubview:pendingOrderButton];
        //For now, there is no account info button. If we decide to never have it, chuck it.
        //[self addSubview:accountInfoButton];
        //[self addSubview:greetingLabel];
        [self addSubview:logoView];
        //[self addSubview:orderStatus];
    }
    return self;
}

-(void)layoutSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [createOrderButton setFrame:CGRectMake(20, 233, 280, 37)];
    [favoriteOrderButton setFrame:CGRectMake(20, 278, 280, 37)];
    [accountInfoButton setFrame:CGRectMake(20, 449, 280, 37)];
    [pendingOrderButton setFrame:CGRectMake(20, 323, 280, 37)];
    [orderStatus setFrame:CGRectMake(20, 263, 280, 37)];
    [logoView setFrame:CGRectMake(75, 30,170, 170)];
    //[openIndicator setFrame:CGRectMake(38, 224, 16, 16)];
    [storeHours setFrame:CGRectMake(70, 374, 240, 37)];
}

@end
