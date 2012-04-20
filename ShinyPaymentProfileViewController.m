//
//  ShinyPaymentProfileViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyPaymentProfileViewController.h"
#import "ShinyPaymentProfileRenderer.h"
#import "PaymentProfileInfo.h"
#import "DeletePaymentInfo.h"
#import "PaymentInfoViewController.h"
#import "PaymentView.h"
#import "SetPaymentProfileInfo.h"
#import "GetPaymentProfileInfo.h"
#import "PaymentProcessingView.h"
#import "PaymentProcessingViewController.h"

@interface ShinyPaymentProfileViewController(PrivateMethods)

-(void)afterAnimating:(void(^)())after;
- (void) changePaymentInfo;
-(void)sendPaymentInfo:(PaymentInfo *)paymentInfo;

@end

@implementation ShinyPaymentProfileViewController

- (id) initWithPaymentInfo:(PaymentProfileInfo *) paymentInfo AndReturnController:(UIViewController *) aController
{
    self = [super init];
    if (self) 
    {
        profileInfo = paymentInfo;
        returnController = aController;
        renderer = [[ShinyPaymentProfileRenderer alloc] initWithPaymentInfo:paymentInfo];
        [theTableView setDataSource:renderer];
        [[self navigationItem] setHidesBackButton:YES]; 

    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [(UILabel *)[[self navigationItem] titleView] setText:@"Payment Method"];
        
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonHit)];
    [backButton setTintColor:[Utilities fravicDarkRedColor]];
    
    [[self navigationItem] setLeftBarButtonItem:backButton];
    
    UIBarButtonItem *fillerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    [fillerButton setCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 21)]];
    [[self navigationItem] setRightBarButtonItem:fillerButton];

    theTabBarController = [self tabBarController];
    
    if (!theTabBarController) {
        CLLog(LOG_LEVEL_ERROR,@"The tabBarController doesn't exist");
    }
    [theTabBarController setDelegate:self];
}

-(void)viewDidDisappear:(BOOL)animated
{
    if (!theTabBarController) {
        CLLog(LOG_LEVEL_ERROR,@"The tabBarController doesn't exist");
    }
    [theTabBarController setDelegate:nil];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (!theTabBarController) {
        CLLog(LOG_LEVEL_ERROR,@"The tabBarController doesn't exist");
    }
    [theTabBarController setDelegate:nil];
    [[self navigationController] popToViewController:returnController animated:NO];
}

-(void)backButtonHit
{
    if (!theTabBarController) {
        CLLog(LOG_LEVEL_ERROR,@"The tabBarController doesn't exist");
    }
    [theTabBarController setDelegate:nil];
    [[self navigationController] popToViewController:returnController animated:YES];
}

-(void)ShinyDeleteCellHandler:(NSIndexPath *)indexPath
{
    [DeletePaymentInfo deletePaymentInfo:^(APICall *theAPICall)
     {
         ShinyPaymentProfileViewController *newController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:nil AndReturnController:returnController];
         
         [self afterAnimating:^{
             NSMutableArray *newNavStack = [[NSMutableArray alloc] initWithArray:[[self navigationController] viewControllers]];
             
             while (![[newNavStack lastObject] isEqual: returnController]) {
                 [newNavStack removeObject:[newNavStack lastObject]];
             }
             
             [newNavStack addObject:newController];
             
             [[self navigationController] setViewControllers:newNavStack animated:YES];
         }];
     }
                                 failure:^(APICall *theAPICall, NSError *anError) 
     {
         UIAlertView *oops = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"Your credit card info could not be deleted because the server cannot be accessed at the moment. Please try again later." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
         
         [oops show];
         
         [self afterAnimating:^{
             ShinyPaymentProfileViewController *newController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:profileInfo AndReturnController:returnController];
             
             NSMutableArray *newNavStack = [[NSMutableArray alloc] initWithArray:[[self navigationController] viewControllers]];
             
             while (![[newNavStack lastObject] isEqual: returnController]) {
                 [newNavStack removeObject:[newNavStack lastObject]];
             }
             
             [newNavStack addObject:newController];
             
             [[self navigationController] setViewControllers:newNavStack animated:YES];
         }];
     }];
    
    [[self navigationController] pushViewController:[PaymentProcessingViewController new] animated:YES];
}

-(void)ShinySettingsCellHandler:(NSIndexPath *)indexPath
{
    [self changePaymentInfo];
}

