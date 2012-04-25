//
//  PotentialPromoCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class PotentialPromo;

@interface PotentialPromoCell : CustomViewCell
{
    PotentialPromo *thePromo;
    UIImageView *cellImage;
    UILabel *nameLabel;
    UILabel *descriptionLabel;
    UILabel *qualificationLabel;
}

-(void) updateCell;

@end
