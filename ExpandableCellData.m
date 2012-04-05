//
//  ExpandableCellData.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ExpandableCellData.h"
#import "Option.h"
#import "Combo.h"
#import "Item.h"
#import "Menu.h"
#import "ListRenderer.h"

@implementation ExpandableCellData

@synthesize primaryItem;
@synthesize isOpen;
@synthesize expansionContents;
@synthesize renderer;

-(id)initWithPrimaryItem:(id)aThing AndRenderer:(ListRenderer *)aRenderer
{
    self = [super init];
    
    if (self)
    {
        renderer = aRenderer;
        expansionContents = [[NSMutableArray alloc] init];
        primaryItem = aThing;
        //We'll set up the expansion contents if we know how.
        if ([primaryItem isKindOfClass:[Menu class]]) {
            if ([expansionContents count] == 0) {
                for (id eachItem in [primaryItem submenuList])
                {
                    if ([eachItem isKindOfClass:[Item class]]) {
                        NSMutableDictionary *newDictionary;
                        newDictionary = [[NSMutableDictionary alloc] init];
                        [newDictionary setObject:eachItem forKey:@"menuItem"];
                        [expansionContents addObject:newDictionary];
                    }
                    
                } 
                for (Combo *eachCombo in [primaryItem comboList]) {
                    NSMutableDictionary *newDictionary;
                    newDictionary = [[NSMutableDictionary alloc] init];
                    [newDictionary setObject:eachCombo forKey:@"menuCombo"];
                    [expansionContents addObject:newDictionary];
                }
            }
        }
        
        if ([primaryItem isKindOfClass:[Option class]]) {
            if ([expansionContents count] == 0) {
                for (Choice *eachChoice in [primaryItem choiceList])
                {
                    NSMutableDictionary *newDictionary;
                    newDictionary = [[NSMutableDictionary alloc] init];
                    [newDictionary setObject:eachChoice forKey:@"choice"];
                    [expansionContents addObject:newDictionary];
                }
            }
        }
        isOpen = NO;    }
    
    return self;
}

@end
