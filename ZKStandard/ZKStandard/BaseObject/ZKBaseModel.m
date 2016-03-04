//
//  ZKBaseModel.m
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKBaseModel.h"
#import "ZKResponseEntity.h"

@interface ZKBaseModel ()

@property (nonatomic, weak) id<ZKModelCallbackDelegate> delegate;

@end

@implementation ZKBaseModel

#pragma mark - Initialization
- (instancetype)initWithCallbackDelegate:(id<ZKModelCallbackDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
    }
    return self;
}

- (instancetype)init
{
    return [self initWithCallbackDelegate:nil];
}

#pragma mark - Callback Method
- (void)pushCallbackStatus:(CallBackStatus)status requestName:(NSString *)name object:(id)object
{
    switch (status) {
        case CallbackBizSuccessStatus:
            if ([self.delegate respondsToSelector:@selector(callbackBizSuccessWithRequestName:object:)]) {
                [self.delegate callbackBizSuccessWithRequestName:name object:object];
            }
            break;
        case CallbackBizFailureStatus:
            if ([self.delegate respondsToSelector:@selector(callbackBizFailureWithRequestName:object:)]) {
                [self.delegate callbackBizFailureWithRequestName:name object:object];
            }
            break;
        case CallbackreqFailureStatus:
            if ([self.delegate respondsToSelector:@selector(callbackReqFailureWithRequestName:object:)]) {
                [self.delegate callbackReqFailureWithRequestName:name object:object];
            }
            break;
        default:
            break;
    }
}


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
