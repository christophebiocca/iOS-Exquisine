//
//  MenuComponentRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponentRenderer.h"
#import "MenuComponent.h"
#import "OrderManager.h"
#import "Item.h"
#import "Combo.h"
#import "Menu.h"
#import "MenuRenderer.h"
#import "ItemGroup.h"
#import "OrderRenderer.h"
#import "ItemRenderer.h"
#import "ComboRenderer.h"
#import "ItemGroupRenderer.h"

@implementation MenuComponentRenderer

+(MenuComponentRenderer *) menuComponentRendererFromData:(id) data;
{
    if([data isKindOfClass:[OrderManager class]])
    {
        return [[OrderRenderer alloc] initWithOrderManager:data];
    }
    if([data isKindOfClass:[Item class]])
    {
        return [[ItemRenderer alloc] initWithItem:data];
    }
    if([data isKindOfClass:[Combo class]])
    {
        return [[ComboRenderer alloc] initWithCombo:data];
    }
    if([data isKindOfClass:[ItemGroup class]])
    {
        return [[ItemGroupRenderer alloc] initWithItemGroup:data];
    }
    if([data isKindOfClass:[Menu class]])
    {
        return [[MenuRenderer alloc] initWithMenu:data];
    }
    
    CLLog(LOG_LEVEL_WARNING, @"menuComponentRendererFromData was called with an unknown data type");
    return nil;
}

-(MenuComponentRenderer *)init
{
    self = [super init];
    
    return self;
}


@end
