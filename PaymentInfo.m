//
//  PaymentInfo.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentInfo.h"

// Form-like object to validate all values in real time.
@implementation PaymentInfo

static NSRegularExpression* creditCard;
static NSRegularExpression* separator;

+(void)initialize{
    if(!creditCard){
        NSError* err = nil;
        const NSString* pattern = @"\\A(\\d[- ]?){13,16}\\Z";
        creditCard = [[NSRegularExpression alloc] initWithPattern:(NSString*) pattern options:0 error:&err];
        NSAssert(!err, @"Incorrect regex (%@)? UNACCEPTABLE", pattern);
        if(err){
            NSLog(@"%@", err);
        }
    }
    if(!separator){
        NSError* err = nil;
        const NSString* pattern = @"[- ]";
        separator = [[NSRegularExpression alloc] initWithPattern:(NSString*) pattern options:0 error:&err];
        NSAssert(!err, @"Incorrect regex (%@)? UNACCEPTABLE", pattern);
        if(err){
            NSLog(@"%@", err);
        }
    }
}

-(void)setCardnumber:(NSString *)number withValidationMessage:(NSString**)retErr{
    cardnumber = number;
    if(![creditCard firstMatchInString:cardnumber 
                               options:NSMatchingAnchored 
                                 range:NSMakeRange(0, [cardnumber length])]){
        *retErr = @"Must be a credit card number.";
        return;
    }
    NSString* cleaned = [separator stringByReplacingMatchesInString:cardnumber 
                                                            options:0 
                                                              range:NSMakeRange(0, [cardnumber length]) 
                                                       withTemplate:@""];
    NSInteger sum = 0;
    for(int i=[cleaned length]-1; i >= 0 ; --i) {
        unichar c = [cleaned characterAtIndex:i];
        DebugLog(@"#cc: %c", c);
        NSInteger value = c - 48;
        if(i%2) value *= 2;
        sum += (value / 10) + (value % 10);
    }
    if(sum %= 10){
        DebugLog(@"Invalid lunh checksum %d" % sum);
    }
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
            [NSNumber numberWithInt:expirationMonth], @"expiry_month",
            [NSNumber numberWithInt:expirationYear], @"expiry_year",
            nil];
}

@end
