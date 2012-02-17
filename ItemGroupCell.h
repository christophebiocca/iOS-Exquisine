//
//  ItemGroupCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCompositeCell.h"
@class ItemGroup;

@interface ItemGroupCell : MenuCompositeCell
{
    ItemGroup *itemGroup;
}

+(NSString *) cellIdentifier;

-(void)setMenuComponent:(ItemGroup *)theItemGroup;

@end
