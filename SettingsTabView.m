//
//  SettingsTabView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsTabView.h"

@implementation SettingsTabView

@synthesize settingsTable;

- (id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        
        settingsTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                  style:UITableViewStylePlain];
        [settingsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [settingsTable setBackgroundColor:[UIColor whiteColor]];
        
        [self addSubview:settingsTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [settingsTable setFrame:[self frame]];
}


@end
