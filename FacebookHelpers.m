//
//  FacebookHelpers.m
//  AvocadoTest1
//
//  Created by Jake on 12-04-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookHelpers.h"

@implementation FacebookHelpers

@synthesize facebook;

static FacebookHelpers *facebookHelpers;

+(FacebookHelpers*)facebookHelpers
{
	@synchronized([FacebookHelpers class])
	{
		if (!facebookHelpers)
			facebookHelpers = [[self alloc] init];
        
		return facebookHelpers;
	}
	return nil;
}

-(id)init
{
    self = [super init];
    
    if (self) 
    {
        facebook = [[Facebook alloc] initWithAppId:@"24287653320" andDelegate:self];
        permissions = [NSArray arrayWithObjects:@"publish_stream", nil];
        message = @"I just ordered a pita!";
    }
    
    return self;
}

-(void)postToFacebook
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    if (![facebook isSessionValid]) {
        [facebook authorize:nil];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Pita Factory", @"name",
                                   @"http://itunes.apple.com/us/app/pita-factory/id503487275?ls=1&mt=8", @"link",
                                   @"Om nom nom", @"caption",
                                   @"Order Pitas through your phone and never get out a piece of plastic again!", @"description",
                                   message, @"message",              
                                   nil];

    [facebook requestWithGraphPath:@"me/feed" andParams:params andHttpMethod:@"POST" andDelegate:self];
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [facebook authorize:permissions];
}


-(void)fbDidLogout
{
    
}

-(void)fbDidNotLogin:(BOOL)cancelled
{
    
}

- (void)fbDidExtendToken:(NSString*)accessToken
               expiresAt:(NSDate*)expiresAt
{
    
}

- (void)fbSessionInvalidated
{
    
}

@end
