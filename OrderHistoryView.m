//
//  OrderHistoryView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderHistoryView.h"

@implementation OrderHistoryView

@synthesize orderHistoryTable;

- (id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        
        orderHistoryTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                     style:UITableViewStylePlain];
        [orderHistoryTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [orderHistoryTable setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:orderHistoryTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderHistoryTable setFrame:[self frame]];
}

@end
