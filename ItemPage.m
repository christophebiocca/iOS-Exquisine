//
//  ItemPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemPage.h"
#import "Item.h"
#import "ItemPageView.h"
#import "ConfigurableTableViewDataSource.h"
#import "Option.h"
#import "OptionPage.h"
#import "Utilities.h"

@implementation ItemPage

@synthesize currentItem;

//Custom functions
//***********************************************************

-(void)initializeViewWithItem:(Item *)anItem{
    
    currentItem = anItem;
    NSMutableArray *cellDataList;
    cellDataList = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (Option *currentOption in anItem.options) {
        
        CellInfo *newCell = [[CellInfo alloc] init];
        newCell.labelText = currentOption.name;
        newCell.descriptionText = [Utilities FormatToPrice:[currentOption totalPrice]];        
        [cellDataList addObject:newCell];
        
    }
    
    CellInfo *newCell = [[CellInfo alloc] init];
    newCell.labelText = @"Base Price:";
    newCell.descriptionText = [Utilities FormatToPrice:[currentItem basePriceCents]];        
    [cellDataList addObject:newCell];
    
    CellInfo *secondNewCell = [[CellInfo alloc] init];
    secondNewCell.labelText = @"Total Item Price:";
    secondNewCell.descriptionText = [Utilities FormatToPrice:[currentItem totalPrice]];        
    [cellDataList addObject:secondNewCell];
    
    [[self navigationItem] setTitle:currentItem.name];    
    itemTableDataSource.displayList = cellDataList;
    
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([indexPath row] < [[currentItem options] count]) {
        OptionPage *optionPage = [[OptionPage alloc] init];
        [optionPage initializeViewWithOption:[[currentItem options] objectAtIndex:[indexPath row]]];
        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        [[super navigationController] pushViewController:optionPage animated:YES];
    }
    
}

//Builtin Functions
//***********************************************************

- (id)init{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self navigationItem] setTitle:currentItem.name];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    itemPageView = [[ItemPageView alloc] init];
    [self setView:itemPageView];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    itemTableDataSource = [[ConfigurableTableViewDataSource alloc] init];
    
    [[itemPageView itemTable] setDelegate:self];
    [[itemPageView itemTable] setDataSource:itemTableDataSource];
    
    [self initializeViewWithItem: currentItem];    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initializeViewWithItem:currentItem];
    [[itemPageView itemTable] reloadData];
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
