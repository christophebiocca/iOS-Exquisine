//
//  AutomagicalCoder.m
//  AvocadoTest1
//
//  Created by Jake on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AutomagicalCoder.h"
#import "MenuComponent.h"

@implementation AutomagicalCoder

-(id)initWithCoder:(NSCoder *)aDecoder
{
    //Firstly, figure out what version this is:
    
    NSString *versionString = [aDecoder decodeObjectForKey:@"version"];
    
    //Assign the data version according to the version string
    //The possible recovery routines can check which version
    //they're loading from if it's necessary.
    harddiskDataVersion = VERSION_0_0_0;
    if (!versionString)
        harddiskDataVersion = VERSION_1_0_0;
    if ([versionString isEqualToString:@"1.1.0"])
        harddiskDataVersion = VERSION_1_1_0;
    if ([versionString isEqualToString:@"2.0.0"])
        harddiskDataVersion = VERSION_2_0_0;
    
    //Check to make sure that a version was actually identified (just as a sanity check)
    if (harddiskDataVersion == VERSION_0_0_0) {
        //Bitch and moan if we don't have the version listed
        CLLog(LOG_LEVEL_ERROR, [NSString stringWithFormat: @"Unrecognised version string: \"%@\" while loading data from harddisk",versionString]);
    }
    
    
    //Now we're gonna do some automagical loading stuff. Read the comments,
    //it should make sense.
    unsigned int varCount;
    
    Class classLoader = [self class];
    
    while ([classLoader isSubclassOfClass:[AutomagicalCoder class]]) {
        Ivar *vars = class_copyIvarList(classLoader, &varCount);
        
        for (int i = 0; i < varCount; i++) {
            Ivar var = vars[i];
            
            const char* name = ivar_getName(var);
            NSString *stringName = [NSString stringWithCString:name encoding:NSStringEncodingConversionAllowLossy];
            
            NSString *dummy = [NSString stringWithCString:ivar_getTypeEncoding(var) encoding:NSStringEncodingConversionAllowLossy];
            
            //Make sure that this ivar represents an object.
            if (!([dummy isEqualToString:@"i"]||[dummy isEqualToString:@"c"])) {
                id obj = [aDecoder decodeObjectForKey:stringName];               
                object_setIvar(self, var, obj);
                
                //We grab each of the member variables and assign them according to 
                //Their names
                //If there are recovery routines that need to check the state of
                //the potentially uninstantiated variables, we run them programatically:
                SEL aSelector = NSSelectorFromString([NSString stringWithFormat:@"%@%@",stringName,@"Recovery:"]);
                
                if ([self respondsToSelector:aSelector]) {
                    [self performSelector:aSelector withObject:aDecoder];
                }
            }
        }
        classLoader = [classLoader superclass];
    }
    
    
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    //The first thing that we always, always do is store the version information.
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
    [aCoder encodeObject:version forKey:@"version"];
    
    
    Class classLoader = [self class];
    
    while ([classLoader isSubclassOfClass:[AutomagicalCoder class]]) {
        unsigned int varCount;
        Ivar *vars = class_copyIvarList(classLoader, &varCount);
        
        for (int i = 0; i < varCount; i++) {
            Ivar var = vars[i];
            
            id variable = nil;
            
            NSString *dummy = [NSString stringWithCString:ivar_getTypeEncoding(var) encoding:NSStringEncodingConversionAllowLossy];
            
            const char* name = ivar_getName(var);
            NSString *stringName = [NSString stringWithCString:name encoding:NSStringEncodingConversionAllowLossy];
            
            //We need to make sure that this is a variable that can
            //be turned into an object
            if (!([dummy isEqualToString:@"i"]||[dummy isEqualToString:@"c"]||[dummy isEqualToString:@"I"])) {
                variable = object_getIvar(self, var);
                
                //Check to see that the variable is instantiated and is an object
                //as opposed to a base type.
                if (variable) {
                    
                    //This time, we grab each of the member variables and encode 
                    //them according to their names
                    [aCoder encodeObject:variable forKey:stringName];
                    
                    //That's it! magic!
                }
            }
        }
        classLoader = [classLoader superclass];
    }
}



@end
