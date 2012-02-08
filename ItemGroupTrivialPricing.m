//
//  ItemGroupTrivialPricing.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemGroupTrivialPricing.h"
#import "Item.h"

@implementation ItemGroupTrivialPricing

-(id)initWithData:(NSDictionary*)data{
    return [super init];
}

-(NSDecimalNumber*)priceForItem:(Item*)item{
    return [item price];
}

@end
