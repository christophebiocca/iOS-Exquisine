//
//  OrderView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentView.h"

@interface OrderView : MenuComponentView
{
    UITableView* orderTable;
    UIToolbar* orderToolbar;
    UIBarButtonItem* editButton;
    UIBarButtonItem* leftSpacer;
    UIBarButtonItem* priceDisplayButton;
    UIBarButtonItem* rightSpacer;
    UIBarButtonItem* favoriteButton;
    
}

@property(readonly)UITableView* orderTable;

@property (retain) UIBarButtonItem *priceDisplayButton;
@property (retain) UIBarButtonItem *editButton;
@property (retain) UIBarButtonItem *favoriteButton;
@property (retain) UIToolbar *orderToolbar;
@property (retain) UIBarButtonItem *leftSpacer;

@end
