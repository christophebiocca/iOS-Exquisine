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
    UILabel* totalLabelHeading;
    UILabel* totalLabelValue;
}

@property(readonly)UITableView* orderTable;
@property(readonly)UILabel* totalLabelHeading;
@property(readonly)UILabel* totalLabelValue;

@end
