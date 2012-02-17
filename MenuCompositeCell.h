//
//  MenuCompositeCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

enum MenuCompositeCellContext {
    MENU_VIEW_CELL_CONTEXT_ORDER = 0,
    MENU_VIEW_CELL_CONTEXT_MENU = 1,
    MENU_VIEW_CELL_CONTEXT_RECEIPT = 2
};

@class MenuComponent;

@interface MenuCompositeCell : CustomViewCell
{
    MenuComponent* componentInfo; 
}

-(void)setMenuComponent:(MenuComponent *) aMenuComponent;

@end
