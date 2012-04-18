//
//  FacebookHelpers.h
//  AvocadoTest1
//
//  Created by Jake on 12-04-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookHelpers : NSObject <FBSessionDelegate, FBRequestDelegate, FBDialogDelegate>
{
    Facebook *facebook;
}

@property (retain) Facebook *facebook;

+(FacebookHelpers*)facebookHelpers;

-(void)postToFacebook;

@end
