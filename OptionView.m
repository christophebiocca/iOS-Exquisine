//
//  OptionView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionView.h"

@implementation OptionView

@synthesize optionTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        optionTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        [self addSubview:optionTable];
        
    }
    return self;
}

-(void)layoutSubviews
{
    /*
     CGSize size = [self bounds].size;
     */
    [optionTable setFrame:[self bounds]];
}

@end
