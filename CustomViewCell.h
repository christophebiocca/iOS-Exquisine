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

typedef enum CellContext {
    CELL_CONTEXT_ORDER = 0,
    CELL_CONTEXT_MENU = 1,
    CELL_CONTEXT_RECEIPT = 2,
    CELL_CONTEXT_COMBO = 3
} CellContext;
@class MenuComponent;

@interface CustomViewCell : UITableViewCell
   
+(CustomViewCell *) customViewCellFromData:(id)data AndContext:(CellContext)context;

-(id)init;

+(NSString*)cellIdentifier;

+(UITableViewCellStyle)cellStyle;

+(NSString *)cellIdentifierForData:(id)data AndContext:(CellContext)context;

-(void)setStyle:(CellStyle)style;

-(void)setData:(id)data;

@end
