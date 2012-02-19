//
//  ItemRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemRenderer.h"
#import "Item.h"
#import "Option.h"
#import "ChoiceCell.h"
#import "Utilities.h"
#import "GeneralPurposeViewCell.h"
#import "GeneralPurposeViewCellData.h"

@implementation ItemRenderer

-(ItemRenderer *)initWithItem:(Item *)anItem
{
    self = [super init];
    
    listData = [[NSMutableArray alloc] init];
    sectionNames = [[NSMutableArray alloc] init];
    
    if (![[anItem desc] isEqualToString:@""]) {
        
        [sectionNames addObject:@"Description"];
        
        GeneralPurposeViewCellData *data = [[GeneralPurposeViewCellData alloc] init];
        [data setTitle:[anItem desc]];
        [listData addObject:[NSArray arrayWithObject:data]];
    }
    
    for (Option *anOption in [anItem options]) 
    {
        [sectionNames addObject:[anOption name]];
        [listData addObject:[anOption choiceList]];
    }
    
    return self;
}






@end
