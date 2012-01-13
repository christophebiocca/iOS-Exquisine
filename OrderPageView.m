//
//  OrderPageView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderPageView.h"

@implementation OrderPageView

@synthesize orderTable;
@synthesize orderToolBar;
@synthesize totalLabelValue;
@synthesize totalLabelHeading;
@synthesize spacerButton;
@synthesize doneButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        orderTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        orderToolBar = [[UIToolbar alloc] init];
        
        spacerButton = [[UIBarButtonItem alloc] init];
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Send this order!" style:UIBarButtonItemStyleDone target:self action:sel_registerName("doneButton")];
        
        [spacerButton setWidth:171];
        [doneButton setWidth:120];
        
        NSArray *toolbarItems = [NSArray arrayWithObjects: spacerButton, doneButton, nil];
        [orderToolBar setItems:toolbarItems animated:NO];
        
        
        [self addSubview:orderTable];
        [self addSubview:orderToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    /*
    CGSize size = [self bounds].size;
     */
    [orderTable setFrame:CGRectMake(0, 0, 320, 372)];
    [orderToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}

@end
