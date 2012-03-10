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

@synthesize cardholderNameError, cardnumberError, expirationError;
@synthesize remember;

static NSRegularExpression* creditCard;
static NSRegularExpression* separator;

+(void)initialize{
    if(!creditCard){
        NSError* err = nil;
        const NSString* pattern = @"\\A(\\d[- ]?){13,16}\\Z";
        creditCard = [[NSRegularExpression alloc] initWithPattern:(NSString*) pattern options:0 error:&err];
        NSAssert(!err, @"Incorrect regex (%@)? UNACCEPTABLE", pattern);
        if(err){
            CLLog(LOG_LEVEL_DEBUG, [NSString stringWithFormat:@"%@", err]);
        }
    }
    if(!separator){
        NSError* err = nil;
        const NSString* pattern = @"[- ]";
        separator = [[NSRegularExpression alloc] initWithPattern:(NSString*) pattern options:0 error:&err];
        NSAssert(!err, @"Incorrect regex (%@)? UNACCEPTABLE", pattern);
        if(err){
            CLLog(LOG_LEVEL_DEBUG, [NSString stringWithFormat:@"%@", err]);
        }
    }
}

-(id)init{
    if(self = [super init]){
        [self setCardnumber:nil];
        [self setCardholderName:nil];
        expirationYear = -1;
        expirationMonth = -1;
        [self setRemember:YES];
    }
    return self;
}

-(void)setCardnumber:(NSString *)number{
    cardnumber = number;
    cardnumberError = nil;
    if(!cardnumber || ![cardnumber length]){
        cardnumberError = @"This field is required";
        return;
    }
    if(![creditCard firstMatchInString:cardnumber 
                               options:NSMatchingAnchored 
                                 range:NSMakeRange(0, [cardnumber length])]){
        cardnumberError = @"Must be a credit card number";
        return;
    }
    NSString* cleaned = [separator stringByReplacingMatchesInString:cardnumber 
                                                            options:0 
                                                              range:NSMakeRange(0, [cardnumber length]) 
                                                       withTemplate:@""];
    NSInteger sum = 0;
    NSUInteger length = [cleaned length];
    for(int i=0; i < length ; ++i) {
        unichar c = [cleaned characterAtIndex:(length - i) - 1];
        NSInteger value = c - 48;
        if(i%2) value *= 2;
        sum += (value / 10) + (value % 10);
    }
    if(sum %= 10){
        CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat: @"Invalid lunh checksum %d", sum]);
        cardnumberError = @"This number is invalid";
    }
}

-(void)setCardholderName:(NSString *)name{
    cardholderName = name;
    cardholderNameError = nil;
    if(!cardholderName || ![cardholderName length]){
        cardholderNameError = @"This field is required";
    }
}

-(void)checkDate{
    if(expirationMonth == -1 || expirationYear == -1){
        expirationError = @"This field is required";
        return;
    }
    NSDate* today = [NSDate new];
    NSDate* actualExpiration;
    {
        NSDateComponents* oneMonth = [NSDateComponents new];
        [oneMonth setMonth:1];
        NSDateComponents* expirationComponents = [NSDateComponents new];
        [expirationComponents setDay:1];
        [expirationComponents setMonth:expirationMonth];
        [expirationComponents setYear:expirationYear];
        NSDate* expirationMonthStart = [[NSCalendar currentCalendar] dateFromComponents:expirationComponents];
        actualExpiration = [[NSCalendar currentCalendar] dateByAddingComponents:oneMonth toDate:expirationMonthStart options:0];
    }
    if([today compare:actualExpiration] != NSOrderedAscending){
        expirationError = @"Already Expired";
    }
}

-(void)setExpirationMonth:(NSString*)month{
    if(month && [month length]){
        expirationMonth = [month integerValue];
    } else {
        expirationMonth = -1;
    }
    expirationError = nil;
    [self checkDate];
}

-(void)setExpirationYear:(NSString*)year{
    if(year && [year length]){
        expirationYear = [year integerValue];
    } else {
        expirationYear = -1;
    }
    expirationError = nil;
    [self checkDate];
}

-(NSDictionary*)dictionaryRepresentation{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            cardnumber, @"cardnumber",
            cardholderName, @"cardholder_name",
            [NSNumber numberWithInt:expirationMonth], @"expiry_month",
            [NSNumber numberWithInt:expirationYear], @"expiry_year",
            nil];
}

-(BOOL)anyErrors{
    return cardnumberError || cardholderNameError || expirationError;
}

@end
