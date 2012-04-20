//
//  SettingsTabViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-10.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsTabViewController.h"
#import "SettingsTabView.h"
#import "ShinySettingsTabRenderer.h"
#import "OrderHistoryViewController.h"
#import "GetPaymentProfileInfo.h"
#import "PaymentProfileInfo.h"
#import "PaymentProcessingViewController.h"
#import "ShinyPaymentProfileViewController.h"

@interface SettingsTabViewController(PrivateMethods)

-(void)afterAnimating:(void(^)())after;

@end


@implementation SettingsTabViewController

- (id) init
{
    self = [super init];
    if (self) 
    {
        renderer = [[ShinySettingsTabRenderer alloc] init];
        [theTableView setDataSource:renderer];
        postAnimation = [NSMutableArray new];
    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [(UILabel *)[[self navigationItem] titleView] setText:@"Settings"];
    oldDelegate = [[self navigationController] delegate];
    [[self navigationController] setDelegate:self];
    NSLog(@"%@", [[self navigationController] delegate]);
}

-(void)ShinySettingsCellHandler:(NSIndexPath *)indexPath
{
    NSString *theTitle = [[renderer objectForCellAtIndex:indexPath] objectForKey:@"settingTitle"];
    
    if ([theTitle isEqualToString:@"Credit Card"]) {
        PaymentProcessingViewController *processingViewController = [[PaymentProcessingViewController alloc] init];
        
        [GetPaymentProfileInfo 
         fetchInfo:^(GetPaymentProfileInfo* request)
         {
             CLLog(LOG_LEVEL_INFO, [NSString stringWithFormat:@"Success %@", self]);
             if ([[[request info] last4Digits] length] == 4) 
             {
                 ShinyPaymentProfileViewController *paymentProfileController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:[request info] AndReturnController:self];
                 
                 [self afterAnimating:^{ 
                     [[self navigationController] pushViewController:paymentProfileController animated:YES];
                 }];
             }
             else
             {
                 UIAlertView *noInternet = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You have no active internet connection" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                 [noInternet show];
                 [[self navigationController] popViewControllerAnimated:YES];
                 CLLog(LOG_LEVEL_WARNING,@"[paymentInfo last4Digits] did not return 4 digits. >=(");
             }
         } 
         failure:^(GetPaymentProfileInfo* info, NSError* error)
         {
             if([[error domain] isEqualToString:JSON_API_ERROR] && 
                [[[error userInfo] objectForKey:@"class"] isEqualToString:@"NoPaymentInfoError"]){
                 ShinyPaymentProfileViewController *paymentProfileController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:nil AndReturnController:self];
                 
                 [self afterAnimating:^{ 
                     [[self navigationController] pushViewController:paymentProfileController animated:YES];
                 }];
             } 
             else 
             {
                 UIAlertView *noInternet = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You have no active internet connection" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
                 
                 [self afterAnimating:^{ 
                     [[self navigationController] popViewControllerAnimated:YES];
                 }];
                 CLLog(LOG_LEVEL_ERROR, @"Payment info request failed from payment settings page.");
                 [noInternet show];
             }
         }];
        
        [[self navigationController] pushViewController:processingViewController animated:YES];
        
        
    }
    
    if ([theTitle isEqualToString:@"Order History"]) {
        OrderHistoryViewController *newController = [[OrderHistoryViewController alloc] init];
        [[self navigationController] pushViewController:newController animated:YES];
    }
}

-(void)navigationController:(UINavigationController *)navigationController 
     willShowViewController:(UIViewController *)viewController 
                   animated:(BOOL)animated{
    if(animated){
        @synchronized(self){
            animating = YES;
        }
    }
}
-(void)navigationController:(UINavigationController *)navigationController 
      didShowViewController:(UIViewController *)viewController 
                   animated:(BOOL)animated{
    if(animated){
        @synchronized(self){
            animating = NO;
            for(void(^postAnimationBlock)() in postAnimation){
                postAnimationBlock();
            }
            [postAnimation removeAllObjects];
        }
    }
}

-(void)afterAnimating:(void (^)())after{
    @synchronized(self){
        if(animating){
            [postAnimation addObject:[after copy]];
        } else {
            after();
        }
    }
}

@end
