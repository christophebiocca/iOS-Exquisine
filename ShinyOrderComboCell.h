//
//  ShinyOrderComboCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-13.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@interface ShinyOrderComboCell : CustomViewCell
{
    //we expect an NSNumber for key "index"
    //and an Combo for key "combo"
    
    NSDictionary *comboCellDict;
    UILabel *numberOfCombosLabel;
}

-(void) updateCell;

@end
