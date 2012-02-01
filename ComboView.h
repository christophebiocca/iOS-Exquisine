//
//  ComboView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentView.h"

@interface ComboView : MenuComponentView
{
    UITableView* comboTable;
    UIToolbar* comboToolBar;
}

@property(readonly)UITableView* comboTable;
@property(readonly)UIToolbar* comboToolBar;

@end