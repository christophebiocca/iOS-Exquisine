//
//  Location.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-27.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface Location : NSObject{
    NSString* primaryKey;
}

-(id)initFromData:(NSDictionary*)inputData;

@property(retain,readonly)NSString* primaryKey;

@end
