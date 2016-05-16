//
//  NSDictionary+ZKExtension.m
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "NSDictionary+ZKExtension.h"

@implementation NSDictionary (ZKExtension)

- (id)ZKSafeObjectForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == [NSNull null]) {
        object = nil;
    }
    
    return object;
}

- (NSString *)ZKSafeStringForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        object = @"";
    } else if ([object isKindOfClass:[NSNumber class]]){
        object = ((NSNumber *)object).stringValue;
    }
    
    return object;
}

- (NSNumber *)ZKSafeNumberForKey:(id)key
{
    id object = [self objectForKey:key];
    
    if (object == nil || object == [NSNull null]) {
        object = @0;
    } else if ([object isKindOfClass:[NSString class]]){
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc]init];
        object = [formatter numberFromString:((NSString *)object)];
    }
    
    return object;
}

@end
