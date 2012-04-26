//
//  PaymentConfirmationRenderer.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PaymentConfirmationRenderer.h"
#import "GeneralPurposeViewCellData.h"
#import "PaymentProfileInfo.h"
#import "ShinyHeaderView.h"
#import "Order.h"

@implementation PaymentConfirmationRenderer

-(id)initWithPaymentInfo:(PaymentProfileInfo*)profile andOrder:(Order *)anOrder
{
    self = [super init];
    
    if(self)
    {
        thePaymenyProfile = profile;
        theOrder = anOrder;
        
        sectionNames = [[NSMutableArray alloc] init];
        listData = [[NSMutableArray alloc] init];
     
        theOrder = anOrder;
        
        [sectionNames addObject:@"Payment Summary"];
        NSMutableArray *paymentSummarySection = [[NSMutableArray alloc] init];
        
        [paymentSummarySection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Summary"]];
        
        GeneralPurposeViewCellData *subtotalCell = [[GeneralPurposeViewCellData alloc] init];
        [subtotalCell setTitle:@"Subtotal:"];
        [subtotalCell setHeight:22.0f];
        [subtotalCell setDescription:[Utilities FormatToPrice:[theOrder subtotalPrice]]];
        [paymentSummarySection addObject:subtotalCell];
        
        GeneralPurposeViewCellData *hstCell = [[GeneralPurposeViewCellData alloc] init];
        [hstCell setTitle:@"HST:"];
        [hstCell setHeight:22.0f];
        [hstCell setDescription:[Utilities FormatToPrice:[theOrder taxPrice]]];
        [paymentSummarySection addObject:hstCell];
        
        GeneralPurposeViewCellData *grandTotalCell = [[GeneralPurposeViewCellData alloc] init];
        [grandTotalCell setTitle:@"Grand Total:"];
        [grandTotalCell setHeight:22.0f];
        [grandTotalCell setDescription:[Utilities FormatToPrice:[theOrder totalPrice]]];
        [paymentSummarySection addObject:grandTotalCell];
        
        [listData addObject:paymentSummarySection];
        
        [sectionNames addObject:@"Payment Method"];
        
        NSMutableArray *paymentMethodSection = [[NSMutableArray alloc] init];
        
        [paymentMethodSection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Payment"]];
        
        [paymentMethodSection addObject:thePaymenyProfile];
        
        [paymentMethodSection addObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Different Card", [thePaymenyProfile last4Digits]] forKey:@"settingTitle"]];
        
        [listData addObject:paymentMethodSection];
        
        
        [sectionNames addObject:@"Promo Code Section"];
        
        NSMutableArray *promoSection = [[NSMutableArray alloc] init];
        
        [promoSection addObject:[[ShinyHeaderView alloc] initWithTitle:@"Promo Codes"]];
        
        [promoSection addObject:[NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"Input Promo Code", [thePaymenyProfile last4Digits]] forKey:@"settingTitle"]];
        
        [listData addObject:promoSection];
        
    }
    
    return self;
}

@end
