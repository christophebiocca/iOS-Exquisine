//
//  ShinyOrderItemCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinyOrderItemCell : CustomViewCell
{
    //we expect an NSNumber for key "index"
    //and an Item for key "item"
    
    NSDictionary *itemCellDict;
    UILabel *numberOfItemsLabel;
}

-(void) updateCell;

@end
