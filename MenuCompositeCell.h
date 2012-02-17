//
//  MenuCompositeCell.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CustomViewCell.h"

@class MenuComponent;

@interface MenuCompositeCell : CustomViewCell
{
    MenuComponent* componentInfo; 
}

+(MenuCompositeCell *)customViewCellWithMenuComponent:(MenuComponent *)component AndContext:(CellContext) context;

+(NSString *)cellIdentifierWithMenuComponent:(MenuComponent *)component AndContext:(CellContext) context;

-(void)setData:(MenuComponent *) aMenuComponent;

-(void)updateCell;

@end
