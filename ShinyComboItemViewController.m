//
//  ShinyComboItemViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyComboItemViewController.h"
#import "ShinyComboItemRenderer.h"

@implementation ShinyComboItemViewController

-(id)initWithItem:(Item *)anItem
{
    self = [super init];
    if (self) 
    {
        theItem = anItem;
        renderer = [[ShinyComboItemRenderer alloc] initWithItem:theItem];
        [theTableView setDataSource:renderer];
        
    }
    return self;
}

-(void)loadView
{
    [super loadView];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

@end
