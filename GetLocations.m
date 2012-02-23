//
//  GetLocations.m
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GetLocations.h"
#import "APICallProtectedMethods.h"
#import "Location.h"

@implementation GetLocations

@synthesize locations;

+(void)getLocationsForRestaurant:(NSInteger)restaurant success:(void(^)(id))success failure:(void(^)(id,NSError*))failure{
    [self sendGETRequestForLocation:[NSString stringWithFormat:@"customer/locations/%d/", restaurant] 
                            success:success
                            failure:failure];
}

-(void)postCompletionHook{
    [super postCompletionHook];
    if(![self error]){
        NSMutableArray* locationsList = [NSMutableArray array];
        for(NSDictionary* locDict in [[self jsonData] objectForKey:@"locations"]){
            Location* location = [[Location alloc] initFromData:locDict];
            [locationsList addObject:location];
        }
        locations = locationsList;
    }
}

@end
