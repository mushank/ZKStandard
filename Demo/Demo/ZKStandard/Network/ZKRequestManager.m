//
//  ZKRequestManager.m
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 Insigma HengTian Software Ltd. All rights reserved.
//

#import "ZKRequestManager.h"
#import "Reachability.h"

static ZKRequestManager *requestManager = nil;

@implementation ZKRequestManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *basePath = [ZKNetworkUtils basePath];
        NSURL *baseUrl = [NSURL URLWithString:basePath];
        requestManager = [[ZKRequestManager alloc]initWithBaseURL:baseUrl];
    });
    
    return requestManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.requestSerializer.timeoutInterval = [ZKNetworkUtils timeoutInterval];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;
    }
    
    return self;
}

#pragma mark - Invisible Request
- (void)requestInvisiblyWithType:(ZKRequestMethodType)methodType
                         SubPath:(NSString *)subPath
                      parameters:(id)parameters
                 businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self requestEntirelyWithType:methodType
                          SubPath:subPath
                       parameters:parameters
                  businessSuccess:bizSuccessBlock
                  businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                   requestFailure:^(ZKResponseEntity *reqFailureEntity){}
                   eternalExecute:^(id object){}];
}

#pragma mark - Normal Reqeust
- (void)requestWithType:(ZKRequestMethodType)methodType
                SubPath:(NSString *)subPath
             parameters:(id)parameters
        businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
        businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
{
    [self requestEntirelyWithType:methodType
                          SubPath:subPath
                       parameters:parameters
                  businessSuccess:bizSuccessBlock
                  businessFailure:bizFailureBlock
                   requestFailure:nil
                   eternalExecute:nil];
}

#pragma mark - Entire Reqeust
- (void)requestEntirelyWithType:(ZKRequestMethodType)methodType
                        SubPath:(NSString *)subPath
                     parameters:(id)parameters
                businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                 requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                 eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:ZK_TIPS_NETWORK_NO_CONNECTION];
        return;
    }
    
    ZKLog(@"JSONParameters:%@",ZKJSONStringFromParameters(parameters));
    
    [self setHTTPHeaderField];
    
    switch (methodType) {
        case ZKRequestMethodGet: {
            [self GET:subPath
           parameters:parameters
             progress:nil
              success:^(NSURLSessionDataTask *task, id responseObject){
                  [self handleRequestSuccessWithTask:task
                                      responseObject:responseObject
                                     businessSuccess:bizSuccessBlock
                                     businessFailure:bizFailureBlock
                                      eternalExecute:eternalExecuteBlock];
              }
              failure:^(NSURLSessionDataTask *task, NSError *error){
                  [self handleRequestFailureWithTask:task
                                               error:error
                                      requestFailure:reqFailureBlock
                                      eternalExecute:eternalExecuteBlock];
              }];
            break;
        }
        case ZKRequestMethodPost: {
            [self POST:subPath
            parameters:parameters
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject){
                   [self handleRequestSuccessWithTask:task
                                       responseObject:responseObject
                                      businessSuccess:bizSuccessBlock
                                      businessFailure:bizFailureBlock
                                       eternalExecute:eternalExecuteBlock];
                   
               } failure:^(NSURLSessionDataTask *task, NSError *error){
                   [self handleRequestFailureWithTask:task
                                                error:error
                                       requestFailure:reqFailureBlock
                                       eternalExecute:eternalExecuteBlock];
               }];
            break;
        }
        case ZKRequestMethodPut: {
            [self PUT:subPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
                [self handleRequestSuccessWithTask:task
                                    responseObject:responseObject
                                   businessSuccess:bizSuccessBlock
                                   businessFailure:bizFailureBlock
                                    eternalExecute:eternalExecuteBlock];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error){
                [self handleRequestFailureWithTask:task
                                             error:error
                                    requestFailure:reqFailureBlock
                                    eternalExecute:eternalExecuteBlock];
            }];
            break;
        }
        case ZKRequestMethodDelete: {
            [self DELETE:subPath parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
                [self handleRequestSuccessWithTask:task
                                    responseObject:responseObject
                                   businessSuccess:bizSuccessBlock
                                   businessFailure:bizFailureBlock
                                    eternalExecute:eternalExecuteBlock];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error){
                [self handleRequestFailureWithTask:task
                                             error:error
                                    requestFailure:reqFailureBlock
                                    eternalExecute:eternalExecuteBlock];
            }];
            break;
        }
    }
}

