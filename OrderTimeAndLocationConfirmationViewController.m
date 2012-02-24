//
//  OrderTimeAndLocationConfirmationViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderTimeAndLocationConfirmationViewController.h"
#import "OrderTimeAndLocationConfirmationView.h"
#import "Location.h"
#import "LocationState.h"

@implementation OrderTimeAndLocationConfirmationViewController

@synthesize doneBlock;
@synthesize cancelledBlock;

//See [self initialize]
static NSArray* pickerTimes = nil;

+(void)initialize{
    if (!pickerTimes) {
        pickerTimes = [[NSArray alloc] initWithObjects:
                       @"5 Minutes",
                       @"10 Minutes",
                       @"15 Minutes",
                       @"20 Minutes",
                       @"30 Minutes", 
                       @"45 Minutes", 
                       @"1 Hour", 
                       @"1 Hour and 15 Minutes", 
                       @"1 Hour and 30 Minutes", 
                       nil];
    }
}

-(id)initWithLocationState:(LocationState *)theLocationState
{
    self = [super init];
    if(self)
    {
        orderTimeAndLocationConfirmationView = [[OrderTimeAndLocationConfirmationView alloc] initWithLocationState:theLocationState];
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [[self navigationItem] setRightBarButtonItem:doneButton];
        
        [[orderTimeAndLocationConfirmationView navBar] pushNavigationItem:[self navigationItem] animated:NO];
        
        
        [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] setDelegate:self];
        [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] setDataSource:self];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void) loadView
{
    [self setView:orderTimeAndLocationConfirmationView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) done
{
    doneBlock();
}

-(void) cancel
{
    cancelledBlock();
}

//Delegate and Datasource methods:

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300.0f;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [pickerTimes objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [pickerTimes count];
}


@end
