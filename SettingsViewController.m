//
//  SettingsViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsView.h"
#import "SettingsRenderer.h"
#import "LocationState.h"
#import "LocationViewController.h"
#import "PaymentSettingsViewController.h"

@implementation SettingsViewController

-(id) initWithLocationState:(LocationState *)locationState
{
    self = [super init];
    
    if(self)
    {
        theLocationState = locationState;
        settingsView = [[SettingsView alloc] init];
        settingsRenderer = [[SettingsRenderer alloc] init];
        
        [[settingsView settingsTable] setDelegate:self];
        [[settingsView settingsTable] setDataSource:settingsRenderer];
        
        [[self navigationItem] setTitle:@"Settings"];
    }
    
    return self;
}

//Delegate functions
//***********************************************************

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[tableView cellForRowAtIndexPath:indexPath] setSelected:NO];
    
    switch ([indexPath row]) {
        case 0:
        {
            LocationViewController *controller = [[LocationViewController alloc] initWithLocationState:theLocationState];
            [[self navigationController] pushViewController:controller animated:YES];
            break;
        }
        case 1:
        {
            PaymentSettingsViewController *controller = [[PaymentSettingsViewController alloc] init];
            [[self navigationController] pushViewController:controller animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) loadView
{
    [self setView:settingsView];
}
@end
