//
//  MenuCompositeCell.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuCompositeCell.h"
#import "MenuComponent.h"
#import "ItemMenuCell.h"
#import "itemOrderCell.h"
#import "MenuCell.h"
#import "ChoiceCell.h"
#import "ComboOrderCell.h"
#import "OrderCell.h"
#import "ItemGroupCell.h"
#import "Item.h"
#import "Menu.h"
#import "Choice.h"
#import "Combo.h"
#import "Order.h"
#import "ItemGroup.h"
#import "ComboMenuCell.h"

@implementation MenuCompositeCell

+(MenuCompositeCell *)customViewCellWithMenuComponent:(MenuComponent *)component AndContext:(MenuComponentCellContext) context
{
    MenuCompositeCell *newCustomViewCell = nil;
    if([component isKindOfClass:[Item class]])
    {
        switch (context) {
            case VIEW_CELL_CONTEXT_MENU:
                newCustomViewCell = [[ItemMenuCell alloc] init];
                break;
                
            case VIEW_CELL_CONTEXT_ORDER:
                newCustomViewCell =  [[ItemOrderCell alloc]init];
                break;
                
            default:
                break;
        }
    }
    if([component isKindOfClass:[Menu class]])
    {
        newCustomViewCell =  [[MenuCell alloc]init];
    }
    if([component isKindOfClass:[Choice class]])
    {
        newCustomViewCell =  [[ChoiceCell alloc]init];
    }
    if([component isKindOfClass:[Combo class]])
    {
        switch (context) {
            case VIEW_CELL_CONTEXT_MENU:
                newCustomViewCell = [[ComboMenuCell alloc] init];
                break;
                
            case VIEW_CELL_CONTEXT_ORDER:
                newCustomViewCell =  [[ComboOrderCell alloc]init];
                break;
                
            default:
                break;
        }
    }
    if([component isKindOfClass:[Order class]])
    {
        newCustomViewCell =  [[OrderCell alloc]init];
    }
    if([component isKindOfClass:[ItemGroup class]])
    {
        newCustomViewCell =  [[ItemGroupCell alloc]init];
    }
    
    if(!newCustomViewCell)
    {
        newCustomViewCell = [[self alloc]init];
    }
    
    [newCustomViewCell setMenuComponent:component];
    
    return newCustomViewCell;
}

+(NSString *)cellIdentifierForMenuComponent:(MenuComponent *)component AndContext:(MenuComponentCellContext) context
{
    if([component isKindOfClass:[Item class]])
    {
        switch (context) {
            case VIEW_CELL_CONTEXT_MENU:
                return [ItemMenuCell cellIdentifier];
                break;
                
            case VIEW_CELL_CONTEXT_ORDER:
                return [ItemOrderCell cellIdentifier];
                break;
                
            default:
                break;
        }
    }
    if([component isKindOfClass:[Menu class]])
    {
        return [MenuCell cellIdentifier];
    }
    if([component isKindOfClass:[Choice class]])
    {
        return [ChoiceCell cellIdentifier];
    }
    if([component isKindOfClass:[Combo class]])
    {
        switch (context) {
            case VIEW_CELL_CONTEXT_MENU:
                return [ComboMenuCell cellIdentifier];
                break;
                
            case VIEW_CELL_CONTEXT_ORDER:
                return [ComboOrderCell cellIdentifier];
                break;
                
            default:
                break;
        }
    }
    if([component isKindOfClass:[Order class]])
    {
        return [OrderCell cellIdentifier];
    }
    if([component isKindOfClass:[ItemGroup class]])
    {
        return [ItemGroupCell cellIdentifier];
    }
    
    return [self cellIdentifier];
}

+(NSString*)cellIdentifier{
    return @"MenuCompositeCell";
}

-(void)setMenuComponent:(MenuComponent *)aMenuComponent
{
    componentInfo = aMenuComponent;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:MENU_COMPONENT_NAME_CHANGED object:componentInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCell) name:MENU_COMPONENT_DESC_CHANGED object:componentInfo];
    [self updateCell];
}

-(void)updateCell
{
    [[self detailTextLabel] setText:[componentInfo desc]];
    [[self textLabel] setText:[componentInfo name]];
    [self setNeedsDisplay];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
