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
#import "MenuRenderer.h"
#import "OrderManager.h"

@implementation OrderViewController

@synthesize theOrderManager;
@synthesize delegate;

-(OrderViewController *)initializeWithOrderManager:(OrderManager *)anOrderManager
{
    theOrderManager = anOrderManager;
    
    orderRenderer = [[OrderRenderer alloc] initWithOrderManager:theOrderManager];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAltered:) name:ORDER_MANAGER_NEEDS_REDRAW object:theOrderManager];
    
    [[self navigationItem] setTitle:@"Add Items"];
    return self;
}

-(void)renameOrder:(NSString *)newName
{
    [[theOrderManager thisOrder] setName:newName];
}

-(void)displayOrderConfirmation
{
    if([[theOrderManager thisOrder].totalPrice doubleValue] <= 0.0)
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You havn't selected anything to purchase" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to place an empty order"];
        
        [areYouSure show];
        
        return;
    }
    
    if(![delegate locationIsOpen])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"None of the restaurants are open right now. You'll have to wait until they are." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to place order when the restautant isn't open"];
        
        [areYouSure show];
        
        return;
    }
    
    if([delegate hasServerConnection])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Process Purchase?" message:[NSString stringWithFormat: @"Order confirmation:\nSubtotal: %@\nHST: %@\nGrand Total: %@\n\nIs this okay?", [Utilities FormatToPrice:[[theOrderManager thisOrder] subtotalPrice]],[Utilities FormatToPrice:[[theOrderManager thisOrder] taxPrice]],[Utilities FormatToPrice:[[theOrderManager thisOrder] totalPrice]]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        
        [areYouSure setTag:1];
        
        [areYouSure show];
        return;
    }
    
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You appear to have no connection to the internet." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];

    [areYouSure show];
}

-(void)promptUserForRename
{
    if([[theOrderManager thisOrder].totalPrice doubleValue] <= 0.0)
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You havn't selected any items." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [areYouSure show];
        
        return;
    }
    
    
    AlertPrompt *renamePrompt = [[AlertPrompt alloc] initWithPromptTitle:@"Favorite name:" message:@"" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"Okay"];
    
    
    [renamePrompt setTag:2];
    
    [renamePrompt show];
    
    
}

-(void)didPresentAlertView:(UIAlertView *)alertView
{
    if ([alertView tag] == 2) {
        //All this hackery is just to highlight the text by default.
        
        AlertPrompt *renamePrompt = (id)alertView;
        
        NSString *defaultName = [NSString stringWithString:[[theOrderManager thisOrder] defaultFavName]];
        
        [[renamePrompt textField] setText:defaultName];
        
        UITextField* field = [renamePrompt textField];
        
        UITextRange *textRange = [field 
                                  textRangeFromPosition:[field beginningOfDocument] 
                                  toPosition:[field endOfDocument]];
        
        [field setSelectedTextRange:textRange];
    }
}

-(void)promptForFavDeletion
{
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Delete from favorites?" message:[NSString stringWithFormat: @"If you unfavorite this order it will disappear. Are you sure you want that?", [Utilities FormatToPrice:[[theOrderManager thisOrder] totalPrice]]] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [areYouSure setTag:3];
    
    [areYouSure show];
}



