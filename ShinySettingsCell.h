//
//  ShinySettingsCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinySettingsCell : CustomViewCell
{
    NSDictionary *settingsInfo;
    UIImageView *cellImage;
    UILabel *settingsLabel;
}

-(void) updateCell;

@end
