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

-(UINavigationItem*)navigationItem{
    UINavigationItem* nav = [[UINavigationItem alloc] initWithTitle:@"Payment Info"];
    UIBarButtonItem* done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                          target:self 
                                                                          action:@selector(done)];
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                            target:self 
                                                                            action:@selector(cancel)];
    [nav setLeftBarButtonItem:cancel];
    [nav setRightBarButtonItem:done];
    return nav;
}

- (id)init
{
    if (self = [super initWithNibName:nil bundle:nil]) {
        info = [[PaymentInfo alloc] init];
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
    [[paymentView cardholderNameField] setDelegate:self];
    [[paymentView cardnumberField] setDelegate:self];
    [[paymentView remember] setOn:[info remember]];
    [[paymentView remember] addTarget:self action:@selector(rememberChanged:) 
                     forControlEvents:UIControlEventValueChanged];
    [[paymentView expirationMonth] setDelegate:self];
    [[paymentView expirationYear] setDelegate:self];
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

-(void)flushCardholderName{
    [info setCardholderName:[[paymentView cardholderNameField] text]];
    [paymentView setErrorMessage:[info cardholderNameError]
                    onErrorLabel:[paymentView cardholderNameErrorLabel]];
}

-(void)flushCardnumber{
    [info setCardnumber:[[paymentView cardnumberField] text]];
    [paymentView setErrorMessage:[info cardnumberError]
                    onErrorLabel:[paymentView cardnumberErrorLabel]];
}

-(void)flushExpirationMonth{
    [info setExpirationMonth:[[paymentView expirationMonth] text]];
    [paymentView setErrorMessage:[info expirationError]
                    onErrorLabel:[paymentView expirationErrorLabel]];
}

-(void)flushExpirationYear{
    if ([[[paymentView expirationYear] text] length] == 2) {
        [info setExpirationYear:[NSString stringWithFormat:@"20%@",[[paymentView expirationYear] text]]];
    }
    else {
        [info setExpirationYear:[[paymentView expirationYear] text]];
    }
    
    [paymentView setErrorMessage:[info expirationError]
                    onErrorLabel:[paymentView expirationErrorLabel]];
}

-(void)rememberChanged:(UISwitch*)remember{
    [info setRemember:[remember isOn]];
}

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    if(textField == [paymentView cardholderNameField]){
        [self flushCardholderName];
        [[paymentView cardnumberField] becomeFirstResponder];
    } else if(textField == [paymentView cardnumberField]) {
        [self flushCardnumber];
        [[paymentView expirationMonth] becomeFirstResponder];
    } else if(textField == [paymentView expirationMonth]) {
        [[paymentView expirationYear] becomeFirstResponder];
        [self flushExpirationMonth];
    } else if(textField == [paymentView expirationYear]) {
        [self flushExpirationYear];
    } else {
        NSAssert(NO, @"Got a message from a random text field!");
    }
    return NO;
}

-(void)textFieldDidEndEditing:(UITextField*)textField{
    if(textField == [paymentView cardholderNameField]){
        [self flushCardholderName];
    } else if(textField == [paymentView cardnumberField]){
        [self flushCardnumber];
    } else if(textField == [paymentView expirationMonth]){
        [self flushExpirationMonth];
    } else if(textField == [paymentView expirationYear]){
        [self flushExpirationYear];
    } else {
        NSAssert(NO, @"Got a message from a random text field (%@) !", textField);
    }
}

-(void)textFieldDidBeginEditing:(UITextField*)textField{
    if(textField == [paymentView cardholderNameField]){
        [paymentView setErrorMessage:nil
                        onErrorLabel:[paymentView cardholderNameErrorLabel]];
    } else if(textField == [paymentView cardnumberField]){
        [paymentView setErrorMessage:nil
                        onErrorLabel:[paymentView cardnumberErrorLabel]];
    } else if(textField == [paymentView expirationMonth]){
        [paymentView setErrorMessage:nil
                        onErrorLabel:[paymentView expirationErrorLabel]];
    } else if(textField == [paymentView expirationYear]){
        [paymentView setErrorMessage:nil
                        onErrorLabel:[paymentView expirationErrorLabel]];
    } else {
        NSAssert(NO, @"Got a message from a random text field (%@) !", textField);
    }
}

-(BOOL)textField:(UITextField*)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSInteger finalSize = [[textField text] length] + [string length] - range.length;
    if(textField == [paymentView cardnumberField] && finalSize >= 16){
        [[paymentView expirationMonth] performSelectorOnMainThread:@selector(becomeFirstResponder) 
                                                        withObject:nil 
                                                     waitUntilDone:NO];
    } else if(textField == [paymentView expirationMonth] && finalSize >= 2){
        [[paymentView expirationYear] performSelectorOnMainThread:@selector(becomeFirstResponder) 
                                                       withObject:nil 
                                                    waitUntilDone:NO];
    }
    return YES;
}

#pragma mark buttons

-(void)done{
    [[paymentView cardholderNameField] resignFirstResponder];
    [[paymentView cardnumberField] resignFirstResponder];
    [[paymentView expirationMonth] resignFirstResponder];
    [[paymentView expirationYear] resignFirstResponder];
    [self flushCardholderName];
    [self flushCardnumber];
    [self flushExpirationYear];
    [self flushExpirationMonth];
    if(![info anyErrors]){
        completionBlock(info);
    }
}

-(void)cancel{
    cancelledBlock();
}

@end
