//
//  PaymentFailureViewController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentFailureViewController.h"
#import "PaymentFailureView.h"
#import "PaymentError.h"

@implementation PaymentFailureViewController

@synthesize cancelCallback;

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)setMessage{
    if(failureInfo && failureView){
#ifdef DEBUG
        [failureView setErrorMessage:[NSString stringWithFormat:
                                      @"The server seems to be unresponsive, and we are unable to process your order at this time. Your credit card was not charged. DEBUG INFO:(%@)", failureInfo]];
#else
        [failureView setErrorMessage:[NSString stringWithFormat:
                                      @"The server seems to be unresponsive, and we are unable to process your order at this time. Your credit card was not charged."]];
#endif
    }
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    failureView = [[PaymentFailureView alloc] initWithFrame:CGRectZero];
    [self setView: failureView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMessage];
    [[failureView cancel] setAction:@selector(cancelled)];
    [[failureView cancel] setTarget:self];
}

-(void)cancelled{
    cancelCallback();
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

-(void)setError:(NSError*)error{
    failureInfo = error;
    [self setMessage];
}

@end
