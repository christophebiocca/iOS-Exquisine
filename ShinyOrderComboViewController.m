//
//  ShinyOrderComboViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyOrderComboViewController.h"
#import "ShinyOrderComboRenderer.h"
#import "ShinyComboView.h"

NSString* COMBO_DELETE_BUTTON_HIT = @"CroutonLabs/ComboDeleteButtonHit";

@implementation ShinyOrderComboViewController

-(id)initWithCombo:(Combo *)aCombo
{
    self = [super init];
    if (self) 
    {
        theCombo = aCombo;
        renderer = [[ShinyOrderComboRenderer alloc] initWithCombo:theCombo];
        [theTableView setDataSource:renderer];
    }
    return self;
}

-(void)ShinyDeleteCellHandler:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_DELETE_BUTTON_HIT object:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

-(void)loadView
{
    [super loadView];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

@end
