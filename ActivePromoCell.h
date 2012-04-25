//
//  ActivePromoCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class ActivePromo;

@interface ActivePromoCell : CustomViewCell
{
    ActivePromo *thePromo;
    UIImageView *cellImage;
    UILabel *nameLabel;
    UILabel *descriptionLabel;
    UILabel *saveLabel;
    UILabel *savePriceLabel;
}

-(void) updateCell;

@end
