//
//  PotentialPromoCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface PotentialPromoCell : CustomViewCell
{
    NSDictionary *settingsInfo;
    UIImageView *cellImage;
    UILabel *settingsLabel;
}

-(void) updateCell;

@end
