//
//  ZKAPIManager+Auth.h
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKAPIManager.h"

@interface ZKAPIManager (Auth)

- (NSURLSessionDataTask *)registerUserWithDeviceId:(NSString *)deviceId
                                           success:(SuccessBlock)success
                                           failure:(FailureBlock)failure
                                            notice:(NoticeBlock)notice;

@end
