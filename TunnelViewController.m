//
//  TunnelViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TunnelViewController.h"
#import "OptionViewController.h"

@implementation TunnelViewController

@synthesize tunnelDelegate, navController;


//Custom functions
//***********************************************************

-(TunnelViewController *)initWithTunnelList:(NSArray *)controllerList
{
    self = [super init];
    
    navController = [[UINavigationController alloc] initWithRootViewController:[controllerList objectAtIndex:0]];
    
    [navController setDelegate:self];
    
    controllerTunnelList = controllerList;
    
    for (OptionViewController *currentOptionController in controllerList) {
        [currentOptionController setSuperviewDelegate:self];
    }
    
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
            CLLog(LOG_LEVEL_WARNING,@"The end of a Tunnel was reached without a delegate being set.");
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
            CLLog(LOG_LEVEL_WARNING, @"A pop was attempted at the start of a Tunnel that has no defined delegate. O NOES! What do?!?");
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

@end
