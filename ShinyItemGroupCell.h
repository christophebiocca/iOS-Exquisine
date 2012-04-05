//
//  ShinyItemGroupCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
#import "ItemGroup.h"

@interface ShinyItemGroupCell : CustomViewCell
{
    ItemGroup *theItemGroup;
    UIImageView *cellImage;
    UILabel *nameLabel;
}

-(void) itemGroupChanged;

-(void) updateCell;

@end
