//
//  FavoritesView.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesView.h"

@implementation FavoritesView

@synthesize orderTable;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        orderTable = [[UITableView alloc] init];
        [self addSubview:orderTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderTable setFrame:[self bounds]];
}

@end