//Delegate functions
//***********************************************************


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) // Order Placement
    {
        if (buttonIndex == 1)
        {
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Placed order"];
            
            [delegate submitOrderForController:self];
            [[theOrderManager thisOrder] setStatus:@"Transmitting"];
            [self popToMainPage];
        }
        if (buttonIndex == 2)
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Canceled placing an order"];
    }
    
    if ([alertView tag] == 2) // Order Rename
    {
        if (buttonIndex == 1)
        {
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Renamed order"];
            NSString *entered = [ (AlertPrompt *)alertView enteredText];
            [self renameOrder:entered];
            [delegate addToFavoritesForController:self];
        }
        if (buttonIndex == 2)
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Canceled renaming order"];
    }
    
    if ([alertView tag] == 3) // Delete from favorites
    {
        if (buttonIndex == 1)
        {
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Removed a favorite"];
            [delegate deleteFromFavoritesForController:self];
            [self popToMainPage];
        }
        if (buttonIndex == 2)
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Canceled removing a favorite"];
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id cellObject = [orderRenderer objectForCellAtIndex:indexPath];
    
    if ( [cellObject isKindOfClass:([Menu class])])
    {
        
        MenuViewController *newMenuController = [[MenuViewController alloc] initializeWithMenuAndOrderAndOrderViewController:cellObject :[theOrderManager thisOrder] :self];
        
        if(editing)
            [self exitEditingMode];
        
        [[self navigationController] pushViewController:newMenuController animated:YES];
        
    }
    
    if ( [cellObject isKindOfClass:([Item class])])
    {
        
        ItemViewController *newItemController = [[ItemViewController alloc] initializeWithItemAndOrderAndReturnController:cellObject:[theOrderManager thisOrder] :self];
        
        [[self navigationController] pushViewController:newItemController animated:YES];
        
    }
    
    if ( [cellObject isKindOfClass:([NSDictionary class])])
    {
        
        ItemViewController *newItemController = [[ItemViewController alloc] initializeWithItemAndOrderAndReturnController:[cellObject objectForKey:@"data"]:[theOrderManager thisOrder] :self];
        
        [[self navigationController] pushViewController:newItemController animated:YES];
        
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
    editing = NO;
    orderView = [[OrderView alloc] init];
    [[orderView orderTable] setDelegate:self];
    [[orderView orderTable] setDataSource:orderRenderer];
    
    submitButton = [[UIBarButtonItem alloc] initWithTitle:@"Submit" style:UIBarButtonItemStyleDone target:self action:@selector(displayOrderConfirmation)];
    
    [[self navigationItem] setRightBarButtonItems:[[NSArray alloc] initWithObjects:submitButton, nil]];
    
    [[orderView priceDisplayButton] setTitle:[NSString stringWithFormat:@"%@%@",@"Subtotal: ",[Utilities FormatToPrice:[[theOrderManager thisOrder] subtotalPrice]] ]];
    [[orderView favoriteButton] setTarget:self];
    [[orderView favoriteButton] setAction:@selector(toggleWhetherFavorite)];
    
    [[orderView editButton] setTarget:self];
    [[orderView editButton] setAction:@selector(toggleEditing)];
    
    [self setView:orderView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Opened order page"];
    [super viewWillAppear:animated];
    [self orderAltered:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ( [indexPath section] == 0)
    {
        return 28.0f;
    }
    return 44.0f;
}

-(void)popToMainPage
{
    UIViewController *viewToPopTo = [[[self navigationController] viewControllers] objectAtIndex:0];
    [[self navigationController] popToViewController:viewToPopTo animated:YES];
}

-(void)toggleEditing
{
    if(editing)
    {
        [self exitEditingMode];
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Exited order editing mode"];
    }
    else
    {
        [self enterEditingMode];
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Entered order editing mode"];
    }
    editing = !editing;
}

-(void)enterEditingMode
{
    [[orderView orderTable] setEditing:YES animated:YES];
    
    [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toggleEditing)];

    NSMutableArray *newItemsList = [NSMutableArray arrayWithArray:[[orderView orderToolbar] items]];
    
    [newItemsList replaceObjectAtIndex:0 withObject:doneButton];
    
    [[orderView orderToolbar] setItems:newItemsList animated:YES];
}

-(void)exitEditingMode
{
    [[orderView orderTable] setEditing:NO animated:YES];
    
    UIBarButtonItem *edButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style: UIBarButtonItemStyleBordered target:self action:@selector(toggleEditing)];
    
    NSMutableArray *newItemsList = [NSMutableArray arrayWithArray:[[orderView orderToolbar] items]];
    
    [newItemsList replaceObjectAtIndex:0 withObject:edButton];
    
    [[orderView orderToolbar] setItems:newItemsList animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) toggleWhetherFavorite
{
    if (![theOrderManager thisOrder].isFavorite)
    {
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Favourite Rename Prompt"];
        [self promptUserForRename];
    }
    else
    {
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Favourite Deletion Prompt"];
        [self promptForFavDeletion];
    }
    
}

-(void)orderAltered:(NSNotification *)aNotification
{
    
    [[orderView priceDisplayButton] setTitle:[NSString stringWithFormat:@"%@%@",@"Subtotal: ",[Utilities FormatToPrice:[[theOrderManager thisOrder] subtotalPrice]] ]];
    
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    if([[theOrderManager thisOrder] isFavorite])
    {
        [[orderView favoriteButton] setTintColor:[UIColor yellowColor]];
    }
    else
    {
        [[orderView favoriteButton] setTintColor:[UIColor whiteColor]];
    }

    if([[[theOrderManager thisOrder] itemList] count] == 0)
    {
        [self exitEditingMode];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
