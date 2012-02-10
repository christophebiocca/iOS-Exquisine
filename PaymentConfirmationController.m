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
    UIBarButtonItem* confirm = [paymentView confirm];
    [confirm setTarget:self];
    [confirm setAction:@selector(confirm)];
    UIBarButtonItem* cancel = [paymentView cancel];
    [cancel setTarget:self];
    [cancel setAction:@selector(cancel)];
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

@end
