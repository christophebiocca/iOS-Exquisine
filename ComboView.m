//
//  ComboView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboView.h"

@implementation ComboView

@synthesize comboTable;
@synthesize comboToolBar;
@synthesize priceButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        comboTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        
        UIBarButtonItem *spacer1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        UIBarButtonItem *spacer2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
        
        priceButton = [[UIBarButtonItem alloc] initWithTitle:@"Combo price:" style:UIBarButtonItemStylePlain target:self action:nil];
        
        comboToolBar = [[UIToolbar alloc] init];
        
        [comboToolBar setItems:[NSArray arrayWithObjects:spacer1, priceButton, spacer2,nil]];
        
        [self addSubview:comboTable];
        [self addSubview:comboToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    [comboTable setFrame:CGRectMake(0, 0, 320, 372)];
    [comboToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}

@end
