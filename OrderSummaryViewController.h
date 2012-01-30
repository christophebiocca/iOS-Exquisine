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

@interface OrderSummaryViewController : UITableViewController <UITableViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    Order *orderInfo;
    OrderView *orderView;
    OrderSummaryRenderer *orderSummaryRenderer;  
    UIBarButtonItem *optionsButton;
    
    id<OrderManagementDelegate> delegate;
    
}

@property (retain) Order *orderInfo;

@property (retain) id<OrderManagementDelegate> delegate;

-(OrderSummaryViewController *)initializeWithOrder:(Order *) anOrder;

-(void) displayOptions;

-(void) toggleWhetherFavorite;

-(void) promptForFavDeletion;

-(void) promptUserForRename;

-(void) popToMainPage;

-(void)renameOrder:(NSString *)newName;

@end
