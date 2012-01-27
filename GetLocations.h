//
//  GetLocations.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "JSONAPICall.h"

@interface GetLocations : JSONAPICall{
    NSArray* locations;
}

@property(retain,readonly)NSArray* locations;

+(void)getLocationsForRestaurant:(NSInteger)restaurant success:(void(^)(id))success failure:(void(^)(id,NSError*))failure;

@end
