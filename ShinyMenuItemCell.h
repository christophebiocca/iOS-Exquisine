//
//  ShinyMenuItemCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Item;

@interface ShinyMenuItemCell : CustomViewCell
{
    Item *theItem;
    UIImageView *itemImage;
    UILabel *itemNameLabel;
    UILabel *itemPriceLabel;
}

-(void) updateCell;

@end
