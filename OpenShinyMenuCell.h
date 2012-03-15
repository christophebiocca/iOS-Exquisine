//
//  OpenShinyMenuCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-15.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class Menu;

@interface OpenShinyMenuCell : CustomViewCell
{
    Menu *theMenu;
    UIImageView *menuExpandedImage;
    UILabel *menuNameLabel;
}

-(void) updateCell;

@end
