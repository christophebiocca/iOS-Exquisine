//
//  PaymentInfoViewController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentInfoViewController.h"
#import "PaymentView.h"
#import "PaymentInfo.h"
#import "PaymentError.h"
#import "GetLocations.h"

@implementation PaymentInfoViewController

@synthesize completionBlock, cancelledBlock;
@synthesize paymentView;

- (id)init
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        paymentView = [[PaymentView alloc] init];
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
    [self setView:paymentView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [paymentView setDelegate:self];
}

-(void)paymentDone{
    completionBlock([paymentView paymentInfo]);
}

-(void)paymentCancelled{
    cancelledBlock();
}

-(void)viewWillAppear:(BOOL)animated
{
    navigationBarWasHidden = [[[self navigationController] navigationBar] isHidden];
    [[[self navigationController] navigationBar] setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setHidden:navigationBarWasHidden];
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

-(void)setError:(PaymentError*)error{
    [paymentView setErrorMessage:[error userMessage]];
}

@end
