//
//  ShinyPaymentProfileViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShinyPaymentProfileViewController.h"
#import "ShinyPaymentProfileView.h"
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
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        profileInfo = paymentInfo;
        returnController = aController;
        paymentProfileView = [[ShinyPaymentProfileView alloc] init];
        paymentProfileRenderer = [[ShinyPaymentProfileRenderer alloc] initWithPaymentInfo:paymentInfo];
        [[paymentProfileView paymentMethodsTable] setDelegate:self];
        [[paymentProfileView paymentMethodsTable] setDataSource:paymentProfileRenderer];
        [[self navigationItem] setHidesBackButton:YES]; 
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setBackgroundImage:[UIImage imageNamed:@"BlankTopbarWithShadow.png"] forBarMetrics:UIBarMetricsDefault];
    
    UILabel *toolbarText = [[UILabel alloc] initWithFrame:CGRectMake(
                                                                     ([[[self navigationController] navigationBar] frame ].size.width - 300) / 2,
                                                                     (44 - 30) / 2, 
                                                                     300, 
                                                                     30)];
    [toolbarText setFont:[UIFont fontWithName:@"Optima-ExtraBlack" size:22]];
    [toolbarText setTextColor:[UIColor whiteColor]];
    [toolbarText setBackgroundColor:[UIColor clearColor]];
    [toolbarText setTextAlignment:UITextAlignmentCenter];
    
    [toolbarText setText:@"Payment Method"];
    [[self navigationItem] setTitleView:toolbarText];   
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonHit)];
    [backButton setTintColor:[Utilities fravicDarkRedColor]];
    
    [[self navigationItem] setLeftBarButtonItem:backButton];
    
    [[self navigationController] setTitle:@"Payment Method"];
    
    UIBarButtonItem *fillerButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:nil];
    [fillerButton setCustomView:[[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 21)]];
    [[self navigationItem] setRightBarButtonItem:fillerButton];

    [[self tabBarController] setDelegate:self];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[self tabBarController] setDelegate:nil];
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    [[self tabBarController] setDelegate:nil];
    [[self navigationController] popToViewController:returnController animated:NO];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

-(void)backButtonHit
{
    [[self navigationController] popToViewController:returnController animated:YES];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([[CustomViewCell cellIdentifierForData:[paymentProfileRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyDeleteCell"])
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
    else if ([[CustomViewCell cellIdentifierForData:[paymentProfileRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinySettingsCell"])
    {
        [self changePaymentInfo];
    }
    else if ([[CustomViewCell cellIdentifierForData:[paymentProfileRenderer objectForCellAtIndex:indexPath]] isEqualToString:@"ShinyPaymentViewCell"])
    {
        [self changePaymentInfo];
    }
        
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [CustomViewCell cellHeightForData:[paymentProfileRenderer objectForCellAtIndex:indexPath]];
}

-(void)loadView
{
    [super loadView];
    [self setView:paymentProfileView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
}
         
@end
