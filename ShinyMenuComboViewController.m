//
//  ShinyComboViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-04.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyMenuComboViewController.h"
#import "ShinyMenuComboRenderer.h"
#import "ShinyComboView.h"
#import "ShinyMenuItemViewController.h"
#import "ShinyItemGroupViewController.h"
#import "ShinyComboItemViewController.h"
#import "ShinyComboFavoriteCell.h"
#import "Combo.h"
#import "ExpandableCell.h"
#import "ItemGroup.h"
#import "AppData.h"
#import "Menu.h"
#import "Item.h"

NSString *COMBO_DONE_BUTTON_HIT = @"CroutonLabs/ComboDoneButtonHit";

@implementation ShinyMenuComboViewController

@synthesize theCombo;

-(id)initWithCombo:(Combo *)aCombo
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theCombo = aCombo;
        comboView = [[ShinyComboView alloc] init];
        comboRenderer = [[ShinyMenuComboRenderer alloc] initWithCombo:theCombo];
        
        [[comboView comboTable] setDelegate:self];
        [[comboView comboTable] setDataSource:comboRenderer];
        
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if ([[CustomViewCell cellIdentifierForData:[comboRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyItemGroupCell"])
    {
        ItemGroup *theItemGroup = [comboRenderer objectForCellAtIndex:indexPath];        
        
        if ([[theItemGroup listOfItems] count] == 1) {
            Item *theItem = [[theItemGroup listOfItems] objectAtIndex:0];
            if (([[theItem options] count] > 0)||![[theItem desc] isEqualToString:@""]) 
            {
                ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
                [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemButtonHit:) name:ITEM_DONE_BUTTON_HIT object:newController];
                [[self navigationController] pushViewController:newController animated:YES];
                return;
            }
            else {
                return;
            }
        }
        else {
            ShinyItemGroupViewController *newController = [[ShinyItemGroupViewController alloc] initWithItemGroup:theItemGroup];
            [[self navigationController] pushViewController:newController animated:YES];
        }
    }
    else if ([[CustomViewCell cellIdentifierForData:[comboRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyComboFavoriteCell"])
    {
        if ([[[[AppData appData] favoritesMenu] comboList] containsObject:theCombo] ) {
            [(ShinyComboFavoriteCell *)[tableView cellForRowAtIndexPath:indexPath] wasClicked];
            [[self navigationController] popViewControllerAnimated:YES];
        }
        else {
            
            [(ShinyComboFavoriteCell *)[tableView cellForRowAtIndexPath:indexPath] wasClicked];
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[comboRenderer objectForCellAtIndex:indexPath]];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadView
{
    [super loadView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    [self setView:comboView];
}

-(void) addItemButtonHit:(NSNotification *) aNotification
{
    [theCombo addItem:[(ShinyMenuItemViewController *)[aNotification object] theItem]];
}

-(void) doneButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_DONE_BUTTON_HIT object:self];
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
    
    [toolbarText setText:[theCombo name]];
    [toolbarText setAdjustsFontSizeToFitWidth:YES];
    
    [[self navigationItem] setTitleView:toolbarText];
    
    if ([theCombo satisfied]) {
        [[[self navigationItem] rightBarButtonItem] setEnabled:YES];
    }
    else{
        [[[self navigationItem] rightBarButtonItem] setEnabled:NO];
    }
}

-(void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObject:self];
}

@end
