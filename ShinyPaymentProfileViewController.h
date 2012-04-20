//
//  ShinyPaymentProfileViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListViewController.h"
@class PaymentProfileInfo;

@interface ShinyPaymentProfileViewController : ListViewController<UINavigationControllerDelegate,UITabBarControllerDelegate>
{
    UITabBarController *theTabBarController;
    PaymentProfileInfo *profileInfo;
    UIViewController *returnController;
    
    /* Animation Management */
    BOOL animating;
    NSMutableArray* postAnimation;
}

- (id) initWithPaymentInfo:(PaymentProfileInfo *) paymentInfo AndReturnController:(UIViewController *) aController;

@end
