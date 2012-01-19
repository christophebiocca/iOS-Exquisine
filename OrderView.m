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
@synthesize orderToolBar;
@synthesize totalLabelValue;
@synthesize totalLabelHeading;
@synthesize doneButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        orderTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        orderToolBar = [[UIToolbar alloc] init];
        
        doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit this order!" style:UIBarButtonItemStyleDone target:self action:sel_registerName("doneButton")];

        [doneButton setWidth:308];
        
        NSArray *toolbarItems = [NSArray arrayWithObjects: doneButton, nil];
        [orderToolBar setItems:toolbarItems animated:NO];
        
        
        [self addSubview:orderTable];
        [self addSubview:orderToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderTable setFrame:CGRectMake(0, 0, 320, 372)];
    [orderToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}

@end
