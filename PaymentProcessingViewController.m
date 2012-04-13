//
//  PaymentProcessingViewController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentProcessingViewController.h"
#import "PaymentProcessingView.h"

@implementation PaymentProcessingViewController

-(UINavigationItem*)navigationItem{
    UINavigationItem* item = [[UINavigationItem alloc] initWithTitle:@"Processing"];
    [item setHidesBackButton:YES];
    return item;
}

-(id)init{
    if(self = [super initWithNibName:nil bundle:nil]){
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
    [self setView:[[PaymentProcessingView alloc] init]];
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
