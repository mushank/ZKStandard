//
//  NSMutableDictionary+ZKExtension.m
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "NSMutableDictionary+ZKExtension.h"

@implementation NSMutableDictionary (ZKExtension)

- (void)ZKSetSafeObject:(id)object forKey:(id<NSCopying>)key
{
    if (object == nil) {
        object = [NSNull null];
    }
    [self setObject:object forKey:key];
}

- (void)ZKSetSafeString:(id)object forKey:(id<NSCopying>)key
{
    if (object == nil) {
        object = @"";
    }
    [self setObject:object forKey:key];
}

@end
