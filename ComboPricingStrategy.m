//
//  ComboPricingStrategy.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboPricingStrategy.h"
#import "ComboTrivialPricingStrategy.h"

@implementation ComboPricingStrategy

//See [self initialize]
static NSDictionary* comboClassDictionary = nil;

+(void)initialize{
    if(!comboClassDictionary){
        comboClassDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                [ComboTrivialPricingStrategy class], @"Trivial",
                                nil];
    }
}

+(id<ComboPricingStrategy>)pricingStrategyFromData:(NSDictionary*)data{
    return [(id<ComboPricingStrategy>)[[comboClassDictionary 
                                        objectForKey:[data objectForKey:@"name"]] alloc] 
            initWithData:data];
}

@end
