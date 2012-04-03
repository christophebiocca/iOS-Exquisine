//
//  ShinyComboView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboView.h"

@implementation ShinyComboView

@synthesize comboTable;

-(id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        comboTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                 style:UITableViewStylePlain];
        [comboTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [comboTable setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:comboTable];
    }
    return self;
    
}

-(void)layoutSubviews
{
    [comboTable setFrame:[self frame]];
}

@end
