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
        
        [orderTable setBackgroundColor:[Utilities fravicLightPinkColor]];
        
        orderToolBarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LocationBarImageShadow.png"]];
        
        [self addSubview:orderTable];
        [self addSubview:orderToolBarImage];
    }
    return self;
}

-(void)layoutSubviews
{
    [orderTable setFrame:CGRectMake(0, 44, 320, [self frame].size.height - 44)];
    
    [orderToolBarImage setFrame:CGRectMake(
                                           [self frame].origin.x, 
                                           [self frame].origin.y, 
                                           [self frame].size.width, 
                                           47)];
}

@end
