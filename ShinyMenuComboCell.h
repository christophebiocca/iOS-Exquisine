//
//  ShinyMenuComboCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Combo;

@interface ShinyMenuComboCell : CustomViewCell
{
    Combo *theCombo;
    UIImageView *itemImage;
    UILabel *comboNameLabel;
    UILabel *comboPriceLabel;
}

-(void) updateCell;

@end
