//
//  ShinyItemFavoriteCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Item;

@interface ShinyItemFavoriteCell : CustomViewCell
{
    Item *theItem;
    UIImageView *displayImage;
    UILabel *displayMessage;
}

-(void) updateCell;

-(void) wasClicked;
@end
