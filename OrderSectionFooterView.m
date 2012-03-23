//
//  OrderSectionFooterView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSectionFooterView.h"

NSString *EDIT_BUTTON_PRESSED = @"EDIT_BUTTON_PRESSED";
NSString *PLACE_BUTTON_PRESSED = @"PLACE_BUTTON_PRESSED";

@implementation OrderSectionFooterView

@synthesize placeLabel;
@synthesize editLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        footerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SubOrderOptionSelectorBar.png"]];
        [self setFrame:[footerImage frame]];
        [self addSubview:footerImage];
        
        placeLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        editLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [placeLabel setFrame:CGRectMake(96, 27, 60, 30)];
        [placeLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[placeLabel titleLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:20]];
        [[placeLabel titleLabel] setTextColor:[UIColor blackColor]];
        [placeLabel setBackgroundColor:[UIColor clearColor]];
        [placeLabel setTitle:@"Place" forState:UIControlStateNormal];
        
        [editLabel setFrame:CGRectMake(164, 27, 60, 30)];
        [editLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[editLabel titleLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:20]];
        [[editLabel titleLabel] setTextColor:[UIColor blackColor]];
        [editLabel setBackgroundColor:[UIColor clearColor]];
        [editLabel setTitle:@"Edit" forState:UIControlStateNormal];
        
        [editLabel addTarget:self action:@selector(editButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [placeLabel addTarget:self action:@selector(placeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:editLabel];
        [self addSubview:placeLabel];
    }
    return self;
}

-(void) editButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:EDIT_BUTTON_PRESSED object:self];
}

-(void) placeButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PLACE_BUTTON_PRESSED object:self];
}

@end
