//
//  ShinyComboItemView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboItemView.h"

@implementation ShinyComboItemView


@synthesize itemTable;

-(id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        itemTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                 style:UITableViewStylePlain];
        [itemTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [itemTable setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:itemTable];
    }
    return self;
    
}

-(void)layoutSubviews
{
    [itemTable setFrame:[self frame]];
}

@end
