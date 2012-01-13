//
//  OrderPageView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderPageView : UIView{
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
