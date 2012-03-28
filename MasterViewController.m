//
//  MasterViewController.m
//  AvocadoTest1
//
//  Created by Jake on 12-02-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "MasterView.h"
#import "LoadingView.h"
#import "LocationTabViewController.h"
#import "OrderTabViewController.h"
#import "FavoritesViewController.h"
#import "Order.h"
#import "OrderManager.h"
#import "PaymentStack.h"
#import "AppData.h"
#import "CustomTabBarController.h"
#import "Reachability.h"

@implementation MasterViewController

@synthesize masterView;
@synthesize appData;


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        masterView = [[MasterView alloc] initWithFrame:frame];
        appData = [AppData alloc];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationSuccess) name:INITIALIZED_SUCCESS object:appData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initializationFailure) name:INITIALIZED_FAILURE object:appData];
        appData = [appData init];
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOrderConfirmation:) name:ORDER_PLACEMENT_REQUESTED object:[appData theOrderManager]];
        [[[masterView loadingView] progressLabel] setText:@"Contacting Server..."];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    [super loadView];
    [self setView:masterView];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void) initializationSuccess
{
    [[[masterView loadingView] progressLabel] setText:@"Initialization Complete"];
    LocationTabViewController *locationTabViewController = [[LocationTabViewController alloc] initWithLocationState:[appData locationState]];
    
    [locationTabViewController setTitle:@"Location"];
    
    OrderTabViewController *orderTabViewController = [[OrderTabViewController alloc] initWithOrderManager:[appData theOrderManager]];
    
    UINavigationController *orderTabNavigationController = [[UINavigationController alloc] initWithRootViewController:orderTabViewController];
    [orderTabNavigationController setHidesBottomBarWhenPushed:YES];
    
    [orderTabNavigationController setTitle:@"Order"];
    
    FavoritesViewController *favoritesTabViewController = [[FavoritesViewController alloc] initWithFavoritesListAndMenu:[appData favoriteOrders] :[appData theMenu]];
    
    [favoritesTabViewController setTitle:@"Favorites"];
    
    [[masterView tabController] setViewControllers:[NSArray arrayWithObjects:locationTabViewController,orderTabNavigationController,favoritesTabViewController,nil]];
    
    [[[masterView tabController] view] setNeedsLayout];
    [[[masterView tabController] view] setNeedsDisplay];
    //This is here because if the app also hits the server successfully, it'll reload some stuff.
    [masterView performSelector:@selector(dissolveLoadingView) withObject:nil afterDelay:2];
}

-(void) initializationFailure
{
    [[[masterView loadingView] progressLabel] setText:@"No connectivity detected"];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oops" message:@"You must have an internet connection the first time you run this app" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [masterView dissolveProgressIndicator];
    [alert show];
}

-(void)reloadData
{
    [masterView putUpLoadingView];
    [appData initializeFromServer];
    [masterView performSelector:@selector(dissolveLoadingView) withObject:nil afterDelay:2];
}

-(void) showOrderConfirmation:(NSNotification *) aNotification
{
    
    if (![[aNotification object] isKindOfClass:[OrderManager class]]) 
    {
        CLLog(LOG_LEVEL_ERROR, @"An object not of type OrderManager was sent to MasterViewController's showOrderConfirmation:  omgwtfhax. That is all.");
        return;
    }
    
    if ([aNotification object] != [appData theOrderManager]) {
        CLLog(LOG_LEVEL_ERROR, @"We're trying to submit an order with an orderManager that does not belong to appData. That's bad, and it won't work. Commencing operation run around like a chicken with its head cut off.");
        return;
    }
    
    if([[[aNotification object] thisOrder].totalPrice doubleValue] <= 0.0)
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You havn't selected anything to purchase" delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to place an empty order"];
        
        [areYouSure show];
        
        return;
    }
    
    if(![appData anyLocationIsOpen])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"None of the restaurants are open right now. You'll have to wait until they are." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
        
        [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Tried to place order when the restautant isn't open"];
        
        [areYouSure show];
        
        return;
    }
    
    if([[appData networkChecker] isReachable])
    {
        UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Process Purchase?" message:[NSString stringWithFormat: @"Order confirmation:\nSubtotal: %@\nHST: %@\nGrand Total: %@\n\nIs this okay?", [Utilities FormatToPrice:[[[aNotification object] thisOrder] subtotalPrice]],[Utilities FormatToPrice:[[[aNotification object] thisOrder] taxPrice]],[Utilities FormatToPrice:[[[aNotification object] thisOrder] totalPrice]]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        
        [areYouSure setTag:1];
        
        [areYouSure show];
        return;
    }
    
    UIAlertView *areYouSure = [[UIAlertView alloc] initWithTitle: @"Oops" message:@"You appear to have no connection to the internet." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil];
    
    [areYouSure show];
}

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if ([alertView tag] == 1) // Order Placement
    {
        if (buttonIndex == 1)
        {
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Placed order"];
            
            [self placeOrder:[appData theOrderManager]];
            [[[appData theOrderManager] thisOrder] setStatus:@"Transmitting"];
        }
        if (buttonIndex == 2)
            [[LocalyticsSession sharedLocalyticsSession] tagEvent:@"Canceled placing an order"];
    }
}

