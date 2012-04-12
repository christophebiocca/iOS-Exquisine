//
//  ShinyOrderSummaryView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderSummaryView.h"

@implementation ShinyOrderSummaryView

@synthesize orderSummaryTable;

- (id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        
        orderSummaryTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                         style:UITableViewStylePlain];
        [orderSummaryTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];

        [orderSummaryTable setBackgroundColor:[Utilities fravicLightPinkColor]];
        [self addSubview:orderSummaryTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderSummaryTable setFrame:[self frame]];
}


@end
