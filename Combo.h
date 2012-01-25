//
//  Combo.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"

@interface Combo : MenuComponent
{
    
    NSMutableArray *listOfItemGroups;
    NSDecimalNumber* price;
    
}

-(Combo *)initFromData:(NSDictionary *)inputData;

@end
