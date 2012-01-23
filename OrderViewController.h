//
//  OrderViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderManagementDelegate;


@class Order;
@class Menu;
@class OrderView;
@class OrderRenderer;

@interface OrderViewController : UITableViewController <UITableViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    Order *orderInfo;
    Menu *menuInfo;
    OrderView *orderView;
    OrderRenderer *orderRenderer;  
    UIBarButtonItem *optionsButton;
    
    id<OrderManagementDelegate> delegate;
    
}

@property (retain) id<OrderManagementDelegate> delegate;

@property (retain) Order *orderInfo;

-(OrderViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder;

-(void) renameOrder:(NSString *) newName;

-(void) displayOptions;

-(void) displayOrderConfirmation;

-(void) displayDeletionConfirmation;

-(void) promptUserForRename;

@end
