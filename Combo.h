//
//  Combo.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"
@class Order;
@class Menu;

@interface Combo : MenuComponent
{
    
    Order *associatedOrder;
    NSMutableArray *listOfItemGroups;
    NSMutableArray *listOfAssociatedItems;
    NSDecimalNumber *price;
    
}

@property (retain) NSDecimalNumber *price;
@property (retain) NSMutableArray *listOfAssociatedItems;
@property (retain) NSMutableArray *listOfItemGroups;

-(Combo *)initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) associatedMenu;

-(Combo *) initFromComboShallow:(Combo *) aCombo;

-(BOOL) evaluateForCombo:(Order *) anOrder;

-(NSMutableArray *) comboItemsList;

-(void) setAssociatedOrder:(Order *) anOrder;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;

-(BOOL) satisfied;

-(Order *) associatedOrder;

-(BOOL) isEffectivelySameAs:(Combo *) anotherCombo;

-(void) orderAltered;

@end
