//
//  OrderSummaryViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderSummaryViewController.h"
#import "Order.h"
#import "OrderSummaryRenderer.h"
#import "OrderView.h"
#import "Utilities.h"

@implementation OrderSummaryViewController

@synthesize orderInfo;

-(OrderSummaryViewController *)initializeWithOrder:(Order *) anOrder
{    
    
    orderInfo = anOrder;
    orderSummaryRenderer = [[OrderSummaryRenderer alloc] initWithOrder:orderInfo];
    [[self navigationItem] setTitle:orderInfo.status];
    
    return self;
}

-(void)displayOptions
{
    /*
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
    }*/
}

//Delegate functions
//***********************************************************


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    /*
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
    }*/
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /*
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id cellRenderer = [orderSummaryRenderer objectForCellAtIndex:indexPath];
    
    if ([cellRenderer isKindOfClass:[ItemRenderer class]])
    {
        Item *currentItem = [(ItemRenderer *)cellRenderer itemInfo];
        
        if([[currentItem options]count] > 0)
        {
            ItemViewController *itemViewController = [[ItemViewController alloc] initializeWithItemAndOrder:currentItem:orderInfo];
            [[self navigationController] pushViewController:itemViewController animated:YES];
        }
    }
    
    //i.e. if the "Add Item" row was selected
    if([cellRenderer isKindOfClass:[CellData class]]){
        if ([(CellData *)cellRenderer cellTitle] == @"Add Item")
        {
            //allocate a new menu renderer passing this order to it     
            MenuViewController *menuViewController = [[MenuViewController alloc] initializeWithMenuAndOrder:menuInfo :orderInfo];
            
            //Push the menu page
            [[self navigationController] pushViewController:menuViewController animated:YES];
        }
    }
     */
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
    [[orderView orderTable] setDataSource:orderSummaryRenderer];
    
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
    [orderSummaryRenderer redraw];
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( [indexPath row] < ([Utilities CompositeListCount:[orderSummaryRenderer displayLists]] - 3))
    {
        return 28.0f;
    }
    return 44.0f;
}

@end
