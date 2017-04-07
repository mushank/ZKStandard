//
//  ZKUtils.m
//  ZKStandard
//
//  Created by Jack on 11/1/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKUtils.h"

#pragma mark - Extern functions
extern BOOL isNull(id value)
{
    if (!value || [value isEqual:[NSNull null]]) return YES;
    return NO;
}

@implementation ZKUtils

@end
