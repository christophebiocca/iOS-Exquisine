//
//  ComboView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboView.h"

@implementation ComboView

@synthesize comboTable;
@synthesize comboToolBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        comboTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        comboToolBar = [[UIToolbar alloc] init];
        
        [self addSubview:comboTable];
        [self addSubview:comboToolBar];
    }
    return self;
}

-(void)layoutSubviews
{
    [comboTable setFrame:CGRectMake(0, 0, 320, 372)];
    [comboToolBar setFrame:CGRectMake(0, 372, 320, 44)];
}

@end
