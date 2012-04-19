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

@synthesize theItem;

-(id)initWithItem:(Item *)anItem
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theItem = anItem;
        itemView = [[ShinyItemView alloc] init];
        itemRenderer = [[ShinyOrderItemRenderer alloc] initWithItem:theItem];
        
        [[itemView itemTable] setDelegate:self];
        [[itemView itemTable] setDataSource:itemRenderer];
        
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ExpandableCell class]])
    {
        [(ExpandableCell *)[tableView cellForRowAtIndexPath:indexPath] toggleOpen:indexPath :tableView];
    }
    else if ([[CustomViewCell cellIdentifierForData:[itemRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyChoiceCell"])
    {
        Choice *theChoice = [[itemRenderer objectForCellAtIndex:indexPath] objectForKey:@"choice"];
        [theChoice toggleSelected];
        [(ShinyChoiceCell *)[tableView cellForRowAtIndexPath:indexPath] pulseView];
    }
    else if ([[CustomViewCell cellIdentifierForData:[itemRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyItemFavoriteCell"])
    {
        [(ShinyItemFavoriteCell *)[tableView cellForRowAtIndexPath:indexPath] wasClicked];
    }
    else if ([[CustomViewCell cellIdentifierForData:[itemRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyDeleteCell"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_DELETE_BUTTON_HIT object:self];
        [[self navigationController] popViewControllerAnimated:YES];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[itemRenderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    [self setView:itemView];
}

-(void) doneButtonHit
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setBackgroundImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"] forBarMetrics:UIBarMetricsDefault];
    UILabel *toolbarText = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                     ([[[self navigationController] navigationBar] frame ].size.width - 300) / 2,
                                                                     (44 - 30) / 2, 
                                                                     300, 
                                                                     30)];
    [toolbarText setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:22]];
    [toolbarText setTextColor:[UIColor whiteColor]];
    [toolbarText setBackgroundColor:[UIColor clearColor]];
    [toolbarText setTextAlignment:UITextAlignmentCenter];
    
    [toolbarText setText:[theItem name]];
    [toolbarText setAdjustsFontSizeToFitWidth:YES];
    
    [[self navigationItem] setTitleView:toolbarText];
}

@end
