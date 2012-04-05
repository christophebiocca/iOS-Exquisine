//
//  ShinyItemGroupViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyItemGroupViewController.h"
#import "ShinyItemGroupRenderer.h"
#import "ShinyItemGroupView.h"
#import "ShinyComboItemViewController.h"
#import "ExpandableCell.h"
#import "Item.h"
#import "ItemGroup.h"

@implementation ShinyItemGroupViewController

@synthesize theItemGroup;

-(id)initWithItemGroup:(ItemGroup *)anItemGroup
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theItemGroup = anItemGroup;
        itemGroupView = [[ShinyItemGroupView alloc] init];
        itemGroupRenderer = [[ShinyItemGroupRenderer alloc] initWithItemGroup:theItemGroup];
        
        [[itemGroupView itemGroupTable] setDelegate:self];
        [[itemGroupView itemGroupTable] setDataSource:itemGroupRenderer];
        
    }
    return self;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[CustomViewCell cellIdentifierForData:[itemGroupRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyMenuItemCell"])
    {
        Item *theItem = [[itemGroupRenderer objectForCellAtIndex:indexPath] objectForKey:@"menuItem"];        
        if (([[theItem options] count] > 0)||![[theItem desc] isEqualToString:@""]) 
        {
            ShinyComboItemViewController *newController = [[ShinyComboItemViewController alloc] initWithItem:theItem];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addItemButtonHit:) name:ITEM_DONE_BUTTON_HIT object:newController];
            [[self navigationController] pushViewController:newController animated:YES];
            return;
        }
        else 
        {
            [theItemGroup setSatisfyingItem:theItem];
            [[self navigationController] popViewControllerAnimated:YES];
        }    
    }
    else if ([[tableView cellForRowAtIndexPath:indexPath] isKindOfClass:[ExpandableCell class]])
    {
        [(ExpandableCell *)[tableView cellForRowAtIndexPath:indexPath] toggleOpen:indexPath :tableView];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[itemGroupRenderer objectForCellAtIndex:indexPath]];
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
    
    
    UIBarButtonItem *fillerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    [fillerButton setCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 21)]];
    [[self navigationItem] setRightBarButtonItem:fillerButton];
    
    [self setView:itemGroupView];
}

-(void) addItemButtonHit:(NSNotification *) aNotification
{
    [theItemGroup setSatisfyingItem:[(ShinyMenuItemViewController *)[aNotification object] theItem]];
    NSMutableArray *newControllerStack = [[NSMutableArray alloc] initWithCapacity:0];
    for (UIViewController *eachController in [[self navigationController] viewControllers]) {
        if (eachController == self) {
            break;
        }
        else {
            [newControllerStack addObject:eachController];
        }
    }
    [[self navigationController] setViewControllers:newControllerStack animated:YES];
    
}

-(void) backButtonHit
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
    
    [toolbarText setText:[theItemGroup name]];
    [toolbarText setAdjustsFontSizeToFitWidth:YES];
    
    [[self navigationItem] setTitleView:toolbarText];

}

-(void)dealloc
{
    //[[NSNotificationCenter defaultCenter] removeObject:self];
}

@end
