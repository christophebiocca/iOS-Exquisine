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
@class OrderManager;

@interface OrderViewController : UITableViewController <UITableViewDelegate, UIActionSheetDelegate,UIAlertViewDelegate>
{
    
    
    
    OrderManager *theOrderManager;
    OrderView *orderView;
    OrderRenderer *orderRenderer;  
    UIBarButtonItem *submitButton;
    
    id<OrderManagementDelegate> delegate;
    
    BOOL editing;
    
}

@property (retain) id<OrderManagementDelegate> delegate;

@property (retain) OrderManager *theOrderManager;

-(OrderViewController *)initializeWithOrderManager:(OrderManager *) anOrderManager;

-(void) renameOrder:(NSString *) newName;

-(void) displayOrderConfirmation;

-(void) promptForFavDeletion;

-(void) promptUserForRename;

-(void) enterEditingMode;

-(void) exitEditingMode;

-(void) popToMainPage;

-(void) toggleEditing;

-(void) toggleWhetherFavorite;

-(void) updateEditButton;

-(void) orderAltered:(NSNotification *)aNotification;

@end
