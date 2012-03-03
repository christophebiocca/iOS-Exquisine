//
//  LocationTabViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-01.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationTabView.h"
#import "LocationState.h"
#import "LocationTabViewController.h"

@implementation LocationTabViewController

- (id)initWithLocationState:(LocationState *) locationState
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        locationTabView = [[LocationTabView alloc] initWithLocationState:locationState AndFrame:CGRectMake(0, 0, 320, 416)];
    }
    return self;
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
    [self setView:locationTabView];
}

@end
