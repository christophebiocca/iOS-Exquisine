//
//  OrderView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderView.h"

@implementation OrderView

@synthesize orderTable;
@synthesize priceDisplayButton;
@synthesize editButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        orderTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        orderToolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:nil action:nil];
        leftSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        priceDisplayButton = [[UIBarButtonItem alloc] initWithTitle:@"$12.15" style:UIBarButtonItemStylePlain target:nil action:nil];
        
        rightSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        favoriteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Favorite Star.png"] style:UIBarButtonItemStylePlain target:nil action:nil];
        
        [orderToolbar setItems:[NSArray arrayWithObjects:editButton, leftSpacer, priceDisplayButton, rightSpacer, favoriteButton,nil]];
        
        [self addSubview:orderToolbar];
        [self addSubview:orderTable];
        
        
    }
    return self;
}

-(void)layoutSubviews
{
    [orderTable setFrame:CGRectMake(0, 0, 320, 372)];
    [orderToolbar setFrame:CGRectMake(0, 372, 320, 44)];
}

@end
