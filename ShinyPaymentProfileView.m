//
//  ShinyPaymentProfileView.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyPaymentProfileView.h"

@implementation ShinyPaymentProfileView

@synthesize paymentMethodsTable;

- (id)init
{
    self = [super initWithFrame:[self frame]];
    if (self) {
        
        paymentMethodsTable = [[UITableView alloc] initWithFrame:[self frame] 
                                                         style:UITableViewStylePlain];
        [paymentMethodsTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        [paymentMethodsTable setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:paymentMethodsTable];
    }
    return self;
}

-(void)layoutSubviews
{
    [paymentMethodsTable setFrame:[self frame]];
}

@end
