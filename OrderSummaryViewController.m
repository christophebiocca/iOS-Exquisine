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
#import "OrderManagementDelegate.h"
#import "AlertPrompt.h"
#import "OrderManager.h"

@implementation OrderSummaryViewController

@synthesize theOrderManager;
@synthesize delegate;

-(OrderSummaryViewController *)initializeWithOrderManager:(OrderManager *) anOrderManager
{    
    
    theOrderManager = anOrderManager;
    orderSummaryRenderer = [[OrderSummaryRenderer alloc] initWithOrder:[anOrderManager thisOrder]];
    [[self navigationItem] setTitle:[anOrderManager thisOrder].status];
    
    return self;
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
    
    [[orderView favoriteButton] setTarget:self];
    [[orderView favoriteButton] setAction:@selector(toggleWhetherFavorite)];
    
    //pretty hax, but w/e.
    [[orderView orderToolbar] setItems:[NSArray arrayWithObjects:[orderView leftSpacer],[orderView favoriteButton], nil]];
    
    [self setView:orderView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Viewed the order summary"];
    
    [orderSummaryRenderer redraw];
    [[orderView orderTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];

    if([[theOrderManager thisOrder] isFavorite])
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
    return 34.0f;
}

-(void) toggleWhetherFavorite
{
    if (![theOrderManager thisOrder].isFavorite)
    {
        [self promptUserForRename];
    }
    else
    {
        [self promptForFavDeletion];
    }
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    if ([alertView tag] == 2) // Order Rename
    {
        if (buttonIndex == 1)
        {
            NSString *entered = [ (AlertPrompt *)alertView enteredText];
            [self renameOrder:entered];    

            //This is pretty bad form, but I think it'll be ok.. =/
            [delegate addToFavoritesForController:(id)self];
            
            if([[theOrderManager thisOrder] isFavorite])
            {
                [[orderView favoriteButton] setTintColor:[UIColor yellowColor]];
            }
            else
            {
                [[orderView favoriteButton] setTintColor:[UIColor whiteColor]];
            }
        }
    }
    
    if ([alertView tag] == 3) // Order Delete
    {
        if (buttonIndex == 1)
        {
            [delegate deleteFromFavoritesForController:(id)self];
            if([[theOrderManager thisOrder] isFavorite])
            {
                [[orderView favoriteButton] setTintColor:[UIColor yellowColor]];
            }
            else
            {
                [[orderView favoriteButton] setTintColor:[UIColor whiteColor]];
            }
        }
    }
    
}

-(void)popToMainPage
{
    UIViewController *viewToPopTo = [[[self navigationController] viewControllers] objectAtIndex:0];
    [[self navigationController] popToViewController:viewToPopTo animated:YES];
}

-(void)promptUserForRename
{
    
    AlertPrompt *renamePrompt = [[AlertPrompt alloc] initWithPromptTitle:@"Choose a name for your order" message:[theOrderManager thisOrder].name delegate:self cancelButtonTitle:@"Cancel" okButtonTitle:@"OK"];
    [renamePrompt setTag:2];
    
    [renamePrompt show];
}

-(void)promptForFavDeletion
{
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Delete from favorites?" message:[NSString stringWithFormat: @"If you unfavorite this order it will disappear. Are you sure you want that?", [Utilities FormatToPrice:[[theOrderManager thisOrder] totalPrice]]] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    
    [areYouSure setTag:3];
    
    [areYouSure show];
}

-(void)renameOrder:(NSString *)newName
{
    [[theOrderManager thisOrder] setName:newName];
    [[self navigationItem] setTitle:newName];
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

@end
