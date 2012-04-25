//
//  PromoCode.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// A PromoCode can be returned from the server
// when someone places an order and can be redeemed
// at order time by inputting it into your phone.
// The redeption of a PromoCode will result in
// the generation of a Promo, which is like an electronic
// coupon. The coupon can be used for any orders that
// adhere to the conditions of the Promo. The server
// decides whether the specific user is eligable for
// a promotion at order time.

#import <Foundation/Foundation.h>

@interface PromoCode : NSObject
{
    NSString *name;	
    NSString *theCode;
    NSString *wallText;
}

@property (retain) NSString *name;
@property (retain) NSString *theCode;
@property (retain) NSString *wallText;

@end
