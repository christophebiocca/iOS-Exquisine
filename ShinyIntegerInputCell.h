//
//  IntegerInputCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-03-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"
@class IntegerInputCellData;

@interface ShinyIntegerInputCell : CustomViewCell
{
    IntegerInputCellData *integerCellData;
    UILabel *numberLabel;
    UIButton *plusButton;
    UIButton *minusButton;
}

-(void) updateCell;

@end
