//
//  PaymentInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentInfo.h"

@implementation PaymentInfo

-(void)setCardnumber:(NSString *)number{
    cardnumber = number;
}

-(void)setCardholderName:(NSString *)name{
    cardholderName = name;
}

-(void)setExpiration:(NSDate *)expirationDate{
    expiration = expirationDate;
}

-(NSDictionary*)dictionaryRepresentation{
    NSDateComponents* components = [[NSCalendar currentCalendar] 
                                    components:NSMonthCalendarUnit | NSYearCalendarUnit 
                                    fromDate:expiration];
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            cardnumber, @"cardnumber",
            cardholderName, @"cardholder_name",
            [components month], @"expiry_month",
            [components year], @"expiry_year",
            nil];
}

@end
