//
//  NSArray+ZKExtension.m
//  HTMF
//
//  Created by Jack on 4/25/16.
//  Copyright © 2016 Insigma HengTian Software Ltd. All rights reserved.
//

#import "NSArray+ZKExtension.h"

@implementation NSArray (ZKExtension)

- (id)ZKSafeObjectAtIndex:(NSUInteger)index
{
    NSAssert(index < self.count, @"Your array index %lu beyond bounds count = %lu", (unsigned long)index, (unsigned long)self.count);
    
    id object = nil;
    
    if (index < self.count) {
        object = [self objectAtIndex:index];
    }

    return object;
}

@end
