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
#import "ItemRenderer.h"
#import "ItemGroup.h"
#import "ItemGroupCell.h"

@implementation ComboRenderer

-(ComboRenderer *)initWithCombo:(Combo *)aCombo
{
    self = [super init];
    
    if(self)
    {
        listData = [NSMutableArray arrayWithObject:[aCombo listOfItemGroups]];
        sectionNames = [NSArray arrayWithObject:[aCombo name]];
    }
    
    return self;
}


@end
