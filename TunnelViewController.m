//
//  TunnelViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TunnelViewController.h"

@implementation TunnelViewController

@synthesize tunnelDelegate;


//Custom functions
//***********************************************************

-(TunnelViewController *)initWithTunnelList:(NSArray *)controllerList
{
    self = [super init];
    
    navController = [[UINavigationController alloc] initWithRootViewController:[controllerList objectAtIndex:0]];
    
    [navController setDelegate:self];
    
    controllerTunnelList = controllerList;
    
    currentListIndexCursor = 0;
    
    tunnelDelegate = nil;
    
    return self;
}

//Delegate functions
//***********************************************************

-(void) signalForwards:(UIViewController *)requester WithContext:(NSArray *)contextInformation
{
    if (currentListIndexCursor == ([controllerTunnelList count] - 1) ) {
        if (tunnelDelegate) {
            [tunnelDelegate lastControllerBeingPushedPast:self];
        }
        else
        {
            NSLog(@"The end of a Tunnel was reached without a delegate being set.");
        }
    }
    else
    {
        currentListIndexCursor++;
        UIViewController *viewToPush = [controllerTunnelList objectAtIndex:currentListIndexCursor];
        
        [navController pushViewController:viewToPush animated:YES];
    }
}

-(void) signalBackwards:(UIViewController *)requester WithContext:(NSArray *)contextInformation
{
    if (currentListIndexCursor == 0) {
        if (tunnelDelegate)
        {
            [tunnelDelegate firstControllerBeingPopped:self];
        }
        else
        {
            NSLog(@"A pop was attempted at the start of a Tunnel that has no defined delegate. O NOES! What do?!?");
        }
    }
    else
    {

        currentListIndexCursor--;
        [navController popViewControllerAnimated:YES];
        
    }
}

//Just to make sure that we stay up-to-date when someone backs out without using signalBackwards.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    currentListIndexCursor = [controllerTunnelList indexOfObject:viewController];
}


//View related functions
//***********************************************************

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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


- (void)loadView
{
    [self setView:[navController view]];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
