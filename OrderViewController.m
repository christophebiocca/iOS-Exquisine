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
#import "UICustomActionSheet.h"
#import "AlertPrompt.h"
#import "OrderManagementDelegate.h"
#import "Utilities.h"

@interface UIActionSheet(AccessPrivate)
    @property(readonly)NSMutableArray* buttons;
@end

@implementation OrderViewController

@synthesize orderInfo;
@synthesize delegate;

-(OrderViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder
{
    menuInfo = aMenu;
    orderInfo = anOrder;
    orderRenderer = [[OrderRenderer alloc] initWithOrder:anOrder];
    [[self navigationItem] setTitle:anOrder.name];
    
    return self;
}

-(void)renameOrder:(NSString *)newName
{
    [orderInfo setName:newName];
    [[self navigationItem] setTitle:newName];
}

-(void)displayOptions
{
    
    if([orderInfo isFavorite])
    {
        UICustomActionSheet *optionPopup = [[UICustomActionSheet alloc] initWithTitle:@"Order options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Submit this order!" otherButtonTitles:@"Rename this order" , @"Delete from favorites", nil];
        
        [optionPopup setColor:[UIColor colorWithRed:36/255.0 green:99/255.0 blue:222/255.0 alpha:230/255.0] forButtonAtIndex:0];
        [optionPopup setColor:[UIColor colorWithRed:187/255.0 green:189/255.0 blue:192/255.0 alpha:230/255.0] forButtonAtIndex:1];
        [optionPopup setColor:[UIColor colorWithRed:235/255.0 green:12/255.0 blue:20/255.0 alpha:230/255.0] forButtonAtIndex:2];
        [optionPopup setColor:[UIColor colorWithRed:21/255.0 green:29/255.0 blue:39/255.0 alpha:230/255.0] forButtonAtIndex:3];
        
        [optionPopup setTag:2];
        
        [optionPopup showInView:orderView];
    }
    else
    {
        UICustomActionSheet *optionPopup = [[UICustomActionSheet alloc] initWithTitle:@"Order options" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Submit this order!" otherButtonTitles:@"Rename this order" , @"Add to favorites", @"Clear this order", nil];
        
        [optionPopup setColor:[UIColor colorWithRed:36/255.0 green:99/255.0 blue:222/255.0 alpha:230/255.0] forButtonAtIndex:0];
        [optionPopup setColor:[UIColor colorWithRed:187/255.0 green:189/255.0 blue:192/255.0 alpha:230/255.0] forButtonAtIndex:1];
        [optionPopup setColor:[UIColor colorWithRed:187/255.0 green:189/255.0 blue:192/255.0 alpha:230/255.0] forButtonAtIndex:2];
        [optionPopup setColor:[UIColor colorWithRed:235/255.0 green:12/255.0 blue:20/255.0 alpha:230/255.0] forButtonAtIndex:3];
        [optionPopup setColor:[UIColor colorWithRed:21/255.0 green:29/255.0 blue:39/255.0 alpha:230/255.0] forButtonAtIndex:4];
        
        [optionPopup setTag:1];
        
        [optionPopup showInView:orderView];
    }
}

-(void)displayOrderConfirmation
{
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Are you sure?" message:[NSString stringWithFormat: @"Are you sure you'd like to make this purchase of %@?", [Utilities FormatToPrice:[orderInfo totalPrice]]] delegate:self cancelButtonTitle:@"Nope" otherButtonTitles:@"Awww Yeah!", nil];
    
    [areYouSure setTag:1];
    
    [areYouSure show];
}

-(void)displayOrderClearConfirmation
{
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Are you sure?" message:[NSString stringWithFormat: @"Are you sure you want to remove all items in this order?", [orderInfo totalPrice]] delegate:self cancelButtonTitle:@"Nope" otherButtonTitles:@"Yep", nil];
    
    [areYouSure setTag:4];
    
    [areYouSure show];
}

-(void)displayDeletionConfirmation
{
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Are you sure?" message:[NSString stringWithFormat: @"You cannot recover this order after deleting it.", [orderInfo totalPrice]] delegate:self cancelButtonTitle:@"Oh, well then no" otherButtonTitles:@"Yep, delete it", nil];
    
    [areYouSure setTag:3];
    
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
    if ([alertView tag] == 1)
    {
        if (buttonIndex == 1)
        {
            [delegate submitOrderForController:self];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
    
    if ([alertView tag] == 2)
    {
        if (buttonIndex == 1)
        {
            NSString *entered = [ (AlertPrompt *)alertView enteredText];
            [self renameOrder:entered];
        }
    }
    
    if ([alertView tag] == 3)
    {
        if (buttonIndex == 1)
        {
            [delegate deleteFromFavoritesForController:self];
            [[self navigationController] popViewControllerAnimated:YES];
        }
    }
    if ([alertView tag] == 4)
    {
        if (buttonIndex == 1)
        {
            [orderInfo setItemList:[[NSMutableArray alloc] initWithCapacity:0]];
            [orderRenderer redraw];
            [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        }
    }
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([actionSheet tag] == 1)
    {
        switch (buttonIndex) {
            case 0:
                [self displayOrderConfirmation];
                break;
                
            case 1:
                [self promptUserForRename];
                break;
                
            case 2:
                [delegate addToFavoritesForController:self];
                break;
            case 3:
                [self displayOrderClearConfirmation];
                break;
            default:
                break;
        }
    }
    if ([actionSheet tag] == 2)
    {
        switch (buttonIndex) {
            case 0:
                [self displayOrderConfirmation];
                break;
                
            case 1:
                [self promptUserForRename];
                break;
                
            case 2:
                [self displayDeletionConfirmation];
                break;
                
            default:
                break;
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[orderInfo itemList] count]) {
        Item *currentItem = [[orderInfo itemList] objectAtIndex:[indexPath row]];
        
        //Only push it if there's anything to customize about it.
        if([[currentItem options]count] > 0)
        {
            ItemViewController *itemViewController = [[ItemViewController alloc] initializeWithItemAndOrder:currentItem:orderInfo];
            [[self navigationController] pushViewController:itemViewController animated:YES];
        }
    }
    
    //i.e. if the "Add Item" row was selected
    if([indexPath row] == ([[orderInfo itemList] count] + 3)){
        //allocate a new menu renderer passing this order to it     
        MenuViewController *menuViewController = [[MenuViewController alloc] initializeWithMenuAndOrder:menuInfo :orderInfo];
        
        //Push the menu page
        [[self navigationController] pushViewController:menuViewController animated:YES];
    }
    
}

-(void)tableView:(UITableView *) tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *) indexPath
{
    [self tableView:tableView didSelectRowAtIndexPath:indexPath];
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
    orderView = [[OrderView alloc] init];
    [[orderView orderTable] setDelegate:self];
    [[orderView orderTable] setDataSource:orderRenderer];
    
    optionsButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(displayOptions)];
    
    [[self navigationItem] setRightBarButtonItems:[[NSArray alloc] initWithObjects:optionsButton, nil]];
    
    [self setView:orderView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [orderRenderer redraw];
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
