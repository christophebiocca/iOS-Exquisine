//
//  PaymentConfirmationController.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-02-09.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentConfirmationController.h"
#import "PaymentConfirmationRenderer.h"

@implementation PaymentConfirmationController

@synthesize acceptBlock, changeBlock, cancelBlock;

-(id)initWithPaymentInfo:(PaymentProfileInfo *)profile andOrder:(Order *)anOrder
{
    self = [super init];
    if (self)
    {
        theOrder = anOrder;
        paymentProfile = profile;
        renderer = [[PaymentConfirmationRenderer alloc] init];
        [theTableView setDataSource:renderer];
    }
    return self;
}

-(UINavigationItem*)navigationItem {
    UIBarButtonItem* cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel 
                                                                            target:self
                                                                            action:@selector(cancel)];
    UINavigationItem* nav = [[UINavigationItem alloc] initWithTitle:@"Confirm Payment"];
    [nav setLeftBarButtonItem:cancel];
    return nav;
}

-(void)setPaymentInfo:(PaymentProfileInfo *)payment
{
    paymentProfile = payment;
    (void)[(PaymentConfirmationRenderer *)renderer initWithPaymentInfo:paymentProfile andOrder:theOrder];
    [theTableView reloadData];
}

-(void)ShinyPaymentViewCellHandler:(NSIndexPath *)indexPath
{
    [self confirm];
}

-(void)ShinySettingsCellHandler:(NSIndexPath *)indexPath
{
    if ([[[renderer objectForCellAtIndex:indexPath] objectForKey:@"settingTitle"] isEqualToString:@"Different Card"]) {
        [self change];
    }
    else if ([[[renderer objectForCellAtIndex:indexPath] objectForKey:@"settingTitle"] isEqualToString:@"Input Promo Code"]) {
        [[[UIAlertView alloc] initWithTitle:@"A promo code?" message:@"Why, certianly sir." delegate:self cancelButtonTitle:@"blarg" otherButtonTitles:nil] show];
    }
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
