//
//  ShinyComboItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboItemViewController.h"
#import "ShinyItemView.h"
#import "ShinyComboItemRenderer.h"
@implementation ShinyComboItemViewController

-(id)initWithItem:(Item *)anItem
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theItem = anItem;
        itemView = [[ShinyItemView alloc] init];
        itemRenderer = [[ShinyComboItemRenderer alloc] initWithItem:theItem];
        
        [[itemView itemTable] setDelegate:self];
        [[itemView itemTable] setDataSource:itemRenderer];
        
    }
    return self;
}

@end
