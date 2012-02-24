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
#import "LocationMapView.h"
#import "LocationState.h"
#import "Order.h"

@implementation OrderTimeAndLocationConfirmationViewController

@synthesize doneBlock;
@synthesize cancelledBlock;

//See [self initialize]
static NSArray* pickerTimes = nil;

//These numbers will be formatted when the rows are requested. Numbers are in minutes.
+(void)initialize{
    if (!pickerTimes) {
        pickerTimes = [[NSArray alloc] initWithObjects:
                       [NSNumber numberWithInt:5],
                       [NSNumber numberWithInt:10],
                       [NSNumber numberWithInt:15],
                       [NSNumber numberWithInt:20],
                       [NSNumber numberWithInt:30],
                       [NSNumber numberWithInt:45],
                       [NSNumber numberWithInt:60],
                       [NSNumber numberWithInt:75],
                       [NSNumber numberWithInt:90],
                       nil];
    }
}

-(id)initWithLocationState:(LocationState *)theLocationState AndOrder:(Order *)anOrder
{
    self = [super init];
    if(self)
    {
        orderTimeAndLocationConfirmationView = [[OrderTimeAndLocationConfirmationView alloc] initWithLocationState:theLocationState];
        
        theOrder = anOrder;
        
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
        
        [[self navigationItem] setLeftBarButtonItem:cancelButton];
        [[self navigationItem] setRightBarButtonItem:doneButton];
        
        [[orderTimeAndLocationConfirmationView navBar] pushNavigationItem:[self navigationItem] animated:NO];
        
        
        [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] setDelegate:self];
        [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] setDataSource:self];
        
        [theOrder setPitaFinishedTime:[NSDate dateWithTimeIntervalSinceNow:300]];
        
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
    if (!([[[[orderTimeAndLocationConfirmationView locationView] locationState] selectedLocation] storeState] == Open))
    {
        UIAlertView *tryAgain = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"The location you have selected is not open. Select one that is open to continue." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to order from a store that is closed"];
        
        [tryAgain show];
        return;
    }
    doneBlock();
}

-(void) cancel
{
    cancelledBlock();
}

//Delegate and Datasource methods:

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [theOrder setPitaFinishedTime:[NSDate dateWithTimeIntervalSinceNow:([[pickerTimes objectAtIndex:row] intValue] * 60)]];
}

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
    NSMutableString *rowTitle = [[NSMutableString alloc] initWithCapacity:0];
    
    int hour = [[pickerTimes objectAtIndex:row] intValue] / 60; 
    if (hour) {
        if(hour == 1)
            [rowTitle appendFormat:@"%i hour ", hour];
        else
            [rowTitle appendFormat:@"%i hours ", hour];
    }
    
    int minutes = [[pickerTimes objectAtIndex:row] intValue] % 60;
    if (minutes) {
        if(minutes == 1)
            [rowTitle appendFormat:@"%i minute", minutes];
        else
            [rowTitle appendFormat:@"%i minutes", minutes];
    }
    
    return rowTitle;
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
