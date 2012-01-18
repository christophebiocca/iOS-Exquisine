//
//  OptionView.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentView.h"

@interface OptionView : MenuComponentView
{
    UITableView* optionTable;
}

@property(readonly)UITableView* optionTable;

@end
