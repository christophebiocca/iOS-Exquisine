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

+(NSString *)cellIdentifier{
    return @"OrderCell";
}

-(void)setData:(id)theOrder
{   
    order = theOrder;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:ORDER_MODIFIED object:theOrder];
    
    [super setData:theOrder];
    
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[order subtotalPrice]]];
    
}

-(void)updateCell
{
    [super updateCell];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[order subtotalPrice]]];
    [self setNeedsDisplay];
}

@end