-(void)ShinyPaymentViewCellHandler:(NSIndexPath *)indexPath
{
    [self changePaymentInfo];
}

-(void)sendPaymentInfo:(PaymentInfo *)paymentInfo
{
    [[self navigationController] pushViewController:[PaymentProcessingViewController new] animated:YES];
    [SetPaymentProfileInfo setPaymentInfo:paymentInfo:
     ^(id success) {
         [GetPaymentProfileInfo fetchInfo:^(GetPaymentProfileInfo* request) {
             ShinyPaymentProfileViewController *newController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:[request info] AndReturnController:returnController];
             [self afterAnimating:^{
                 NSMutableArray *newNavStack = [[NSMutableArray alloc] initWithArray:[[self navigationController] viewControllers]];
                 
                 while (![[newNavStack lastObject] isEqual: returnController]) {
                     [newNavStack removeObject:[newNavStack lastObject]];
                 }
                 
                 [newNavStack addObject:newController];
                 
                 [[self navigationController] setViewControllers:newNavStack animated:YES];
             }];
         } failure:^(GetPaymentProfileInfo* request, NSError* error) {
             [[[UIAlertView alloc] initWithTitle:@"Oops" message:@"The server doesn't appear to be up, your payment info cannot be set." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil] show];
             [self afterAnimating:^{
                 ShinyPaymentProfileViewController *newController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:profileInfo AndReturnController:returnController];
                 
                 NSMutableArray *newNavStack = [[NSMutableArray alloc] initWithArray:[[self navigationController] viewControllers]];
                 
                 while (![[newNavStack lastObject] isEqual: returnController]) {
                     [newNavStack removeObject:[newNavStack lastObject]];
                 }
                 
                 [newNavStack addObject:newController];
                 
                 [[self navigationController] setViewControllers:newNavStack animated:YES];
             }];
         }];
     } failure:^(id failure, NSError *errorCode) {
         
         UIAlertView *fail = nil;
         
         if ([[[errorCode userInfo] valueForKey:@"message"] isEqualToString:@"Unaccepted card type\nInvalid Card Number\n"]) {
             fail = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"The credit card information that you input was not valid. Please try again." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
         }
         else
         {
             
             
             fail = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"The server doesn't appear to be up, your payment info cannot be set." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
         }
         
         [fail show];
         
         [self afterAnimating:^{
             ShinyPaymentProfileViewController *newController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:profileInfo AndReturnController:returnController];
             
             NSMutableArray *newNavStack = [[NSMutableArray alloc] initWithArray:[[self navigationController] viewControllers]];
             
             while (![[newNavStack lastObject] isEqual: returnController]) {
                 [newNavStack removeObject:[newNavStack lastObject]];
             }
             
             [newNavStack addObject:newController];
             
             [[self navigationController] setViewControllers:newNavStack animated:YES];
         }];
         
     }];
    
}

- (void) changePaymentInfo
{
    PaymentInfoViewController *controller = [[PaymentInfoViewController alloc] init];
    
    [[controller paymentView] setShowRemember:NO];
    
    [controller setCompletionBlock:^(PaymentInfo* info){
        [self sendPaymentInfo:info];
    }];
    [controller setCancelledBlock:^{
        
        ShinyPaymentProfileViewController *newController = [[ShinyPaymentProfileViewController alloc] initWithPaymentInfo:profileInfo AndReturnController:returnController];
        
        NSMutableArray *newNavStack = [[NSMutableArray alloc] initWithArray:[[self navigationController] viewControllers]];
        
        while (![[newNavStack lastObject] isEqual: returnController]) {
            [newNavStack removeObject:[newNavStack lastObject]];
        }
        
        [newNavStack addObject:newController];
        [[self navigationController] setViewControllers:newNavStack animated:YES];
    }];
    
    [[self navigationController] pushViewController:controller animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    if (!theTabBarController) {
        CLLog(LOG_LEVEL_ERROR,@"The tabBarController doesn't exist");
    }
    
    [theTabBarController setDelegate:nil];
    // Release any retained subviews of the main view.
}

//This is really bad. We need a class to manage this. Copy pasting code is terrible.
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


-(void)dealloc
{
    if (!theTabBarController) {
        CLLog(LOG_LEVEL_ERROR,@"The tabBarController doesn't exist");
    }
    if ([theTabBarController delegate] == self) {
        [theTabBarController setDelegate:nil];
    }
}
         
@end
