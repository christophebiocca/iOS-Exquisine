//
//  ClosedShinyOptionCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Option;

@interface ClosedShinyOptionCell : CustomViewCell
{
    Option *theOption;
    UIImageView *menuColapsedImage;
    UILabel *menuNameLabel;
    UILabel *numberOfItemsLabel;
}

-(void) updateCell;

@end
