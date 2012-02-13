//
//  OrderSummaryViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderManagementDelegate;

@class Order;
@class OrderView;
@class OrderSummaryRenderer;
@class OrderManager;

@interface OrderSummaryViewController : UITableViewController <UITableViewDelegate,UIAlertViewDelegate>
{
    
    OrderManager *theOrderManager;
    OrderView *orderView;
    OrderSummaryRenderer *orderSummaryRenderer;  
    UIBarButtonItem *optionsButton;
    
    id<OrderManagementDelegate> delegate;
    
}

@property (retain) OrderManager *theOrderManager;

@property (retain) id<OrderManagementDelegate> delegate;

-(OrderSummaryViewController *)initializeWithOrderManager:(OrderManager *) anOrderManager;

-(void) toggleWhetherFavorite;

-(void) promptForFavDeletion;

-(void) promptUserForRename;

-(void) popToMainPage;

-(void)renameOrder:(NSString *)newName;

@end
