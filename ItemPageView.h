//
//  ItemPageView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemPageView : UIView{
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
