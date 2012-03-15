//
//  ShinyMenuCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Menu;

@interface ClosedShinyMenuCell : CustomViewCell
{
    Menu *theMenu;
    UIImageView *menuColapsedImage;
    UILabel *menuNameLabel;
    UILabel *numberOfItemsLabel;
}

-(void) updateCell;

@end
