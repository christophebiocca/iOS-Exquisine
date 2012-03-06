//
//  ComboItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboItemViewController.h"
#import "ComboItemRenderer.h"
#import "ItemView.h"
#import "Item.h"

@implementation ComboItemViewController

-(ItemViewController *)initWithItemAndOrderAndReturnController:(Item *)anItem :(Order *)anOrder :(UIViewController *)aController
{
    self = [super initWithItemAndOrderAndReturnController:anItem :anOrder :aController];
    
    if (self) {
        itemRenderer = [[ComboItemRenderer alloc] initWithItem:anItem];
        [[itemView itemTable] setDataSource:itemRenderer];
    }
    
    return self;
}

-(void)itemAltered
{
    [super itemAltered];
    
    [[itemView priceButton] setTitle:[NSString stringWithFormat:@"Item price:%@",[Utilities FormatToPrice:[itemInfo price]]]];
}

@end
