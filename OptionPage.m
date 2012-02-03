//
//  OptionPage.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Option.h"
#import "OptionPage.h"
#import "OptionPageView.h"
#import "ConfigurableTableViewDataSource.h"
#import "ItemPage.h"
#import "Utilities.h"

#import "CellData.h"

@implementation OptionPage

@synthesize currentOption;

-(void)ConfigureUITableViewCell: (UITableViewCell *) newCell
{
    NSLog(@"I got Called!");
}

//Custom functions
//***********************************************************

-(void)initializeViewWithOption:(Option *)anOption{
    
    CellData *newCellData = [[CellData alloc] initWithOwner:self];
    [newCellData configureCell:[[UITableViewCell alloc] init]];
    
    currentOption = anOption;
    NSMutableArray *cellDataList;
    cellDataList = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (Choice *currentChoice in anOption.choiceList) {
        
        CellInfo *newCell = [[CellInfo alloc] init];
        //newCell.labelText = currentChoice.name;
        //newCell.descriptionText = [Utilities FormatToPrice:[currentChoice effectivePriceCents]];
        newCell.hasSwitch = YES;
        //newCell.switchState = currentChoice.selected;
        [cellDataList addObject:newCell];
        
    }
    
    CellInfo *newCell = [[CellInfo alloc] init];
    newCell.labelText = @"Total:";
    newCell.descriptionText = [Utilities FormatToPrice:[currentOption price]];
    [cellDataList addObject:newCell];
    
    [[self navigationItem] setTitle:currentOption.name];
    
    optionTableDataSource.displayList = cellDataList;
    
}


//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < [currentOption.choiceList count]){
        
        //deselect the cell
        [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
        
        [currentOption toggleChoiceByIndex:indexPath.row];
        
        [self initializeViewWithOption:currentOption];
        
        [tableView reloadData];
        
    }
}


//View related functions
//***********************************************************

-(void)viewDidLoad{
    [super viewDidLoad];
    
    optionTableDataSource = [[ConfigurableTableViewDataSource alloc] init]; 
    
    [[optionPageView optionTable] setDelegate:self];
    [[optionPageView optionTable] setDataSource:optionTableDataSource];
    
    [self initializeViewWithOption:currentOption];
    
}

- (id)init{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [[self navigationItem] setTitle:currentOption.name];
    }
    return self;
}

#pragma mark - View lifecycle

- (void) loadView
{
    optionPageView = [[OptionPageView alloc] init];
    [self setView:optionPageView];
}



//Other Junk
//***********************************************************



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


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
