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
    UIToolbar* orderToolBar;
    UILabel* totalLabelHeading;
    UILabel* totalLabelValue;
    UIBarButtonItem* spacerButton;
    UIBarButtonItem* doneButton;
}

@property(readonly)UITableView* orderTable;
@property(readonly)UIToolbar* orderToolBar;
@property(readonly)UILabel* totalLabelHeading;
@property(readonly)UILabel* totalLabelValue;
@property(readonly)UIBarButtonItem* spacerButton;
@property(readonly)UIBarButtonItem* doneButton;

@end
