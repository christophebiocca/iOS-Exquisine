//
//  PaymentConfirmationController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentConfirmationController.h"
#import "PaymentConfirmationView.h"

@implementation PaymentConfirmationController

@synthesize acceptBlock, changeBlock, cancelBlock, ccDigits;

-(UINavigationItem*)navigationItem {
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                            target:self
                                                                            action:@selector(cancel)];
    UIBarButtonItem* confirm = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone 
                                                                             target:self 
                                                                             action:@selector(confirm)];
    UINavigationItem* nav = [[UINavigationItem alloc] initWithTitle:@"Confirm Payment"];
    [nav setLeftBarButtonItem:cancel];
    [nav setRightBarButtonItem:confirm];
    return nav;
}

-(id)init{
    if(self = [super initWithNibName:nil bundle:nil]){
    }
    return self;
}

-(void)loadView{
    paymentView = [[PaymentConfirmationView alloc] initWithCCDigits:ccDigits];
    [self setView:paymentView];
}

-(void)viewDidLoad{
    [[paymentView change] addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
}

-(void)confirm{
    acceptBlock();
}

-(void)cancel{
    cancelBlock();
}

-(void)change{
    changeBlock();
}

-(void)setCcDigits:(NSString*)digits{
    ccDigits = digits;
    [paymentView setCCDigits:digits];
}

@end
