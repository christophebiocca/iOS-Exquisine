//
//  ShinyItemViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class Item;

extern NSString* ITEM_DONE_BUTTON_HIT;

@interface ShinyMenuItemViewController : ListViewController
{
    Item *theItem;
}

@property (retain) Item *theItem;

-(id) initWithItem:(Item *) anItem;

@end
