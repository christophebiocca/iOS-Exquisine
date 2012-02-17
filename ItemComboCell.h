//
//  ItemComboCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCompositeCell.h"
@class Item;

@interface ItemComboCell : MenuCompositeCell
{
    Item *item;
}

-(void)setData:(id)theItem;

@end
