//
//  ZKResponseEntity.h
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZKAPIConstants.h"

@interface ZKResponseEntity : NSObject

@property (nonatomic) ZKResponseStatus status;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) id data;

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary;

@end
