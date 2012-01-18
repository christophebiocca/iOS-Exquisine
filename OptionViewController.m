//
//  OptionViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-17.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OptionViewController.h"
#import "Option.h"
#import "OptionView.h"
#import "OptionRenderer.h"

@implementation OptionViewController

@synthesize optionInfo;

-(OptionViewController *)initializeWithOption:(Option *) anOption
{
    
    optionInfo = anOption;
    optionRenderer = [[OptionRenderer alloc] initWithOption:anOption];
    [[self navigationItem] setTitle:anOption.name];
    
    return self;
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < [[optionInfo choiceList] count]) {
        //Make and push the option view controller
    }
    
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
    optionView = [[OptionView alloc] init];
    [[optionView optionTable] setDelegate:self];
    [[optionView optionTable] setDataSource:optionRenderer];
    [self setView:optionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [optionRenderer redraw];
    [[optionView optionTable] reloadData];
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
