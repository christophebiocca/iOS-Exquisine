//
//  FavoritesRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavoritesRenderer.h"
#import "Order.h"
#import "GeneralPurposeViewCellData.h"
#import "OrderRenderer.h"
#import "Utilities.h"
#import "OrderCell.h"

@implementation FavoritesRenderer

-(FavoritesRenderer *)initWithOrderList:(NSMutableArray *)anOrderList
{
    favoriteOrders = anOrderList;
    listData = [NSArray arrayWithObject:anOrderList];
    
    sectionNames = [NSArray arrayWithObject:@"Favorites"]; 
    
    if ([anOrderList count] > 0) 
        listData = [NSArray arrayWithObject:anOrderList];
    else
    {
        GeneralPurposeViewCellData *data = [[GeneralPurposeViewCellData alloc] init];
        [data setTitle:@"You have not saved any favorites"];
        [data setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Medium" size:13]];
        listData = [NSArray arrayWithObject:data];
    }
    
    return self;
}

@end
