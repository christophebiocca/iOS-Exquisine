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

- (id)init
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[OrderCell cellIdentifier]];
    if (self) {
        
    }
    return self;
}

-(void)setOrder:(Order *)theOrder
{   
    order = theOrder;
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    UIFont *titleFont = [UIFont fontWithName:@"HelveticaNeue-Medium" size:13];
    UIFont *descFont = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    [[self textLabel] setFont:titleFont];
    [[self detailTextLabel] setFont:descFont];
    
    [[self textLabel] setText:[order name]];
    [[self detailTextLabel] setText:[Utilities FormatToPrice:[order subtotalPrice]]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

@end
