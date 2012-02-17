//
//  MenuCompositeCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

typedef enum menuComponentCellContext {
    VIEW_CELL_CONTEXT_ORDER = 0,
    VIEW_CELL_CONTEXT_MENU = 1,
    VIEW_CELL_CONTEXT_RECEIPT = 2
} MenuComponentCellContext;

@class MenuComponent;

@interface MenuCompositeCell : CustomViewCell
{
    MenuComponent* componentInfo; 
}

+(MenuCompositeCell *)customViewCellWithMenuComponent:(MenuComponent *)component AndContext:(MenuComponentCellContext) context;

+(NSString *)cellIdentifierForMenuComponent:(MenuComponent *)component AndContext:(MenuComponentCellContext) context;

-(void)setMenuComponent:(MenuComponent *) aMenuComponent;

-(void)updateCell;

@end
