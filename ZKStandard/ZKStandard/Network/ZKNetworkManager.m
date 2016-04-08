//
//  ZKNetworkManager.m
//  ZKStandard
//
//  Created by Jack on 12/29/15.
//  Copyright © 2015 Insigma HengTian Software Ltd. All rights reserved.
//

#import "ZKNetworkManager.h"
#import "ZKNetworkUtils.h"
#import "ZKResponseEntity.h"
#import "Reachability.h"

typedef NS_ENUM(NSInteger, HTMFStatusCode) {
    HTMF_STATUS_FAILURE        = 0,             /* 业务错误 */
    HTMF_STATUS_SUCCESS        = (1UL << 0),    /* 正常 */
    HTMF_STATUS_NEEDLOGIN      = (1UL << 1),    /* 需要登录 */
    HTMF_STATUS_NEEDREGISTER   = (1UL << 2),    /* 设备未注册,需要短信或邮件注册 */
    HTMF_STATUS_NEEDPASSWORD   = (1UL << 3),    /* 设备需要重新输入密码登录 */
    HTMF_STATUS_ILLEGAL        = (1UL << 4),    /* 非法请求,要求客户端重启 */
    HTMF_STATUS_BAN            = (1UL << 5),    /* 禁止使用,要求客户端关闭 */
};

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
        self.requestSerializer.timeoutInterval = [ZKNetworkUtils timeoutInterval];
        self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        self.securityPolicy.allowInvalidCertificates = YES;
        self.securityPolicy.validatesDomainName = NO;
    }
    return self;
}

#pragma mark - Invisible Get / Post / Put / Delete
- (void)getRequestInvisiblyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self getRequestEntirelyWithSubPath:subPath
                             parameters:parameters
                        businessSuccess:bizSuccessBlock
                        businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                         requestFailure:^(ZKResponseEntity *reqFailureEntity){}
                         eternalExecute:^(id object){}];
}

- (void)postRequestInvisiblyWithSubPath:(NSString *)subPath
                             parameters:(id)parameters
                        businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self postRequestEntirelyWithSubPath:subPath
                              parameters:parameters
                         businessSuccess:bizSuccessBlock
                         businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                          requestFailure:^(ZKResponseEntity *reqFailureEntity){}
                          eternalExecute:^(id object){}];
}

- (void)putRequestInvisiblyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self putRequestEntirelyWithSubPath:subPath
                             parameters:parameters
                        businessSuccess:bizSuccessBlock
                        businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                         requestFailure:^(ZKResponseEntity *reqFailureEntity){}
                         eternalExecute:^(id object){}];
}

- (void)deleteRequestInvisiblyWithSubPath:(NSString *)subPath
                               parameters:(id)parameters
                          businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
{
    [self deleteRequestEntirelyWithSubPath:subPath
                                parameters:parameters
                           businessSuccess:bizSuccessBlock
                           businessFailure:^(ZKResponseEntity *bizFailureEntity){}
                            requestFailure:^(ZKResponseEntity *reqFailureEntity){}
                            eternalExecute:^(id object){}];
}

#pragma mark - Normal Get / Post / Put / Delete
- (void)getRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
{
    [self getRequestEntirelyWithSubPath:subPath
                             parameters:parameters
                        businessSuccess:bizSuccessBlock
                        businessFailure:bizFailureBlock
                         requestFailure:nil
                         eternalExecute:nil];
}

- (void)postRequestWithSubPath:(NSString *)subPath
                    parameters:(id)parameters
               businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
               businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
{
    [self postRequestEntirelyWithSubPath:subPath
                              parameters:parameters
                         businessSuccess:bizSuccessBlock
                         businessFailure:bizFailureBlock
                          requestFailure:nil
                          eternalExecute:nil];
}

- (void)putRequestWithSubPath:(NSString *)subPath
                   parameters:(id)parameters
              businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
              businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
{
    [self putRequestEntirelyWithSubPath:subPath
                             parameters:parameters
                        businessSuccess:bizSuccessBlock
                        businessFailure:bizFailureBlock
                         requestFailure:nil
                         eternalExecute:nil];
}

- (void)deleteRequestWithSubPath:(NSString *)subPath
                      parameters:(id)parameters
                 businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                 businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
{
    [self deleteRequestEntirelyWithSubPath:subPath
                                parameters:parameters
                           businessSuccess:bizSuccessBlock
                           businessFailure:bizFailureBlock
                            requestFailure:nil
                            eternalExecute:nil];
}

#pragma mark - Entire Get / Post / Put / Delete
- (void)getRequestEntirelyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                      businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                       requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                       eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:NETWORK_NOTREACHABLE_MSG];
        return;
    }
    
    [self setToken];
    
    ZKLog(@"parameters:%@",ZKJSONStringFromParameters(parameters));
    
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
}

