//
//  OrderTabView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderTabView.h"
#import "Utilities.h"

@implementation OrderTabView

@synthesize orderTable;

- (id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        
        orderTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                  style:UITableViewStylePlain];
        [orderTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [orderTable setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:orderTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderTable setFrame:[self frame]];
}

@end
