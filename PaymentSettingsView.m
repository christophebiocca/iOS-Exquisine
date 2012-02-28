//
//  PaymentSettingsView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentSettingsView.h"

@implementation PaymentSettingsView

@synthesize creditCardLabel;
@synthesize changeInfoButton;
@synthesize deleteInfoButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        creditCardLabel = [[UILabel alloc] init];
        changeInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        deleteInfoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        [creditCardLabel setText:@"Fetching credit card info.."];
        [creditCardLabel setLineBreakMode:UILineBreakModeWordWrap];
        [creditCardLabel setNumberOfLines:4];
        
        [changeInfoButton setTitle:@"Set credit card info" forState:UIControlStateNormal];
        
        [deleteInfoButton setTitle:@"Forget credit card info" forState:UIControlStateNormal];
        [deleteInfoButton setTitleColor:[UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:0.5] forState:UIControlStateDisabled];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:creditCardLabel];
        [self addSubview:changeInfoButton];
        [self addSubview:deleteInfoButton];
    }
    return self;
}

-(void)layoutSubviews
{
    [creditCardLabel setFrame:CGRectMake(20, 100, 280, 100)];
    [changeInfoButton setFrame:CGRectMake(20, 224, 280, 37)];
    [deleteInfoButton setFrame:CGRectMake(20, 269, 280, 37)];
}

@end
