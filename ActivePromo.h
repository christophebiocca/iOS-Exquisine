//
//  ActivePromo.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-25.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promo.h"

@interface ActivePromo : Promo
{
    //This number refers to the cost of the order
    //assuming the promo was applied
    NSDecimalNumber *promoPrice;
}

@property (retain) NSDecimalNumber *promoPrice;

@end
