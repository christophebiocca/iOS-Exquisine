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
@synthesize totalLabelValue;
@synthesize totalLabelHeading;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        orderTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [self addSubview:orderTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderTable setFrame:CGRectMake(0, 0, 320, 416)];
}

@end
