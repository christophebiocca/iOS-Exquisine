//
//  OrderViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;
@class Menu;
@class OrderView;
@class OrderRenderer;

@interface OrderViewController : UITableViewController <UITableViewDelegate, UIActionSheetDelegate>
{
    
    Order *orderInfo;
    Menu *menuInfo;
    OrderView *orderView;
    OrderRenderer *orderRenderer;  
    UIBarButtonItem *optionsButton;
    
}

@property (retain) Order *orderInfo;

-(OrderViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder;

-(void) renameOrder:(NSString *) newName;

-(void) displayOptions;

-(void) displayOrderConfirmation;
 
-(void) submitOrder;

-(void) promptUserForRename;

-(void) addOrderToFavorites;

@end
