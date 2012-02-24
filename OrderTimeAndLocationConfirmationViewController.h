//
//  OrderTimeAndLocationConfirmationViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-02-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTimeAndLocationConfirmationView;
@class Location;
@class LocationState;

@interface OrderTimeAndLocationConfirmationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    OrderTimeAndLocationConfirmationView *orderTimeAndLocationConfirmationView;
    
    void(^doneBlock)();
    void(^cancelledBlock)();
}

@property(copy, nonatomic)void (^doneBlock)();
@property(copy, nonatomic)void (^cancelledBlock)();

-(id)initWithLocationState:(LocationState *)theLocationState;

@end
