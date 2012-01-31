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

@implementation PaymentInfoViewController

- (id)initWithCompletionBlock:(void(^)(PaymentInfo*))completion 
            cancellationBlock:(void(^)())cancelled
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
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
    UIBarButtonItem* done = [paymentView done];
    [done setTarget:self];
    [done setAction:@selector(doneEntering)];
    UIBarButtonItem* cancel = [paymentView cancel];
    [cancel setTarget:self];
    [cancel setAction:@selector(cancelled)];
}

-(void)doneEntering{
    completionBlock([paymentView paymentInfo]);
}

-(void)cancelled{
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

@end