#import "NSObject+SubclassEnumeration.h"
#import <objc/runtime.h>

@implementation NSObject (SubclassEnumeration)

+ (NSArray*) subclasses {
    static BOOL initialized = NO;
    static NSMutableDictionary* classMap = nil;
    const Class thisClass = self;
    
    @synchronized([NSObject class]){
        if(!initialized){
            classMap = [NSMutableDictionary dictionary];
            Class               superClass;
            Class				*classes = NULL;
            Class				*current;
            int					count, index;
            
            count = objc_getClassList(NULL, 0);
            
            if (count) {
                classes = (Class *)malloc(sizeof(Class) * count);
                NSAssert (classes != NULL, @"Memory Allocation Failed in [NSObject +subclasses].");
                
                (void) objc_getClassList(classes, count);
            }
            
            if (classes) {
                current = classes;
                
                for (index = 0; index < count; ++index, ++current) {
                    superClass = current[0];
                    while ((superClass = class_getSuperclass(superClass))){
                        NSMutableArray* subclassList = [classMap objectForKey:superClass];
                        if(!subclassList){
                            subclassList = [NSMutableArray array];
                            [classMap setObject:subclassList forKey:superClass];
                        }
                        [subclassList addObject:current[0]];
                    }
                }
                
                free(classes);
            }
            initialized = YES;
        }
    }
    
    return [classMap objectForKey:thisClass];
}

@end