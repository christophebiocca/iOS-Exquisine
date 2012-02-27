//
//  SettingsView.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsView.h"

@implementation SettingsView

@synthesize settingsTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        settingsTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self addSubview:settingsTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [settingsTable setFrame:[self bounds]];
}

@end
