//
//  ZKNetworkManager.m
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 mushank. All rights reserved.
//

#import "ZKNetworkManager.h"
#import "ZKNetworkUtils.h"
#import "ZKResponseEntity.h"
#import "Reachability.h"

static NSString *kNetworkNotReachableMessage = @"无网络连接";
static NSString *kNetworkRequestFailureMessage = @"网络不给力";

static ZKNetworkManager *networkManager = nil;

@implementation ZKNetworkManager

+ (instancetype)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *baseUrlString = [ZKNetworkUtils baseServerPath];
        NSURL *baseUrl = [NSURL URLWithString:baseUrlString];
        networkManager = [[ZKNetworkManager alloc]initWithBaseURL:baseUrl];
    });
    return networkManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer.timeoutInterval = [ZKNetworkUtils timeoutInterval];
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

#pragma mark - Invisible Get & Invisible Post
- (void)getRequestInvisiblyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self getRequestWithSubPath:subPath
                     parameters:parameters
                businessSuccess:bizSuccessBlock
                businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                 requestFailure:^(ZKResponseEntity *reqFailureEntity){}
                 eternalExecute:^(){}];
}

- (void)postRequestInvisiblyWithSubPath:(NSString *)subPath
                             parameters:(id)parameters
                        businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self postRequestWithSubPath:subPath
                      parameters:parameters
                 businessSuccess:bizSuccessBlock
                 businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                  requestFailure:^(ZKResponseEntity *httpFailureEntity){}
                  eternalExecute:^(){}];
}

#pragma mark - Terse Get & Terse Post
- (void)getRequestTerselyWithSubPath:(NSString *)subPath
                          parameters:(id)parameters
                     businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self getRequestWithSubPath:subPath
                     parameters:parameters
                businessSuccess:bizSuccessBlock
                businessFailure:nil
                 requestFailure:nil
                 eternalExecute:nil];
}

- (void)postRequestTerselyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self postRequestWithSubPath:subPath
                      parameters:parameters
                 businessSuccess:bizSuccessBlock
                 businessFailure:nil
                  requestFailure:nil
                  eternalExecute:nil];
}

#pragma mark - Normal Get & Normal Post
- (void)getRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
               requestFailure:(ZKRequestFailureBlock)reqFailureBlock
               eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:kNetworkNotReachableMessage];
    }
    [self.requestSerializer setValue:TOKEN forHTTPHeaderField:@"Token"];
    
    [self GET:subPath
   parameters:parameters
     progress:nil
      success:^(NSURLSessionDataTask *task, id responseObject){
          ZKResponseEntity *responseEntity = nil;
          if ([responseObject isKindOfClass:[NSDictionary class]]) {
              responseEntity = [[ZKResponseEntity alloc]initWithResponseDictionary:responseObject];
          }
          
          [self handleRequestSuccessWithTask:task
                               responseEtity:responseEntity
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
}

- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
               businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
               businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:kNetworkNotReachableMessage];
    }
    [self.requestSerializer setValue:TOKEN forHTTPHeaderField:@"Token"];
    
    [self POST:subPath
    parameters:parameters
      progress:nil
       success:^(NSURLSessionDataTask *task, id responseObject){
           ZKResponseEntity *responseEntity = nil;
           if ([responseObject isKindOfClass:[NSDictionary class]]) {
               responseObject = [[ZKResponseEntity alloc]initWithResponseDictionary:responseObject];
           }
           [self handleRequestSuccessWithTask:task
                                responseEtity:responseEntity
                              businessSuccess:bizSuccessBlock
                              businessFailure:bizFailureBlock
                               eternalExecute:eternalExecuteBlock];
           
    } failure:^(NSURLSessionDataTask *task, NSError *error){
        [self handleRequestFailureWithTask:task
                                     error:error
                            requestFailure:reqFailureBlock
                            eternalExecute:eternalExecuteBlock];
    }];
}

#pragma mark - Private Method
- (void)handleRequestSuccessWithTask:(NSURLSessionDataTask *)task
                       responseEtity:(ZKResponseEntity *)responseEntity
                     businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                     businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                      eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    switch (responseEntity.status) {
        case ZKResponseStatusSuccess:
            NSAssert(bizSuccessBlock, ([NSString stringWithFormat:@"%@,%@", [[task currentRequest].URL relativeString], @"businessSuccessBlock can not be nil!"]));
            bizSuccessBlock(responseEntity);
            break;
            /*
        case ZKResponseStatusFailure:
            if (businessFailureBlock) {
                businessFailureBlock(responseEntity);
            } else {
                [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_BUSINESSUNIVERSIAL object:responseEntity.message];
            }
            break;
             */
        case ZKResponseStatusSessionExpired:
            [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_SESSION_EXPIRED object:responseEntity.message];
            break;
        case ZKResponseStatusTokenExpired:
            [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_TOKEN_EXPIRED object:responseEntity.message];
            break;
        default:
            if (bizFailureBlock) {
                bizFailureBlock(responseEntity);
            } else {
                [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_BUSINESS_FAILURE object:responseEntity.message];
            }
            break;
    }
    
    if (eternalExecuteBlock) {
        eternalExecuteBlock();
    }
}

- (void)handleRequestFailureWithTask:(NSURLSessionDataTask *)task
                               error:(NSError *)error
                      requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                      eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (reqFailureBlock) {
        ZKResponseEntity *reqFailureEntity = [[ZKResponseEntity alloc]init];
        reqFailureEntity.task = task;
        reqFailureEntity.error = error;
        reqFailureBlock(reqFailureEntity);
    } else {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:kNetworkRequestFailureMessage];
    }
    
    if (eternalExecuteBlock) {
        eternalExecuteBlock();
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


@end
