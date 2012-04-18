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
        
    }
    
    return self;
}

-(void)postToFacebook
{
    NSString *appID = @"24287653320";
    
    NSString *primaryLink = @"http://itunes.apple.com/us/app/pita-factory/id503487275?ls=1&mt=8";
    
    NSString *appName = @"Pita Factory";
    
    NSString *caption = @"Om nom nom";
    
    NSString *description = @"Order Pitas through your phone and never get out a piece of plastic again!";
    
    NSString *actionJSON = @"{\"name\" : \"Download\", \"link\": \"http://itunes.apple.com/us/app/pita-factory/id503487275?ls=1&mt=8\"}";

    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   appID, @"app_id",
                                   primaryLink, @"link",
                                   appName, @"name",
                                   caption, @"caption",
                                   description, @"description",
                                   actionJSON, @"actions",
                                   nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
}


- (void)fbDidLogin {

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