#pragma mark - Private Method
- (void)handleRequestSuccessWithTask:(NSURLSessionDataTask *)task
                      responseObject:(id)responseObject
                     businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                     businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                      eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    ZKLog(@"RequestSuccess_URL: %@", task.response.URL);
    ZKLog(@"RequestSuccess_Response: %@", responseObject);
    
    ZKResponseEntity *responseEntity = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        responseEntity = [[ZKResponseEntity alloc]initWithResponseDictionary:responseObject];
    }
    if (responseEntity) {
        switch (responseEntity.status) {
            case ZKResponseStatusSuccess:
                NSAssert(bizSuccessBlock, ([NSString stringWithFormat:@"%@,%@", task.response.URL, @"businessSuccessBlock can not be nil!"]));
                bizSuccessBlock(responseEntity);
                break;
            case ZKResponseStatusFailure:
                if (bizFailureBlock) {
                    bizFailureBlock(responseEntity);
                } else {
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZK_NOTI_NETWORK_BUSINESS_FAILURE object:responseEntity.message];
                }
                break;
            case ZKResponseStatusTokenExpired:
                [[NSNotificationCenter defaultCenter] postNotificationName:ZK_NOTI_NETWORK_TOKEN_EXPIRED object:responseEntity.message];
                break;
            default:
                if (bizFailureBlock) {
                    bizFailureBlock(responseEntity);
                } else {
                    [[NSNotificationCenter defaultCenter] postNotificationName:ZK_NOTI_NETWORK_BUSINESS_FAILURE object:responseEntity.message];
                }
                break;
        }
    }
    
    if (eternalExecuteBlock) {
        responseEntity = [[ZKResponseEntity alloc]init];
        responseEntity.task = task;
        responseEntity.responseObject = responseObject;
        eternalExecuteBlock(responseEntity);
    }
}

- (void)handleRequestFailureWithTask:(NSURLSessionDataTask *)task
                               error:(NSError *)error
                      requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                      eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    ZKLog(@"RequestFailure_URL: %@", task.response.URL);
    ZKLog(@"RequestFailure_Error: %@", error);
    
    if (reqFailureBlock) {
        ZKResponseEntity *responseEntity = [[ZKResponseEntity alloc]init];
        responseEntity.task = task;
        responseEntity.error = error;
        reqFailureBlock(responseEntity);
    } else {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:ZK_TIPS_NETWORK_POOR_CONNECTION];
    }
    
    if (eternalExecuteBlock) {
        ZKResponseEntity *responseEntity = [[ZKResponseEntity alloc]init];
        responseEntity.task = task;
        responseEntity.error = error;
        eternalExecuteBlock(responseEntity);
    }
}

- (void)setHTTPHeaderField
{
    if(!ZK_STRING_IS_EMPTY(ZK_TOKEN)){
        [self.requestSerializer setValue:ZK_TOKEN forHTTPHeaderField:ZK_TOKEN_IDENTIFIER];
    }
}

- (BOOL)isReachable
{
    BOOL isReachable = self.reachabilityManager.reachable;
    if (!isReachable) {
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [reachability currentReachabilityStatus];
        if (networkStatus != NotReachable) {
            isReachable = YES;
        } else {
            isReachable = NO;
        }
    }
    return isReachable;
}

static NSString *ZKJSONStringFromParameters(NSDictionary *parameters) {
    NSError *error = nil;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&error];
    
    if (!error){
        return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    } else {
        return nil;
    }
}

@end
