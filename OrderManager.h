//
//  OrderManager.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//Order managers hold onto a menu-order pair and make sure that they
//stay in a good state relative to one another. i.e. if one changes,
//it will make sure that the other changes accordingly.

//(e.g. if someone removes an item from an order, it may no longer
//have combos associated with it)

extern NSString* ORDER_MANAGER_NEEDS_REDRAW;

#import <Foundation/Foundation.h>
@class Order;
@class Menu;

@interface OrderManager : NSObject
{
    Order *thisOrder;
    Menu *thisMenu;
}

@property (readonly) Order *thisOrder;
@property (readonly) Menu *thisMenu;

//Initializers
-(OrderManager *)init;

- (OrderManager *)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;

-(OrderManager *)copy;

//Mutation Methods
-(void) setMenu:(Menu *)inputMenu;

-(void) setOrder:(Order *)inputOrder;

//Housekeeping Methods
-(void) recalculate:(NSNotification *) aNotification;

-(void) redrawNotify:(NSNotification *) aNotification;

//Comparitor and Descriptor Methods
-(BOOL) isEffectivelyEqual:(id) anOrderManager;

-(NSString *) descriptionWithIndent:(NSInteger) indentLevel;
@end
