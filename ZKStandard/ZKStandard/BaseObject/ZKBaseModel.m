//
//  ZKBaseModel.m
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKBaseModel.h"
#import "ZKResponseEntity.h"

@implementation ZKBaseModel

#pragma mark - Network
- (void)getToken
{
    NSDictionary *parameters = @{@""    : @"parameter",
                                 @""    : @"parameter",
                                 };
    [self.networkManager getRequestWithSubPath:GET_TOKEN parameters:parameters
                               businessSuccess:^(ZKResponseEntity *bizSuccessEntity){
                                   // business succeeded, do sth.
                                   [[NSNotificationCenter defaultCenter] postNotificationName:GET_TOKEN object:nil];
                               }
                               businessFailure:^(ZKResponseEntity *bizFailureEntity){
                                   // business failed, do sth.
                                   [self retryGetToken];
                               }
                                requestFailure:^(ZKResponseEntity *reqFailureEntity){
                                    // request failed, do sth.
                                    [self retryGetToken];
                                }
                                eternalExecute:^(){
                                    // whatever, eternal execute block.
                                }];
}

#pragma mark - Private Method
- (void)retryGetToken
{
    [self performSelector:@selector(getToken) withObject:nil afterDelay:15.0];
}

- (ZKNetworkManager *)networkManager
{
    if (!_networkManager) {
        _networkManager = [ZKNetworkManager sharedManager];
    }
    return _networkManager;
}

@end
