//
//  ShinyOrderItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderItemViewController.h"
#import "ExpandableCell.h"
#import "Item.h"
#import "Option.h"
#import "ShinyItemView.h"
#import "Choice.h"
#import "ShinyOrderItemRenderer.h"
#import "ShinyChoiceCell.h"
#import "ShinyItemFavoriteCell.h"

NSString* ITEM_DELETE_BUTTON_HIT = @"CroutonLabs/ItemDeleteButtonHit";

@implementation ShinyOrderItemViewController

-(id)initWithItem:(Item *)anItem
{
    self = [super init];
    {
        theItem = anItem;
        renderer = [[ShinyOrderItemRenderer alloc] initWithItem:theItem];
        [theTableView setDataSource:renderer];
    }
    return self;
}

-(void)ShinyDeleteCellHandler:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_DELETE_BUTTON_HIT object:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)loadView
{
    [super loadView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

@end
