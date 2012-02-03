//
//  APICallProtectedMethods.h
//  AvocadoTest1
//
//  Created by Christophe Biocca on 12-01-26.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface APICall(ProtectedMethods)

-(void)postCompletionHook;
// We have both of these because it enforces people 
// knowing what they're doing with the exception handling.
-(void)setError:(NSError*)theError;
-(void)replaceError:(NSError*)replacementError;
// Marks a connection as completed ahead of time, use only if you know what you're doing.
-(void)complete;

@end
