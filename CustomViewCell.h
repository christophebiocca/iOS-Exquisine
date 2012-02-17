//
//  CustomViewCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//

#import <UIKit/UIKit.h>

typedef enum CellStyle {
    CELL_STYLE_PLAIN = 0,
    CELL_STYLE_FANCY = 1
} CellStyle;

@class MenuComponent;

@interface CustomViewCell : UITableViewCell
   
-(id)init;

+(NSString*)cellIdentifier;

+(UITableViewCellStyle)cellStyle;

-(void)setStyle:(CellStyle)style;

@end
