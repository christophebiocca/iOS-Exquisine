//
//  OpenShinyOptionCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Option;

@interface OpenShinyOptionCell : CustomViewCell
{
    Option *theOption;
    UIImageView *optionExpandedImage;
    UILabel *optionNameLabel;
}

-(void) updateCell;

@end
