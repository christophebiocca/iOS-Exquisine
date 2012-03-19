//
//  ShinyChoiceCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Choice;

@interface ShinyChoiceCell : CustomViewCell
{
    Choice *theChoice;
    UIImageView *choiceImage;
    UILabel *choiceNameLabel;
    UILabel *choicePriceLabel;
}

-(void) updateCell;

@end
