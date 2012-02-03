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

- (id)initWithCompletionBlock:(void(^)(PaymentInfo*))completion 
            cancellationBlock:(void(^)())cancelled
{
    if (self = [super init]) {
        completionBlock = [completion copy];
        cancelledBlock = [cancelled copy];
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
    paymentView = [[PaymentView alloc] init];
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
