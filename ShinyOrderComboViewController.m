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
        
        //This is pretty hackish and will have to change if any other buttons get added 
        //I should fix this at some point.
        for (NSArray *eachArray in [comboRenderer listData]) {
            for (id eachThing in eachArray) {
                if ([eachThing isKindOfClass:[UIButton class]]) {
                    [eachThing addTarget:self action:@selector(deleteButtonHit) forControlEvents:UIControlEventTouchUpInside];
                }
            }
        }
        
        [[comboView comboTable] setDelegate:self];
        [[comboView comboTable] setDataSource:comboRenderer];
        
    }
    return self;
}

-(void) deleteButtonHit
{
    [[NSNotificationCenter defaultCenter] postNotificationName:COMBO_DELETE_BUTTON_HIT object:self];
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
