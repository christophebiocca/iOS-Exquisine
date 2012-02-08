//
//  ComboViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentViewController.h"
@class Combo;
@class Order;
@class ComboView;
@class ComboRenderer;

@interface ComboViewController : MenuComponentViewController<UITableViewDelegate> 
{
    
    Order *orderInfo;
    Combo *comboInfo;
    ComboView *comboView;
    ComboRenderer *comboRenderer;
    UIViewController *returnController;
    
}

@property (retain) Combo *comboInfo;

-(ComboViewController *)initializeWithComboAndOrderAndReturnController:(Combo *) aCombo:(Order *) anOrder:(UIViewController *) aController;

-(void) addThisComboToOrder;

@end
