//
//  OrderCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderCell.h"
#import "Order.h"
#import "Utilities.h"


@implementation OrderCell

@synthesize order;

+(NSString *)cellIdentifier{
    return @"OrderCell";
}

-(void)setOrder:(Order *)theOrder
{   
    order = theOrder;
    
    [super setMenuComponent:theOrder];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[order subtotalPrice]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