-(void) placeOrder:(OrderManager *) anOrderManager
{
    PaymentStack* paymentStack = 
    [[PaymentStack alloc] initWithOrder:[anOrderManager thisOrder] locationState:[appData locationState]
                           successBlock:^{
                               //Push the current order on the history list
                               [[appData ordersHistory] addObject:[anOrderManager thisOrder]];
                               if ([[anOrderManager thisOrder] isEffectivelyEqual:[anOrderManager thisOrder]])
                               {
                                   //Allocate a new order
                                   [anOrderManager setOrder:[[Order alloc] init]];
                               }
                           }
                        completionBlock:^{
/*
 
 IF YOU TRY TO CHANGE THIS LINE
 
 ++++++++++++++++//++++++++++//++/+++++++++++++++//+/+++++/+++++////+++++/++///++/+++++++++++++++++++
 ++++++++++++++++++++++++/+++++++/++/+++/+++//++++///+++++++///+++///+/+++/+//++//+//+//++++//+++++++
 +++++++++++/++++++++//////++////++++////+++++++++++++///////+/++++++/////+++///++++++///++++++++++++
 +++++++++/++++++oss/:::::://////+++++/+/+ooo++sdddhyo+////+//+++/+++//+++++///+++++++/+//+///+/+++++
 +++++++++++++osyys/::::::::::::::///+yhmNNNNNNmNNNNNNmyyo++++osso::::::::///////+++///+//+++++++/+++
 +++++++++ossyyyyy/::::::::::::::::::ymNNNNNNNNNNNNNNNNNNNyyyyyyyyso+//::::::::::::://////++++/+//+++
 +++++ossyyyyyyyys:::///:::::::::::sdmNNNNNNNNNNNNNNNNNNNNdyyyyyyyyyyyyysoo+/::::::::::::::://////+++
 //++ooossssyyyyyysssys/::::::::::/smNNNNNNNNNNNNNmmNNNNNNNNdyyyyyyyyyyyyyyyys+:::::::::::::::::::::/
 :----::::::::::///+++/::::::::::::+mmmmmmdhhmdmddddddddmmmmmddyyyyyyyyyyyso+/:::::::::::::::::::::::
 :------------------------------/oohhhhhhhhdddddddhhhhhhhhhhdmNmyyhyyyso+/:::://++//:::::::::::::::::
 :------------------------------::+ydmds/+o/::::+oooyyhhdmmdyoyNNdNmo+::-----::/+ossssso++///::::::::
 :---------------------------------hNm+:-.```.`..````.:::/mdosdNNNNN/------------::/osyyyyysssso++///
 :---------------------------------mNm:--````:`..:````.--/NmmNNNNNNNs----------------:oyyyyyyyyyyysss
 ::--------------------------------mmN:--.....--/.````---hmohNNNNNNNy:----------------+yyyyyyyyyyyyyy
 so+//:://////:::------------------o/h/-------:-+:------/o/-:/sdNNNdyo+:------------:osyyyyyyyyyyyyyy
 ---..................................:/:---:/+++::---:/:.-----ydddddyo+----------:+syyyyyyyyyyyyyyyy
 `````````````````````````````````````:+/////+hdh//:::/:```--:/yddddddyo:.........-::////+++++ooooooo
 `````````````````````````````````.:oo+oys+////++///os++++sysssshddddddyo:```````````````````````....
 `````````````````````````--```-:/odddyoohddhysssyhddsosdddddddddddddddds/```````````````````````````
 `````````````````````.:+hhm+`/ooshdddddhyyhhddddhhhyhhdddddddddddddddddh+```````````````````````````
 ````````````````````-oNhmNmNodshdddddddddddddddddddhyhhddddh:+yhdddddddd/```````````````````````````
 ````````````````````smmNmNNNNNNmdddddddddddddmddddddyydddddy```-::oyhyo:````````````````````````````
 ````````````````````.omNNNNNNNNmddddhyhhhyyyyhhdyhyhyhydddds```````..```````````````````````````````
 ``````````````````````-smNNNNNNyddddyysyyhhssyyhydyyshoddddo````````````````````````````````````````
 ````````````````````````-ymNNmhyddddddhhhddhhdhdhdhhhhhdddd/````````````````````````````````````````
 ````````.`````````````````+hhhdddddddddddddddmddddddddddddd-````````````````````````````````````````
 ```````odo````````.oh-````.+yhhosddddddddddddmddddddddddddh`````````````````````````````````````````
 ```````yMM-```````:MMo```````.``/ddddddddddddmdddddddddddds`````````````````````````````````````````
 ```````yMM-```````-NMy``````````.dddddhyyddddmddddhhdddddd/`````````````````````````````````````````
 ```````mMM.````````dMN-``````````ydhyyyhdddddmdddddyyyhddd.`````````````````````````````````````````
 ```````sMM-````````hMN.``````````+dhdddddddddmdddddddhysh/``````````````````````````````````````````
 ```````:NMh:``````:mMd.``````````.sddddddddddmdddddddddd:```````````````````````````````````````````
 ``````.::d:```````-+d/:.```````````ydddddddddmdddddddddd-```````````````````````````````````````````
 `````````oo````````/y``````````````ydddddddddddddddddddd:```````````````````````````````````````````
 `````````:h````````/s``````````````hdddddddddddddddddddd:```````````````````````````````````````````
 ``````````m.```````+s``````````````ddddddddddddddddddddd-```````````````````````````````````````````
 ``````````y/```````+o``````````````dmmmmddddddddddddmmmm-```````````````````````````````````````````
 ``````````/s```````o+``````````````ddddmdddddddddddmmddm.``````````````````````````````````-::--:--:
 
 YOU'RE GONNA HAVE A BAD TIME.
 
 */
                            
                            [self dismissViewControllerAnimated:YES 
                                                     completion:^{
                                                         NSLog(@"Cancellation.");
                                                     }];
                        }
                      cancellationBlock:^{
                          [self dismissViewControllerAnimated:YES 
                                                   completion:^{
                                                       NSLog(@"Cancellation.");
                                                   }];
                      }];
    [self presentModalViewController:[paymentStack navigationController] animated:YES];
}

@end
