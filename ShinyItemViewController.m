//
//  ShinyItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemViewController.h"
#import "Item.h"
#import "Option.h"
#import "ShinyItemView.h"
#import "Choice.h"
#import "ShinyItemRenderer.h"
#import "ShinyChoiceCell.h"

NSString* ITEM_DONE_BUTTON_HIT = @"CroutonLabs/ItemDoneButtonHit";

@implementation ShinyItemViewController

@synthesize theItem;

-(id)initWithItem:(Item *)anItem
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theItem = anItem;
        itemView = [[ShinyItemView alloc] init];
        itemRenderer = [[ShinyItemRenderer alloc] initWithItem:theItem];
        
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
    
    if ([[CustomViewCell cellIdentifierForData:[itemRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ClosedShinyOptionCell"])
    {
        Option *theOption = [[itemRenderer objectForCellAtIndex:indexPath] objectForKey:@"closedOption"];
        [[[itemRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:[indexPath row]];
        
        NSMutableDictionary *helperDict = nil;
        
        helperDict = [NSMutableDictionary dictionary];
        [helperDict setObject:theOption forKey:@"openOption"];
        
        [[[itemRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:[indexPath row]];
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSMutableArray *helperArray = [[NSMutableArray alloc] init];
        
        for (int i=1; i<[[theOption choiceList] count] + 1; i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section];
            [helperArray addObject:tmpIndexPath];
        }
        
        int i = [indexPath row] + 1;
        
        for (Choice *eachChoice in [theOption choiceList]) {
            
            helperDict = [NSMutableDictionary dictionary];
            
            [helperDict setObject:eachChoice forKey:@"choice"];
            
            [[[itemRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:i];
            i++;
        }
        
        [tableView insertRowsAtIndexPaths:helperArray withRowAnimation:UITableViewRowAnimationTop];
    }
    else if ([[CustomViewCell cellIdentifierForData:[itemRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"OpenShinyOptionCell"])
    {
        Option *theOption = [[itemRenderer objectForCellAtIndex:indexPath] objectForKey:@"openOption"];
        [[[itemRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:[indexPath row]];
        
        NSMutableDictionary *helperDict = nil;
        
        helperDict = [NSMutableDictionary dictionary];
        [helperDict setObject:theOption forKey:@"closedOption"];
        
        [[[itemRenderer listData] objectAtIndex:[indexPath section]] insertObject:helperDict atIndex:[indexPath row]];
        
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        NSMutableArray *helperArray = [[NSMutableArray alloc] init];
        
        for (int i=1; i<([[theOption choiceList] count] + 1); i++)
        {
            NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:(indexPath.row + i) inSection:indexPath.section];
            [helperArray addObject:tmpIndexPath];
        }
        
        int i = [indexPath row] + 1;
        
        for (Choice *eachChoice in [theOption choiceList]) {
            
            [[[itemRenderer listData] objectAtIndex:[indexPath section]] removeObjectAtIndex:i];
        }
        
        [tableView deleteRowsAtIndexPaths:helperArray withRowAnimation:UITableViewRowAnimationTop];
    }
    else if ([[CustomViewCell cellIdentifierForData:[itemRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyChoiceCell"])
    {
        Choice *theChoice = [[itemRenderer objectForCellAtIndex:indexPath] objectForKey:@"choice"];
        [theChoice toggleSelected];
        [(ShinyChoiceCell *)[tableView cellForRowAtIndexPath:indexPath] pulseView];
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

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)loadView
{
    [super loadView];
    [[self navigationItem] setHidesBackButton:YES];
    
    //Set this as the back button
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(backButtonHit)];
    [backButton setTintColor:[Utilities fravicDarkRedColor]];
    
    [[self navigationItem] setLeftBarButtonItem:backButton];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonHit)];
    
    [[self navigationItem] setRightBarButtonItem:doneButton];
    
    [self setView:itemView];
}

-(void) backButtonHit
{
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void) doneButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_DONE_BUTTON_HIT object:self];
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

-(void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObject:self];
}

@end
