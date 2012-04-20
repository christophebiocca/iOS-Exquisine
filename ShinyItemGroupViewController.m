//
//  ShinyItemGroupViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemGroupViewController.h"
#import "ShinyItemGroupRenderer.h"
#import "ShinyComboItemViewController.h"
#import "ExpandableCell.h"
#import "Item.h"
#import "ItemGroup.h"

@implementation ShinyItemGroupViewController

@synthesize theItemGroup;

-(id)initWithItemGroup:(ItemGroup *)anItemGroup
{
    self = [super init];
    if (self) 
    {
        theItemGroup = anItemGroup;
        renderer = [[ShinyItemGroupRenderer alloc] initWithItemGroup:theItemGroup];
        [theTableView setDataSource:renderer];
    }
    return self;
}

-(void)ShinyMenuItemCellHandler:(NSIndexPath *)indexPath
{
    Item *theItem = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"menuItem"];        
    if (([[theItem options] count] > 0)||![[theItem desc] isEqualToString:@""]) 
    {
        ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemButtonHit:) name:ITEM_DONE_BUTTON_HIT object:newController];
        [[self navigationController] pushViewController:newController animated:YES];
        return;
    }
    else 
    {
        [theItemGroup setSatisfyingItem:theItem];
        [[self navigationController] popViewControllerAnimated:YES];
    }    
}

-(void)loadView
{
    [super loadView];
    UIBarButtonItem *fillerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    [fillerButton setCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 21)]];
    [[self navigationItem] setRightBarButtonItem:fillerButton];
}

-(void) addItemButtonHit:(NSNotification *) aNotification
{
    [theItemGroup setSatisfyingItem:[(ShinyMenuItemViewController *)[aNotification object] theItem]];
    NSMutableArray *newControllerStack = [[NSMutableArray alloc] initWithCapacity:0];
    for (UIViewController *eachController in [[self navigationController] viewControllers]) {
        if (eachController == self) {
            break;
        }
        else {
            [newControllerStack addObject:eachController];
        }
    }
    [[self navigationController] setViewControllers:newControllerStack animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [(UILabel *)[[self navigationItem] titleView] setText:[theItemGroup name]];
}

@end
