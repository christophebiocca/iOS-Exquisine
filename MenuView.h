//
//  MenuView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-18.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentView.h"

@interface MenuView : MenuComponentView
{
    UITableView* menuTable;
    UIToolbar* menuToolBar;
    UIBarButtonItem* cancelButton;
}

@property(readonly)UITableView* menuTable;
@property(readonly)UIToolbar* menuToolBar;
@property(readonly)UIBarButtonItem* cancelButton;

@end
