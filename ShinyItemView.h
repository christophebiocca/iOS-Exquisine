//
//  ShinyItemView.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShinyItemView : UIView
{
    UITableView *itemTable;
    UIImageView *itemBarImageView;
}

@property (retain) UITableView *itemTable;

@end
