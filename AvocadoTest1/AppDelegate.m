//
//  AppDelegate.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-11.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "LocalyticsSession.h"
#import "MasterView.h"
#import "MasterViewController.h"
#import "AppData.h"

@implementation AppDelegate

@synthesize window = _window, navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[LocalyticsSession sharedLocalyticsSession] startSession:@"a89ce01d2cb72e5bf8ac21f-cc230fc2-4cfd-11e1-a7ce-008545fe83d2"];
    // WE NEED OUR COOKIES, AT ALL TIMES
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    // Override point for customization after application launch.
    
    [self setWindow:[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]]];
    
    page = [[MasterViewController alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [page viewWillAppear:NO];
    [[self window] addSubview:[page masterView]];
    [[self window] makeKeyAndVisible];
    [page viewDidAppear:NO];
    
    /*
    //The main page view controller should be handling notifications.
    UILocalNotification *thisNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    
    if(thisNotification)
    {
        [page application:application didFinishLaunchingWithOptions:launchOptions];
    }*/
    
    // One line fix.
    [[UIBarButtonItem appearance] setTintColor:[Utilities fravicDarkRedColor]];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[LocalyticsSession sharedLocalyticsSession] resume];
    [[LocalyticsSession sharedLocalyticsSession] upload];
    [[AppData appData] saveDataToDisk];
    //[page saveDataToDisk];
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // WE NEED OUR COOKIES, AT ALL TIMES
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
    /*
    [page initiateMenuRefresh];
    [page getLocation];
    [page updateOrderHistory];
    [page updatePendingButtonState];
    [page resetApplicationBadgeNumber];*/
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
   
    if ([UIApplication sharedApplication].applicationIconBadgeNumber) {
        [UIApplication sharedApplication].applicationIconBadgeNumber=0;
    }
    
    if ((![[AppData appData] initialized]) && (![[AppData appData] initializing])) {
        [[AppData appData] initializeFromServer];
    }
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [[LocalyticsSession sharedLocalyticsSession] close];
    [[LocalyticsSession sharedLocalyticsSession] upload];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[[FacebookHelpers facebookHelpers] facebook] handleOpenURL:url]; 
}

-(void) application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
}

@end
