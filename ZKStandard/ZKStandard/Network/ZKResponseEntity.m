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
        self.status     = [[responseDictionary objectForKey:ZKNETWORK_CODE] integerValue];
        self.message    = [responseDictionary  objectForKey:ZKNETWORK_MSG];
        self.data       = [responseDictionary  objectForKey:ZKNETWORK_DATA];
    }
    return self;
}

@end
