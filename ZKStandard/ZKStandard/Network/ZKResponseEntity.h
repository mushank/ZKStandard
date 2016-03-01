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

#pragma mark - Request success response property and method
@property (nonatomic) ZKResponseStatus status;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) id data;

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary;

#pragma mark - Request failure response property
@property (strong, nonatomic) NSURLSessionDataTask *task;
@property (strong, nonatomic) NSError *error;

@end
