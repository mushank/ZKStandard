//
//  ZKBaseModel.m
//  ZKStandard
//
//  Created by Jack on 12/27/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKBaseModel.h"

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
- (void)pushCallbackSuccessWithRequestName:(NSString *)name object:(id)object
{
    if ([self.delegate respondsToSelector:@selector(callbackBizSuccessWithRequestName:object:)]) {
        [self.delegate callbackBizSuccessWithRequestName:name object:object];
    }
}

- (void)pushCallbackStatus:(ZKCallBackStatusType)status requestName:(NSString *)name object:(id)object
{
    switch (status) {
        case ZKCallbackStatusBizSuccess:
            if ([self.delegate respondsToSelector:@selector(callbackBizSuccessWithRequestName:object:)]) {
                [self.delegate callbackBizSuccessWithRequestName:name object:object];
            }
            break;
        case ZKCallbackStatusBizFailure:
            if ([self.delegate respondsToSelector:@selector(callbackBizFailureWithRequestName:object:)]) {
                [self.delegate callbackBizFailureWithRequestName:name object:object];
            }
            break;
        case ZKCallbackStatusreqFailure:
            if ([self.delegate respondsToSelector:@selector(callbackReqFailureWithRequestName:object:)]) {
                [self.delegate callbackReqFailureWithRequestName:name object:object];
            }
            break;
        default:
            break;
    }
}

#pragma mark - Network
- (void)fetchToken
{
    NSDictionary *parameters = @{@""    : @"parameter",
                                 @""    : @"parameter",
                                 };
    [self.requestManager requestEntirelyWithType:ZKRequestMethodPost SubPath:ZK_AUTH parameters:parameters
                                 businessSuccess:^(ZKResponseEntity *bizSuccessEntity){
                                     // business succeeded, do sth.
                                 }
                                 businessFailure:^(ZKResponseEntity *bizFailureEntity){
                                     // business failed, do sth.
                                     [self retryGetToken];
                                 }
                                  requestFailure:^(ZKResponseEntity *reqFailureEntity){
                                      // request failed, do sth.
                                      [self retryGetToken];
                                  }
                                  eternalExecute:^(id object){
                                      // whatever, eternal execute block.
                                  }];
}

#pragma mark - Private Method
- (void)retryGetToken
{
    [self performSelector:@selector(fetchToken) withObject:nil afterDelay:15.0];
}

- (ZKRequestManager *)requestManager
{
    if (!_requestManager) {
        _requestManager = [ZKRequestManager sharedInstance];
    }
    return _requestManager;
}

@end
