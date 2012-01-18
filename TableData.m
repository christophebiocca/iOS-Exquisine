//
//  TableData.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TableData.h"
#import "CellData.h"
#import "MenuComponent.h"

@implementation TableData

@synthesize tableName;
@synthesize cellDataList;


/* 
 **************************************************************************
 *
 *      Custom Class Functions
 *
 **************************************************************************
*/

-(TableData *)initWithNavigationController:(UINavigationController *)aController
{
    self = [super initWithNibName:nil bundle:nil];
    
    if (self) {
        tableName = nil;
        cellDataList = [[NSMutableArray alloc] initWithCapacity:0];
        controller = aController;
    }    
    
    return self;
}

-(UITableView *)synthesizeUITableView
{
    if ([dataOwner respondsToSelector:_cmd])
    {
        return [dataOwner synthesizeUITableView];
    }

    
    UITableView *newTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, 320, 460)];
    [newTableView setDelegate:self];
    [newTableView setDataSource:self];
    return newTableView;
}

/* 
 **************************************************************************
 *
 *      Delegate/Data Source Functions
 *
 **************************************************************************
 */

-(void) loadView
{
    [[self navigationItem] setTitle:tableName];
    currentTableView = [self synthesizeUITableView];
    [self setView:currentTableView];
}

-(void) viewDidLoad
{
    [super viewDidLoad];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dataOwner respondsToSelector:_cmd])
    {
        return [dataOwner tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Because we can be sure that the members of the cellDataList are, in fact,
    // of type CellData, we can call ConfigureUITableViewCell on them so that they
    // can manage themselves.
    [[cellDataList objectAtIndex:[indexPath row]] configureCell:cell];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // For now there will always be exactly one section. I may change this later, but thats ok.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [cellDataList count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([dataOwner respondsToSelector:_cmd])
    {
        return [dataOwner tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    // By default, do nothing. This can be overridden.
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
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
