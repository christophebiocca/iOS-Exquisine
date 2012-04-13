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
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        theCombo = aCombo;
        comboView = [[ShinyComboView alloc] init];
        comboRenderer = [[ShinyOrderComboRenderer alloc] initWithCombo:theCombo];
        
        [[comboView comboTable] setDelegate:self];
        [[comboView comboTable] setDataSource:comboRenderer];
        
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if ([[CustomViewCell cellIdentifierForData:[comboRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyDeleteCell"])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_DELETE_BUTTON_HIT object:self];
        [[self navigationController] popViewControllerAnimated:YES];
    }
}

-(void)loadView
{
    [super loadView];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonHit)];
    [[self navigationItem] setRightBarButtonItem:doneButton];
}

-(void) deleteButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_DELETE_BUTTON_HIT object:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
