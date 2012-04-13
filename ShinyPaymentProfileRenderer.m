//
//  ShinyPaymentProfileRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyPaymentProfileRenderer.h"
#import "ShinyHeaderView.h"
#import "PaymentProfileInfo.h"
#import "ShinyDeleteCell.h"

@implementation ShinyPaymentProfileRenderer

-(id)initWithPaymentInfo:(PaymentProfileInfo *)paymentInfo
{
    self = [super init];
    
    if(self)
    {
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
        
        [sectionNames addObject:@"Payment Profiles"];
        
        NSMutableArray *paymentProfilesSection = [[NSMutableArray alloc] init];
        
        [paymentProfilesSection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Payment Type"]];
        
        if (paymentInfo) {
            [paymentProfilesSection addObject:paymentInfo];
            [paymentProfilesSection addObject:[NSDictionary dictionaryWithObject:@"Forget Payment Info" forKey:@"deleteTitle"]];
        }
        else {
            [paymentProfilesSection addObject:[NSDictionary dictionaryWithObject:@"Add a Credit Card" forKey:@"settingTitle"]];
        }
        
        [listData addObject:paymentProfilesSection];
        
    }
    
    return self;
}

@end
