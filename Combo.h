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
@class Item;
@protocol ComboPricingStrategy;

extern NSString* COMBO_MODIFIED;


@interface Combo : MenuComponent
{
    
    id<ComboPricingStrategy> strategy;
    NSMutableArray *listOfItemGroups;
    
}

@property (retain) NSMutableArray *listOfItemGroups;

//Initializers
- (Combo *)initFromDataAndMenu:(NSDictionary *)inputData:(Menu *) associatedMenu;

- (MenuComponent *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

- (Combo *)copy;

//Access Methods

//This returns an array of arrays of Items within anOrder that satisfy each itemGroup.
- (NSArray *)satisfactionListsForItemList:(NSArray *)anItemList;

- (NSArray *)listOfAssociatedItems;

- (NSDecimalNumber *) price;

- (BOOL)satisfiedWithItemList:(NSArray *)anItemList;

- (BOOL)containsItem:(Item *) anItem;

- (BOOL)containsExactItem:(Item *) anItem;

- (BOOL)satisfied;

// the savings magnitude is the difference between the price
// someone would pay if the combo didn't exist, vs if it did.
- (NSDecimalNumber *) savingsMagnitude;

//Mutation Methods

- (void) addItem:(Item *)anItem;

- (void) removeItem:(Item *)anItem;

- (void) removeAllItems;

//Housekeeping Methods

- (void) recalculate:(NSNotification *) aNotification;

//Comparitor and Descriptor Methods

- (BOOL) isEffectivelyEqual:(id) anotherCombo;

- (NSComparisonResult)savingsSort:(Combo *) aCombo;

- (NSString *) descriptionWithIndent:(NSInteger) indentLevel;



@end
