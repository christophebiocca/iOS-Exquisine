//
//  PaymentInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentInfo.h"

@implementation PaymentInfo

-(void)setCardnumber:(NSString *)number withValidationMessage:(NSString**)retErr{
    cardnumber = number;
    NSCharacterSet* cardDivisers = [NSCharacterSet characterSetWithCharactersInString:@" -"];
    for(NSString* block in [cardnumber componentsSeparatedByCharactersInSet:cardDivisers]){
        for(NSString* number in [block componentsSeparatedByString:@""]){
            NSLog(@"cc#: %@", number);
        }
    }
    //*retErr = @"FAIL";
}

-(void)setCardholderName:(NSString *)name withValidationMessage:(NSString**)retErr{
    cardholderName = name;
}

-(void)setExpirationMonth:(NSInteger)month withValidationMessage:(NSString**)retErr{
    expirationMonth = month;
}

-(void)setExpirationYear:(NSInteger)year withValidationMessage:(NSString**)retErr{
    expirationYear = year;
}

-(NSDictionary*)dictionaryRepresentation{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            cardnumber, @"cardnumber",
            cardholderName, @"cardholder_name",
            expirationMonth, @"expiry_month",
            expirationYear, @"expiry_year",
            nil];
}

@end
