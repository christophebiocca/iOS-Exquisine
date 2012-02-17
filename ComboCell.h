//
//  ComboCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuCompositeCell.h"

typedef enum CellStyle {
    CELL_STYLE_PLAIN = 0,
    CELL_STYLE_FANCY = 1
    } CellStyle;

@class Combo;

@interface ComboCell : MenuCompositeCell
{
    Combo *combo;
    CellStyle style;
}

@property (nonatomic,retain) Combo *combo;
@property (nonatomic) CellStyle style;

+(NSString *) cellIdentifier;

@end
