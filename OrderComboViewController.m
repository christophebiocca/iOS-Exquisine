//
//  OrderComboViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-06.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderComboViewController.h"

@implementation OrderComboViewController

-(void)comboChanged:(NSNotification *)aNotification
{
    [super comboChanged:aNotification];
    
    [[self navigationItem] setRightBarButtonItem:nil];
}

@end
