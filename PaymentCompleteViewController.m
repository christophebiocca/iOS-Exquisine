//
//  PaymentCompleteViewController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-02.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentCompleteViewController.h"
#import "PaymentCompletedView.h"

@implementation PaymentCompleteViewController

-(id)initWithDoneCallback:(void(^)())doneCallback;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        done = doneCallback;
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
    [self setView:[[PaymentCompletedView alloc] init]];
}

-(void)setSuccessInfo:(PaymentSuccessInfo *)info{
    successInfo = info;
    [paymentView setSuccessInfo:successInfo];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [[paymentView done] setTarget:self];
    [[paymentView done] setAction:@selector(done)];
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

-(void)done{
    done();
}

@end
