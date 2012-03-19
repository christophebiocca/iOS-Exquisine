//
//  ShinyItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemRenderer.h"
#import "ItemSectionHeaderView.h"
#import "Option.h"
#import "Item.h"

@implementation ShinyItemRenderer

-(id)initWithItem:(Item *)anItem
{
    self = [super init];
    
    if(self)
    {
        
        theItem = anItem;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Items"];
        NSMutableArray *menuSectionContents = [[NSMutableArray alloc] init];
        
        [menuSectionContents addObject:[ItemSectionHeaderView new]];
        
        //Starts with all of the options in the open position.
        for (Option *eachOption in [theItem options]) {
            NSMutableDictionary *newDictionary = [[NSMutableDictionary alloc] init];
            [newDictionary setObject:eachOption forKey:@"openOption"];
            [menuSectionContents addObject:newDictionary];
            for (Choice *eachChoice in [eachOption choiceList])
            {
                newDictionary = [[NSMutableDictionary alloc] init];
                [newDictionary setObject:eachChoice forKey:@"choice"];
                [menuSectionContents addObject:newDictionary];
            }
        }
        
        [listData addObject:menuSectionContents];
    }
    
    return self;
}

@end
