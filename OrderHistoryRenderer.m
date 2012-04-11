//
//  OrderHistoryRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderHistoryRenderer.h"
#import "AppData.h"
#import "ShinyHeaderView.h"

@implementation OrderHistoryRenderer

-(id)init
{
    self = [super init];
    
    if(self)
    {
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"List of orders"];
        NSMutableArray *listOfOrdersSection = [[NSMutableArray alloc] init];
        
        [listOfOrdersSection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Prior Orders"]];
        
        for (Order *eachOrder in [[AppData appData] ordersHistory]) {
            [listOfOrdersSection addObject:[NSDictionary dictionaryWithObject:eachOrder forKey:@"historicalOrder"]];
        }
        
        [listData addObject:listOfOrdersSection];
        
    }
    
    return self;
}

@end
