//
//  ItemGroupView.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentView.h"

@interface ItemGroupView : MenuComponentView

{
    UITableView* itemGroupTable;
    UIToolbar* itemGroupToolBar;
}

@property(readonly)UITableView* itemGroupTable;
@property(readonly)UIToolbar* itemGroupToolBar;

@end
