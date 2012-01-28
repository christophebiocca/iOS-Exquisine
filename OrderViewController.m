//
//  OrderViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderViewController.h"
#import "ItemViewController.h"
#import "Item.h"
#import "Menu.h"
#import "MenuViewController.h"
#import "Order.h"
#import "OrderView.h"
#import "OrderRenderer.h"
#import "AlertPrompt.h"
#import "OrderManagementDelegate.h"
#import "Utilities.h"
#import "ItemRenderer.h"
#import "CellData.h"
#import "MenuRenderer.h"

@implementation OrderViewController

@synthesize orderInfo;
@synthesize delegate;

-(OrderViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder
{
    menuInfo = aMenu;
    orderInfo = anOrder;
    orderRenderer = [[OrderRenderer alloc] initWithOrderAndMenu:orderInfo:menuInfo];
    
    [[self navigationItem] setTitle:@"Select Items"];
    return self;
}

-(void)renameOrder:(NSString *)newName
{
    [orderInfo setName:newName];
    [[self navigationItem] setTitle:newName];
}

-(void)displayOrderConfirmation
{
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Are you sure?" message:[NSString stringWithFormat: @"Are you sure you'd like to make this purchase of %@?", [Utilities FormatToPrice:[orderInfo totalPrice]]] delegate:self cancelButtonTitle:@"Nope" otherButtonTitles:@"Awww Yeah!", nil];
    
    [areYouSure setTag:1];
    
    [areYouSure show];
}

-(void)promptUserForRename
{
    
    AlertPrompt *renamePrompt = [[AlertPrompt alloc] initWithPromptTitle:@"New order name:" message:@"name" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"OK"];
    [renamePrompt setTag:2];
    
    [renamePrompt show];
}

//Delegate functions
//***********************************************************


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) // Order Placement
    {
        if (buttonIndex == 1)
        {
            [delegate submitOrderForController:self];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
    
    if ([alertView tag] == 2) // Order Rename
    {
        if (buttonIndex == 1)
        {
            NSString *entered = [ (AlertPrompt *)alertView enteredText];
            [self renameOrder:entered];
        }
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id cellObject = [orderRenderer objectForCellAtIndex:indexPath];
    
    if ( [cellObject isKindOfClass:([Menu class])])
    {
        
        MenuViewController *newMenuController = [[MenuViewController alloc] initializeWithMenuAndOrder:cellObject:orderInfo];
        
        [[self navigationController] pushViewController:newMenuController animated:YES];
        
    }
    
    if ( [cellObject isKindOfClass:([Item class])])
    {
        
        ItemViewController *newItemController = [[ItemViewController alloc] initializeWithItemAndOrder:cellObject:orderInfo];
        
        [[self navigationController] pushViewController:newItemController animated:YES];
        
    }
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [orderRenderer refreshOrderList];
    [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    [[orderView priceDisplayButton] setTitle:[Utilities FormatToPrice:[orderInfo subtotalPrice]]];
}


//View related functions
//***********************************************************

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) loadView
{
    editing = NO;
    orderView = [[OrderView alloc] init];
    [[orderView orderTable] setDelegate:self];
    [[orderView orderTable] setDataSource:orderRenderer];
    
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(displayOrderConfirmation)];
    
    [[self navigationItem] setRightBarButtonItems:[[NSArray alloc] initWithObjects:submitButton, nil]];
    
    [[orderView priceDisplayButton] setTitle:[Utilities FormatToPrice:[orderInfo subtotalPrice]]];
    
    [[orderView editButton] setTarget:self];
    [[orderView editButton] setAction:@selector(toggleEditing)];
    
    [self setView:orderView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[orderView priceDisplayButton] setTitle:[NSString stringWithFormat:@"%@%@",@"Subtotal: ",[Utilities FormatToPrice:[orderInfo subtotalPrice]] ]];
    [orderRenderer refreshOrderList];
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( [indexPath section] == 1)
    {
        return 28.0f;
    }
    return 44.0f;
}

-(void)toggleEditing
{
    if(editing)
    {
        [self exitEditingMode];
    }
    else
    {
        [self enterEditingMode];
    }
    editing = !editing;
}

-(void)enterEditingMode
{
    [[orderView orderTable] setEditing:YES animated:YES];
    [[orderView editButton] setTitle:@"Done"];
}

-(void)exitEditingMode
{
    [[orderView orderTable] setEditing:NO animated:YES];
    [[orderView editButton] setTitle:@"Edit"];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
