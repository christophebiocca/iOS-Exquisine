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
        
        //Starts at 5 minutes
        pickerMinute = 5;
        pickerHour = 0;
        
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
    //There are some odd bugs that result in the model and view not agreeing. This 
    //will make sure that we have consistancy.
    pickerHour = [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] selectedRowInComponent:0];
    
    if (pickerHour == 0) {
        pickerMinute = [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] selectedRowInComponent:1] + 5;
    }
    else
    {
        pickerMinute = [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] selectedRowInComponent:1];
    }
   
    if (![[[[orderTimeAndLocationConfirmationView locationView] locationState] selectedLocation] wouldBeOpenAt:[NSDate dateWithTimeIntervalSinceNow:(pickerMinute * 60 + pickerHour * 3600)]])
    {
        UIAlertView *tryAgain = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"The restaurant would be closed at the time you requested your pita to be done." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to order a pita set to be completed after closing time."];
        
        [tryAgain show];
        return;
    }
    
    [theOrder setPitaFinishedTime:[NSDate dateWithTimeIntervalSinceNow:(pickerMinute * 60 + pickerHour * 3600)]];
    doneBlock();
}

-(void) cancel
{
    cancelledBlock();
}

//Delegate and Datasource methods:

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            pickerHour = row;
            break;
            
        case 1:
            if(pickerHour > 0)
                pickerMinute = row;
            else
                pickerMinute = row + 5;
            break;
        default:
            break;
    }
    
    if (pickerHour == 0)
    {
        if (pickerMinute < 5)
        {
            pickerMinute = 5;
        }
    }
    
    [self refreshRowLocation];
}
         
-(void)refreshRowLocation
{
    if(pickerHour != 0)
        [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] selectRow:pickerMinute inComponent:1 animated:NO];
    else
        [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] selectRow:(pickerMinute - 5) inComponent:1 animated:NO];
    
    [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] setNeedsLayout];
    [[orderTimeAndLocationConfirmationView orderCompletionDurationPicker] setNeedsDisplay];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 44.0f;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 130;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSMutableString *rowTitle = [[NSMutableString alloc] initWithCapacity:0];
    
    switch (component) {
        case 0:
            if(row == 1)
                [rowTitle appendFormat:@"%i Hour",row];
            else
                [rowTitle appendFormat:@"%i Hours",row];
            break;
            
        case 1:
            if(pickerHour > 0)
                if(row == 1)
                    [rowTitle appendFormat:@"%i Minute",row];
                else
                    [rowTitle appendFormat:@"%i Minutes",row];
            else
                [rowTitle appendFormat:@"%i Minutes",(row + 5)];
            break;
        default:
            break;
    }
    
    return rowTitle;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return 37;
            break;
            
        case 1:
            if(pickerHour > 0)
                return 60;
            else
                return 55;
            break;
        default:
            break;
    }
    return 0;
}


@end
