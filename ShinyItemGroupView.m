//
//  ShinyItemGroupView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemGroupView.h"

@implementation ShinyItemGroupView


@synthesize itemGroupTable;

-(id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        itemGroupTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                  style:UITableViewStylePlain];
        [itemGroupTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [itemGroupTable setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:itemGroupTable];
    }
    return self;
    
}

-(void)layoutSubviews
{
    [itemGroupTable setFrame:[self frame]];
}


@end
