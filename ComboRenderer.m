//
//  ComboRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboRenderer.h"
#import "Order.h"
#import "Combo.h"
#import "CellData.h"

@implementation ComboRenderer

-(ComboRenderer *)initFromCombo:(Combo *)aCombo
{
    self = [super init];
    
    currentCombo = aCombo;
    
    return self;
}


//This puppy needs to return a list of things that respond to configureCell such that the group is representative
//of this combo and all involved items.
-(NSMutableArray *)produceRenderList
{
    NSMutableArray *returnList = [[NSMutableArray alloc] initWithCapacity:0];
    
    CellData *newCell = [[CellData alloc] init];
    newCell.cellTitle = currentCombo.name;
    newCell.cellDesc = [currentCombo.price stringValue];
    
    [returnList addObject:newCell];
    
    [returnList addObjectsFromArray:currentCombo.listOfAssociatedItems];
    
    return returnList;
}

@end
