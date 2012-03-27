//
//  OrderSectionFooterView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSectionFooterView.h"

NSString *PLACE_BUTTON_PRESSED = @"PLACE_BUTTON_PRESSED";

@implementation OrderSectionFooterView

@synthesize placeLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        footerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"SubOrderOptionSelectorBar.png"]];
        [self setFrame:[footerImage frame]];
        [self addSubview:footerImage];
        
        placeLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [placeLabel setFrame:CGRectMake(102, 27, 120, 30)];
        [placeLabel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[placeLabel titleLabel] setFont:[UIFont fontWithName:@"AmericanTypewriter" size:20]];
        [[placeLabel titleLabel] setTextColor:[UIColor blackColor]];
        [placeLabel setBackgroundColor:[UIColor clearColor]];
        [placeLabel setTitle:@"Place Order" forState:UIControlStateNormal];
        
        [placeLabel addTarget:self action:@selector(placeButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:placeLabel];
    }
    return self;
}

-(void) placeButtonPressed
{
    [[NSNotificationCenter defaultCenter] postNotificationName:PLACE_BUTTON_PRESSED object:self];
}

@end
