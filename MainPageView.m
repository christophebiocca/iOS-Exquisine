//
//  MainPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainPageView.h"

@implementation MainPageView

// Important note: This is called createOrderButton
// as opposed to newOrderButton because it collides 
// with some dumb shit that xcode does with the 
// getters and setters

@synthesize createOrderButton;
@synthesize favoriteOrderButton;
@synthesize accountInfoButton;
@synthesize greetingLabel;
@synthesize orderStatus;
@synthesize pendingOrderButton;
@synthesize logo;
@synthesize logoView;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        createOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        favoriteOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        pendingOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        accountInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        greetingLabel = [[UILabel alloc] init];
        orderStatus = [[UILabel alloc] init];
        logo = [UIImage imageNamed:@"pfLogo_high"];
        logoView = [[UIImageView alloc] initWithImage:logo];
        
        [createOrderButton setTitle:@"New Order" forState:UIControlStateNormal];
        [favoriteOrderButton setTitle:@"Favorites" forState:UIControlStateNormal];
        [accountInfoButton setTitle:@"Account Information" forState:UIControlStateNormal];
        [pendingOrderButton setTitle: @"Order status: No pending orders" forState:UIControlStateDisabled];
        [pendingOrderButton setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5] forState:UIControlStateDisabled];
        [pendingOrderButton setEnabled:NO];
        
        [createOrderButton addTarget:self action:@selector(createOrderPressed) 
         forControlEvents:UIControlEventTouchUpInside]; 
        
        [createOrderButton setHidden:NO];
        [createOrderButton setEnabled:YES];
        
        [greetingLabel setNumberOfLines:10];
        [greetingLabel setText:\
         @"Welcome to the Pita Factory App. Order below and skip the line."];
        
        [orderStatus setText:@"Order status: No pending orders"];
        
        
        
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
    [createOrderButton setFrame:CGRectMake(20, 253, 280, 37)];
    [favoriteOrderButton setFrame:CGRectMake(20, 298, 280, 37)];
    [accountInfoButton setFrame:CGRectMake(20, 449, 280, 37)];
    [pendingOrderButton setFrame:CGRectMake(20, 343, 280, 37)];
    //[greetingLabel setFrame:CGRectMake(20, 20, 280, 135)];
    [orderStatus setFrame:CGRectMake(20, 263, 280, 37)];
    [logoView setFrame:CGRectMake(75, 40,170, 170)];
}

-(void)createOrderPressed{
     
}

@end
