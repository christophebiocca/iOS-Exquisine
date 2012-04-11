//
//  ShinyOrderHistoryCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinyOrderHistoryCell : CustomViewCell
{
    NSDictionary *orderInfo;
    UIImageView *cellImage;
    UILabel *statusLabel;
    UILabel *dateLabel;
    UILabel *priceLabel;
}

-(void) updateCell;

@end
