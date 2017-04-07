//
//  ZKAPIManager+Auth.m
//  ZKStandard
//
//  Created by Jack on 10/21/16.
//  Copyright © 2016 mushank. All rights reserved.
//

#import "ZKAPIManager+Auth.h"

@implementation ZKAPIManager (Auth)

- (NSURLSessionDataTask *)registerUserWithDeviceId:(NSString *)deviceId
                                           success:(SuccessBlock)success
                                           failure:(FailureBlock)failure
                                            notice:(NoticeBlock)notice
{
    NSString *URLString = [ZKAPIVersion1 stringByAppendingString:ZKAPIUserAuth];
    NSDictionary *pramaDic = @{@"deviceId": deviceId};
    
    return [self POST:URLString parameters:pramaDic success:success failure:failure notice:notice];
}

@end
