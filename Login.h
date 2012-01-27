//
//  Login.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "APICall.h"

@interface Login : APICall

+(void)login:(void(^)(id))success;

@end
