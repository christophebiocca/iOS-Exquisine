//
//  ItemGroupCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-31.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemGroup.h"

@interface ItemGroupCell : UITableViewCell
{
    ItemGroup *itemGroup;
}

@property (nonatomic,retain) ItemGroup *itemGroup;

-(id)init;

+(NSString *) cellIdentifier;

@end
