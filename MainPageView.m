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


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        createOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        favoriteOrderButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        accountInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        greetingLabel = [[UILabel alloc] init];
        orderStatus = [[UILabel alloc] init];
        
        [createOrderButton setTitle:@"New Order" forState:UIControlStateNormal];
        [favoriteOrderButton setTitle:@"Favorites" forState:UIControlStateNormal];
        [accountInfoButton setTitle:@"Account Information" forState:UIControlStateNormal];
        
        [createOrderButton addTarget:self action:@selector(createOrderPressed) 
         forControlEvents:UIControlEventTouchUpInside]; 
        
        [createOrderButton setHidden:NO];
        [createOrderButton setEnabled:YES];
        
        [greetingLabel setNumberOfLines:10];
        [greetingLabel setText:\
         @"Order your pitas ahead of time, and never wait in line again!"];
        
        [orderStatus setText:@"Order status: No pending orders"];
        
        [self addSubview:createOrderButton];
        [self addSubview:favoriteOrderButton];
        //For now, there is no account info button. If we decide to never have it, chuck it.
        //[self addSubview:accountInfoButton];
        [self addSubview:greetingLabel];
        [self addSubview:orderStatus];
    }
    return self;
}

-(void)layoutSubviews
{
    [self setBackgroundColor:[UIColor whiteColor]];
    [createOrderButton setFrame:CGRectMake(20, 163, 280, 37)];
    [favoriteOrderButton setFrame:CGRectMake(20, 208, 280, 37)];
    [accountInfoButton setFrame:CGRectMake(20, 359, 280, 37)];
    [greetingLabel setFrame:CGRectMake(20, 20, 280, 135)];
    [orderStatus setFrame:CGRectMake(20, 253, 280, 37)];
}

-(void)createOrderPressed{
     
}

@end
