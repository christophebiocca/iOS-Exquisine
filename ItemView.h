//
//  ItemView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuComponentView.h"

@interface ItemView : MenuComponentView
{    
    UITableView* itemTable;
    UIToolbar* itemToolBar;
    UILabel* totalLabelHeading;
    UILabel* totalLabelValue;
    UIBarButtonItem* deleteButton;
}

@property(readonly)UITableView* itemTable;    
@property(readonly)UIToolbar* itemToolBar;
@property(readonly)UILabel* totalLabelHeading;
@property(readonly)UILabel* totalLabelValue;
@property(readonly)UIBarButtonItem* deleteButton;

@end
