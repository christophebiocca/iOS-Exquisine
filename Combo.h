//
//  Combo.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"
@class Order;

@interface Combo : MenuComponent
{
    
    NSMutableArray *listOfItemGroups;
    NSDecimalNumber *price;
    
}

@property (retain) NSDecimalNumber *price;

-(Combo *)initFromData:(NSDictionary *)inputData;

-(BOOL) doesContainCombo:(Order *) anOrder;

-(NSMutableArray *) comboItemsList:(Order *) anOrder;

@end
