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
#import "LocalyticsSession.h"

@implementation OrderViewController

@synthesize orderInfo;
@synthesize delegate;

-(OrderViewController *)initializeWithMenuAndOrder:(Menu *) aMenu:(Order *) anOrder
{
    menuInfo = aMenu;
    orderInfo = anOrder;
    
    [menuInfo setAssociatedOrder:anOrder];
    orderRenderer = [[OrderRenderer alloc] initWithOrderAndMenu:orderInfo:menuInfo];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAltered:) name:ORDER_ITEMS_MODIFIED object:orderInfo];
    
    [[self navigationItem] setTitle:@"Add Items"];
    return self;
}

-(void)renameOrder:(NSString *)newName
{
    [orderInfo setName:newName];
}

-(void)displayOrderConfirmation
{
    if([orderInfo.totalPrice doubleValue] <= 0.0)
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You havn't selected anything to purchase" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [areYouSure show];
        
        return;
    }
    
    if(![delegate locationIsOpen])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"The restaurant isn't open right now. You'll have to wait until it is." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [areYouSure show];
        
        return;
    }
    
    if([delegate hasServerConnection])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Process Purchase?" message:[NSString stringWithFormat: @"Order confirmation:\nSubtotal: %@\nHST: %@\nGrand Total: %@\n\nIs this okay?", [Utilities FormatToPrice:[orderInfo subtotalPrice]],[Utilities FormatToPrice:[orderInfo taxPrice]],[Utilities FormatToPrice:[orderInfo totalPrice]]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        
        [areYouSure setTag:1];
        
        [areYouSure show];
        return;
    }
    
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You appear to have no connection to the internet." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];

    [areYouSure show];
}

-(void)promptUserForRename
{
    if([[orderInfo itemList] count] == 0)
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You havn't selected any items." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [areYouSure show];
        
        return;
    }
    
    
    AlertPrompt *renamePrompt = [[AlertPrompt alloc] initWithPromptTitle:@"Choose a name for your order" message:@"a" delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"OK"];
    
    
    [renamePrompt setTag:2];
    
    [renamePrompt show];
    
    
}

-(void)didPresentAlertView:(UIAlertView *)alertView
{
    if ([alertView tag] == 2) {
        //All this hackery is just to highlight the text by default.
        
        AlertPrompt *renamePrompt = (id)alertView;
        
        NSString *defaultName = [NSString stringWithString:[orderInfo defaultFavName]];
        
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
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Delete from favorites?" message:[NSString stringWithFormat: @"If you unfavorite this order it will dissapear. Are you sure you want that?", [Utilities FormatToPrice:[orderInfo totalPrice]]] delegate:self cancelButtonTitle:@"Oh... nevermind" otherButtonTitles:@"Yep", nil];
    
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
            [delegate submitOrderForController:self];
            [orderInfo setStatus:@"Transmitting"];
            [self popToMainPage];
        }
    }
    
    if ([alertView tag] == 2) // Order Rename
    {
        if (buttonIndex == 1)
        {
            NSString *entered = [ (AlertPrompt *)alertView enteredText];
            [self renameOrder:entered];
            [delegate addToFavoritesForController:self];
        }
    }
    
    if ([alertView tag] == 3) // Delete from favorites
    {
        if (buttonIndex == 1)
        {
            [delegate deleteFromFavoritesForController:self];
            [self popToMainPage];
        }
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    id cellObject = [orderRenderer objectForCellAtIndex:indexPath];
    
    if ( [cellObject isKindOfClass:([Menu class])])
    {
        
        MenuViewController *newMenuController = [[MenuViewController alloc] initializeWithMenuAndOrderAndOrderViewController:cellObject :orderInfo :self];
        
        if(editing)
            [self exitEditingMode];
        
        [[self navigationController] pushViewController:newMenuController animated:YES];
        
    }
    
    if ( [cellObject isKindOfClass:([Item class])])
    {
        
        ItemViewController *newItemController = [[ItemViewController alloc] initializeWithItemAndOrderAndReturnController:cellObject :orderInfo :self];
        
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
    
    [[orderView priceDisplayButton] setTitle:[NSString stringWithFormat:@"%@%@",@"Subtotal: ",[Utilities FormatToPrice:[orderInfo subtotalPrice]] ]];
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
    [super viewWillAppear:animated];
    
    [[orderView priceDisplayButton] setTitle:[NSString stringWithFormat:@"%@%@",@"Subtotal: ",[Utilities FormatToPrice:[orderInfo subtotalPrice]] ]];
    [orderRenderer refreshOrderList];
    
    [menuInfo setAssociatedOrder:orderInfo];
    [orderInfo setParentMenu:menuInfo];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orderAltered:) name:ORDER_ITEMS_MODIFIED object:orderInfo];
    
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
    if([orderInfo isFavorite])
    {
        [[orderView favoriteButton] setTintColor:[UIColor yellowColor]];
    }
    else
    {
        [[orderView favoriteButton] setTintColor:[UIColor whiteColor]];
    }
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
    if (!orderInfo.isFavorite)
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
    
    [[orderView priceDisplayButton] setTitle:[NSString stringWithFormat:@"%@%@",@"Subtotal: ",[Utilities FormatToPrice:[orderInfo subtotalPrice]] ]];
    
    [orderRenderer refreshOrderList];
    
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    
    [[orderView orderTable] scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    if([orderInfo isFavorite])
    {
        [[orderView favoriteButton] setTintColor:[UIColor yellowColor]];
    }
    else
    {
        [[orderView favoriteButton] setTintColor:[UIColor whiteColor]];
    }

    if([[orderInfo itemList] count] == 0)
    {
        [self exitEditingMode];
    }
}

@end
