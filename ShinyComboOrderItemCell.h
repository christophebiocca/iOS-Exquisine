//
//  ShinyComboOrderItemCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinyComboOrderItemCell : CustomViewCell
{
    //we expect an NSNumber for key "index"
    //and an Item for key "item"
    
    NSDictionary *itemCellDict;
}

-(void) updateCell;

@end
