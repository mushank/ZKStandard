//
//  ZKResponseEntity.m
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKResponseEntity.h"

@implementation ZKResponseEntity

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary
{
    self = [super init];
    if (self) {
        self.status     = [[responseDictionary objectForKey:ZKResponseStatusKey] integerValue];
        self.message    = [responseDictionary  objectForKey:ZKResponseMessageKey];
        self.data       = [responseDictionary  objectForKey:ZKResponseDataKey];
    }
    
    return self;
}

@end
