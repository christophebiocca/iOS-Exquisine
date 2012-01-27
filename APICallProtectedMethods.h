//
//  APICallProtectedMethods.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface APICall(ProtectedMethods)

-(void)postCompletionHook;
-(void)setError:(NSError*)theError;

@end
