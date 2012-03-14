//
//  ShinyOrderTabRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderTabRenderer.h"
#import "ItemGroup.h"
#import "Order.h"
#import "Combo.h"

@implementation ShinyOrderTabRenderer

-(id)initWithOrder:(Order *)anOrder
{
    self = [super init];
    
    if(self)
    {
        
        theOrder = anOrder;
        int index = 0;
        
        [sectionNames addObject:@"Order"];
        NSMutableArray *sectionContents = [[NSMutableArray alloc] initWithCapacity:0];
        
        for (Combo *eachCombo in [theOrder comboList]) {
            NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
            
            [newDictionary setObject:eachCombo forKey:@"combo"];
            [newDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [sectionContents addObject:newDictionary];
            index++;
            
            for (ItemGroup *eachItemGroup in [eachCombo listOfItemGroups]) {
                NSMutableDictionary *anotherDictionary = [[NSMutableDictionary alloc] init];
                Item *anItem = [eachItemGroup satisfyingItem];
                [anotherDictionary setObject:anItem forKey:@"orderComboItem"];
                [anotherDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
                [anotherDictionary setObject:@"orderCombo" forKey:@"context"];
                [sectionContents addObject:anotherDictionary];
                index++;
            }
            
        }
        
        for (Item *anItem in [anOrder itemList]) {
            NSMutableDictionary *anotherDictionary = [[NSMutableDictionary alloc] init];
            [anotherDictionary setObject:anItem forKey:@"orderItem"];
            [anotherDictionary setObject:[NSNumber numberWithInt:index] forKey:@"index"];
            [anotherDictionary setObject:@"order" forKey:@"context"];
            [sectionContents addObject:anotherDictionary];
            index++;
        }
        
        [listData addObject:sectionContents];
        
    }
    
    return self;
}

@end