- (void)postRequestEntirelyWithSubPath:(NSString *)subPath
                            parameters:(id)parameters
                       businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                       businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                        requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                        eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:NETWORK_NOTREACHABLE_MSG];
        return;
    }
    
    [self setToken];
    
    ZKLog(@"parameters:%@",ZKJSONStringFromParameters(parameters));
    
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
}

- (void)putRequestEntirelyWithSubPath:(NSString *)subPath
                           parameters:(id)parameters
                      businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                      businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                       requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                       eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:NETWORK_NOTREACHABLE_MSG];
        return;
    }
    
    [self setToken];
    
    ZKLog(@"parameters:%@",ZKJSONStringFromParameters(parameters));
    
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
}

- (void)deleteRequestEntirelyWithSubPath:(NSString *)subPath
                              parameters:(id)parameters
                         businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                         businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                          requestFailure:(ZKRequestFailureBlock)reqFailureBlock
                          eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    if (![self isReachable]) {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:NETWORK_NOTREACHABLE_MSG];
        return;
    }
    
    [self setToken];
    
    ZKLog(@"parameters:%@",ZKJSONStringFromParameters(parameters));
    
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
}

#pragma mark - Private Method
- (void)handleRequestSuccessWithTask:(NSURLSessionDataTask *)task
                      responseObject:(id)responseObject
                     businessSuccess:(ZKBusinessSuccessBlock)bizSuccessBlock
                     businessFailure:(ZKBusinessFailureBlock)bizFailureBlock
                      eternalExecute:(ZKEternalExecuteBlock)eternalExecuteBlock
{
    ZKLog(@"RequestSuccess_Task_URL: %@",task.response.URL);
    ZKLog(@"RequestSuccess_Response: %@",responseObject);
    
    /********** HTMF过滤层处理开始 **********/
    if ([task.response isKindOfClass:[NSHTTPURLResponse class]]) {
        NSDictionary *headerFieldsDic = ((NSHTTPURLResponse *)(task.response)).allHeaderFields;
        ZKLog(@"Task_AllHeaderFields: %@",headerFieldsDic);
        NSString *returnCode    = [headerFieldsDic valueForKey:@"ReturnCode"];
        NSString *message       = [headerFieldsDic valueForKey:@"Message"];
        NSInteger status        = [returnCode intValue];
        if (returnCode != nil) {
            switch (status) {
                case HTMF_STATUS_ILLEGAL:   // HTMF Token Expired
                case HTMF_STATUS_BAN:       // HTMF Device Auth Expired
                default:                    // HTMF Other Error Cases
                    [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_TOKEN_EXPIRED object:message];
                    return;
            }
        }
    }
    /********** HTMF过滤层处理完毕 **********/
    
    
    ZKResponseEntity *responseEntity = nil;
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        responseEntity = [[ZKResponseEntity alloc]initWithResponseDictionary:responseObject];
    }
    if (responseEntity != nil) {
        switch (responseEntity.status) {
            case ZKResponseStatusSuccess:
                NSAssert(bizSuccessBlock, ([NSString stringWithFormat:@"%@,%@", [[task currentRequest].URL relativeString], @"businessSuccessBlock can not be nil!"]));
                bizSuccessBlock(responseEntity);
                break;
            case ZKResponseStatusFailure:
                if (bizFailureBlock) {
                    bizFailureBlock(responseEntity);
                } else {
                    [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_BUSINESS_FAILURE object:responseEntity.message];
                }
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
    ZKLog(@"RequestFailure_Task_URL: %@",task.response.URL);
    ZKLog(@"RequestFailure_Error: %@",error);
    
    if (reqFailureBlock) {
        ZKResponseEntity *responseEntity = [[ZKResponseEntity alloc]init];
        responseEntity.task = task;
        responseEntity.error = error;
        reqFailureBlock(responseEntity);
    } else {
        [[NSNotificationCenter defaultCenter]postNotificationName:ZK_NOTI_NETWORK_REQUEST_FAILURE object:NETWORK_REQUESTFAILURE_MSG];
    }
    
    if (eternalExecuteBlock) {
        ZKResponseEntity *responseEntity = [[ZKResponseEntity alloc]init];
        responseEntity.task = task;
        responseEntity.error = error;
        eternalExecuteBlock(responseEntity);
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

- (void)setToken
{
    if(!ZK_IS_NULL(ZK_TOKEN)){
        [self.requestSerializer setValue:ZK_TOKEN forHTTPHeaderField:ZK_TOKEN_IDENTIFIER];
    }
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
