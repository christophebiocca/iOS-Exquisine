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
        
        //This is pretty hackish and will have to change if any other buttons get added 
        //I should fix this at some point.
        for (NSArray *eachArray in [itemRenderer listData]) {
            for (id eachThing in eachArray) {
                if ([eachThing isKindOfClass:[UIButton class]]) {
                    [eachThing addTarget:self action:@selector(deleteButtonHit) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        
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
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void) deleteButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:ITEM_DELETE_BUTTON_HIT object:self];
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
