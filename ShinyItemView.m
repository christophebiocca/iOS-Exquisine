//
//  ShinyItemView.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemView.h"

@implementation ShinyItemView

@synthesize itemTable;

-(id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        itemTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                  style:UITableViewStylePlain];
        [itemTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [itemTable setBackgroundColor:[UIColor whiteColor]];
        
        itemBarImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CustomizeTopBar.png"]];
        [itemBarImageView setBackgroundColor:[UIColor clearColor]];
        
        [self addSubview:itemTable];
        [self addSubview:itemBarImageView];
    }
    return self;

}

-(void)layoutSubviews
{
    [itemTable setFrame:CGRectMake(0, 44, 320, [self frame].size.height - 44)];
    
    [itemBarImageView setFrame:CGRectMake(
                                           [self frame].origin.x, 
                                           [self frame].origin.y, 
                                           [self frame].size.width, 
                                           47)];
}

@end
