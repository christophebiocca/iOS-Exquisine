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
#import "LargeScopeControllerDelegate.h"

@implementation OptionViewController

@synthesize optionInfo;

-(OptionViewController *)initializeWithOption:(Option *) anOption
{
    tunnelVersion = NO;
    optionInfo = anOption;
    optionRenderer = [[OptionRenderer alloc] initWithOption:anOption];
    [[self navigationItem] setTitle:anOption.name];
    
    return self;
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    if ([indexPath row] < ([[optionInfo choiceList] count])) {
        [optionInfo toggleChoiceByIndex:[indexPath row]];
        [optionRenderer redraw];
        [[optionView optionTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
        
        //if exactly one item must be selected, we'll signal our potential delegate.
        if (([optionInfo upperBound] == 1)&&([optionInfo lowerBound] == 1))
        {
            [superviewDelegate signalForwards:self WithContext:nil];
        }
    }
}

-(void) forwardButtonClicked
{
    [superviewDelegate signalForwards:self WithContext:nil];
}

-(void)setSuperviewDelegate:(id<LargeScopeControllerDelegate>)superviewDelegateIn
{
    superviewDelegate = superviewDelegateIn;
    tunnelVersion = YES;
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
    
    if (tunnelVersion && ([optionInfo upperBound] > 1 ) ) {
        forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(forwardButtonClicked)];
        [[self navigationItem] setRightBarButtonItem:forwardButton];
    }
    [self setView:optionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [optionRenderer redraw];
    [[optionView optionTable] reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
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
