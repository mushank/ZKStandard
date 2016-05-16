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

#pragma mark - Request Success Response
@property (nonatomic, assign) ZKResponseStatus status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) id data;

- (instancetype)initWithResponseDictionary:(NSDictionary *)responseDictionary;

#pragma mark - Request Failure Response
@property (nonatomic, strong) NSURLSessionDataTask *task;
@property (nonatomic, strong) NSError *error;

#pragma mark - Eternal Execute Response
@property (nonatomic, strong) id responseObject;

@end
