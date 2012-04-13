//
//  ShinyPaymentProfileViewController.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PaymentProfileInfo;
@class ShinyPaymentProfileView;
@class ShinyPaymentProfileRenderer;

@interface ShinyPaymentProfileViewController : UIViewController<UITableViewDelegate,UINavigationControllerDelegate,UITabBarControllerDelegate>
{
    PaymentProfileInfo *profileInfo;
    UIViewController *returnController;
    ShinyPaymentProfileView *paymentProfileView;
    ShinyPaymentProfileRenderer *paymentProfileRenderer;
    
    /* Animation Management */
    BOOL animating;
    NSMutableArray* postAnimation;
}

- (id) initWithPaymentInfo:(PaymentProfileInfo *) paymentInfo AndReturnController:(UIViewController *) aController;

@end
