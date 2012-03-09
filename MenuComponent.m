//
//  MenuComponent.m
//  AvocadoTest1
//
//  Created by Jake on 12-01-16.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MenuComponent.h"

NSString* MENU_COMPONENT_NAME_CHANGED = @"CroutonLabs/MenuComponentNameChanged";
NSString* MENU_COMPONENT_DESC_CHANGED = @"CroutonLabs/MenuComponentDescChanged";
NSString* MENU_COMPONENT_PK_CHANGED = @"CroutonLabs/MenuComponentPrimaryKeyChanged";

@implementation MenuComponent

@synthesize name;
@synthesize desc;
@synthesize primaryKey;

-(void)setName:(NSString *)aName
{
    name = aName;
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_COMPONENT_NAME_CHANGED object:self];
}

-(void)setDesc:(NSString *)aDesc
{
    desc = aDesc;
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_COMPONENT_DESC_CHANGED object:self];
}

-(void)setPrimaryKey:(NSInteger)aPrimaryKey
{
    primaryKey = aPrimaryKey;
    [[NSNotificationCenter defaultCenter] postNotificationName:MENU_COMPONENT_PK_CHANGED object:self];
}

-(MenuComponent *)initFromData:(NSDictionary *)inputData
{
    name = [inputData objectForKey:@"name"];
    primaryKey = [[inputData objectForKey:@"pk"] integerValue];
    desc = [inputData objectForKey:@"description"];
    if(!desc || ((id)desc == [NSNull null])){
        desc = @"";
    }
    
    return self;
}

-(void) nameRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_1:
            name = [decoder decodeObjectForKey:@"name"];
        case VERSION_1_0_0:
            break;
        default:
            break;
    }
}

-(void) descRecovery:(NSCoder *)decoder
{
    switch (harddiskDataVersion) {
        case VERSION_0_0_0:
            //fall through to next
        case VERSION_1_0_1:
            desc = [decoder decodeObjectForKey:@"desc"];
        case VERSION_1_0_0:
            break;
        default:
            break;
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        //base types can't be automagically coded. This should really
        //be switched to an automagical type.
        primaryKey = [[aDecoder decodeObjectForKey:@"primary_key"] integerValue];
    }
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:[NSString stringWithFormat:@"%i",primaryKey] forKey:@"primary_key"];
}

-(MenuComponent *)copy
{
    MenuComponent *returnMenuComponent = [[MenuComponent alloc] init];
    
    [returnMenuComponent setName:name];
    [returnMenuComponent setDesc:desc];
    [returnMenuComponent setPrimaryKey:primaryKey];
    
    return returnMenuComponent;
}

-(NSString *)descriptionWithIndent:(NSInteger)indentLevel
{
    NSString *padString = [@"" stringByPaddingToLength:(indentLevel*4) withString:@" " startingAtIndex:0];
    
    NSMutableString *output = [[NSMutableString alloc] initWithCapacity:0];
    
    [output appendFormat:@"%@name:%@ \n",padString,name];
    [output appendFormat:@"%@desc:%@ \n",padString,desc];
    [output appendFormat:@"%@primary key:%lu \n",padString, (unsigned long) primaryKey];
    
    return output;
}

-(NSString *)description
{
    return [self descriptionWithIndent:0];
}

@end
